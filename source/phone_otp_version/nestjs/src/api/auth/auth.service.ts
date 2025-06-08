/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import {BadRequestException, ForbiddenException, HttpException, Injectable} from "@nestjs/common";
import {CheckMethodDto, CommonAuthDto, LoginDto, LogoutDto, RegisterDto,} from "./dto/login.dto";
import date from "date-and-time";
import bcrypt from "bcrypt";
import {JwtService} from "@nestjs/jwt";
import {UserService} from "../user_modules/user/user.service";
import geoIp from "geoip-lite";
import {remove} from "remove-accents";
import {UserDeviceService} from "../user_modules/user_device/user_device.service";
import {AuthEmailMethod, AuthMethod, IUser} from "../user_modules/user/entities/user.entity";
import {AppConfigService} from "../app_config/app_config.service";
import {isUUID} from "class-validator";
import {ConfigService} from "@nestjs/config";
import {UserCountryService} from "../user_modules/user_country/user_country.service";
import {
    AccessTokenType,
    MailType,
    Platform,
    PushTopics,
    RegisterMethod,
    RegisterStatus,
    VPushProvider
} from "../../core/utils/enums";
import {i18nApi, resOK} from "../../core/utils/res.helpers";
import ResetPasswordDto from "./dto/reset.password.dto";
import {newMongoObjId} from "../../core/utils/utils";
import {JwtDecodeRes} from "../../core/utils/interfaceces";
import {FileUploaderService} from "../../common/file_uploader/file_uploader.service";
import {NotificationEmitterService} from "../../common/notification_emitter/notification_emitter.service";
import {MailEmitterService} from "../mail/mail.emitter.service";
import {auth} from "firebase-admin";
import {QrSessionService} from "../qr_session/qr_session.service";
import {MongoIdDto} from "../../core/common/dto/mongo.id.dto";


@Injectable()
export class AuthService {

    constructor(
        private readonly uploaderService: FileUploaderService,
        private readonly jwtService: JwtService,
        private readonly userService: UserService,
        private readonly appConfigService: AppConfigService,
        private readonly configService: ConfigService,
        private readonly userDevice: UserDeviceService,
        private readonly mailEmitterService: MailEmitterService,
        private readonly userCountryService: UserCountryService,
        private readonly notificationEmitterService: NotificationEmitterService,
        private readonly qrSessionService: QrSessionService
    ) {
    }

    async register(dto: RegisterDto) {
        let countryData = geoIp.lookup(dto.ip);
        let authMethods: AuthMethod;
        let method = dto.method;
        if (method != RegisterMethod.email) {
            let user = await this.checkMethod({
                authId: dto.authId,
                authType: dto.method,
            });
            if (user) {
                ///get this user and sign it
                await this._pushNotificationSubscribe(dto.pushKey, dto.platform);
                return this.getLoginUserDeviceData(user._id, user.registerStatus, dto);
            } else {
                //create the social user here!!!
                authMethods = new AuthMethod(dto.method, dto.authId)
            }
        }
        let isByEmail = method == RegisterMethod.email
        let isByPhone = method == RegisterMethod.phone
        let isByGmail = method == RegisterMethod.gmail
        let isByApple = method == RegisterMethod.apple

        if (!isByPhone) {
            let foundedUser: IUser = await this.userService.findOneByEmail(
                dto.email,
                "email"
            );
            if (foundedUser) throw new BadRequestException(i18nApi.userAlreadyRegisterString);
        }
        if (isByEmail) {
            authMethods = new AuthEmailMethod(dto.method, dto.email, dto.password)
        }


        const uniqueCode = await this.generateUniqueCode();
        let appConfig = await this.appConfigService.getConfig();

        let createdUser: IUser = await this.userService.create({
            email: isByPhone ? null : dto.email,
            phone: isByPhone ? dto.phone : null,
            fullName: dto.fullName,
            authMethods: [authMethods],
            isBusiness:dto.isBusiness,
            bio: null,
            uniqueCode: uniqueCode,
            registerStatus: appConfig.userRegisterStatus,
            fullNameEn: remove(dto.fullName),
            address: countryData,
            lastSeenAt: new Date(),
            // @ts-ignore
            lastMail: {},
            userImage: appConfig.userIcon
        });
        if (countryData) {
            let countryId = await this.userCountryService.setUserCountry(createdUser._id, countryData.country);
            await this.userService.findByIdAndUpdate(createdUser._id, {
                countryId
            });
        }
        let accessToken = await this.deleteDevicesAndCreateNew({
            userId: createdUser._id,
            session: null,
            language: dto.language,
            platform: dto.platform,
            ip: dto.ip,
            deviceInfo: dto.deviceInfo,
            pushKey: dto.pushKey,
            userDeviceId: dto.deviceId,
            authId: dto.authId
        });
        if (dto.imageBuffer) {
            let res = await this.uploaderService.putImageCropped(dto.imageBuffer, createdUser._id);
            await this.userService.findByIdAndUpdate(createdUser._id, {
                userImage: res
            });
        }
        let config = await this.appConfigService.getConfig();
        await this._pushNotificationSubscribe(dto.pushKey, dto.platform);
        return {
            accessToken: accessToken,
            "status": config.userRegisterStatus
        };
    }

    async login(dto: LoginDto, isDev: boolean) {
        let method = dto.method;
        if (method != RegisterMethod.email) {
            let user = await this.checkMethod({
                authId: dto.authId,
                authType: dto.method,
            });
            if (user) {
                ///get this user and sign it
                await this._pushNotificationSubscribe(dto.pushKey, dto.platform);
                return this.getLoginUserDeviceData(user._id, user.registerStatus, dto);
            } else {
                throw new BadRequestException("You must register this user first since he is social and not have account so register it first and send the name of him!!")
            }
        }

        let foundedUser: IUser = await this.userService.findOneByEmailOrThrow(
            dto.email,
            "authMethods userDevice lastMail banTo email registerStatus deletedAt"
        );


        let emailMethod: any = foundedUser
            .authMethods
            .find((method) => method.type === 'email' && method.identifier === foundedUser.email);
        if (!emailMethod) throw new BadRequestException("If you login by GMAIL OR APPLE please login with the same provider!")
        await this.comparePassword(dto.password, emailMethod.password)
        if (foundedUser.banTo) throw new BadRequestException(i18nApi.yourAccountBlockedString);
        let countryData = geoIp.lookup(dto.ip);
        let countryId;
        if (countryData) {
            countryId = await this.userCountryService.setUserCountry(foundedUser._id, countryData.country);
        }
        await this.userService.findByIdAndUpdate(foundedUser._id, {
            address: countryData,
            countryId: countryId
        });
        await this._pushNotificationSubscribe(dto.pushKey, dto.platform);
        return await this.getLoginUserDeviceData(foundedUser._id, foundedUser.registerStatus, dto);

    }


    async sendOtpResetPassword(email: string, isDev: boolean) {
        let usr = await this.userService.findOneByEmailOrThrow(email.toLowerCase(), "email fullName userImages verifiedAt lastMail");
        let code = await this.mailEmitterService.sendConfirmEmail(usr, MailType.ResetPassword, isDev)
        await this.userService.findByIdAndUpdate(usr._id, {
            lastMail: {
                type: MailType.ResetPassword,
                sendAt: new Date(),
                code: code,
                expired: false
            }
        });
        if (isDev) {
            return "Password reset code has been send to your email " + code;
        }
        return "Password reset code has been send to your email";
    }

    async getWebScanQr(deviceId?: string) {
        if (!deviceId || deviceId.length == 0) throw new BadRequestException("deviceId is required")
        let res = await this.qrSessionService.create({
            exp: Date.now() + 25000, // 25 seconds in milliseconds
            deviceId: deviceId,
            isAccepted: false,
        })
        return res[0]
    }
    async verifyOtpResetPassword(dto: ResetPasswordDto) {
        let user = await this.userService.findOneByEmailOrThrow(dto.email, "lastMail");
        if (!user.lastMail || !user.lastMail.code) {
            throw new BadRequestException(i18nApi.noCodeHasBeenSendToYouToVerifyYourEmailString);
        }
        let appConfig = await this.appConfigService.getConfig();
        let min = parseInt(date.subtract(new Date(), user.lastMail.sendAt).toMinutes().toString(), 10);
        if (user.lastMail.expired || min > appConfig.maxExpireEmailTime) {
            throw new BadRequestException(i18nApi.codeHasBeenExpiredString);
        }
        if (user.lastMail.type != MailType.ResetPassword) {
            throw new BadRequestException("Cant process with the mail type");
        }
        if (user.lastMail.code == dto.code) {
            await this.userService.findByIdAndUpdate(user._id, {
                "lastMail.expired": true,
                "password": dto.newPassword
            });
            return "Password has been reset successfully";
        } else {
            throw new BadRequestException(i18nApi.invalidCodeString);
        }
    }

    async getVerifiedUser(accessToken: string) {
        let jwtDecodeRes = this._jwtVerify(accessToken);
        let user: IUser = await this.userService.findById(
            jwtDecodeRes.userId,
            "fullName fullNameEn verifiedAt userImage userType banTo deletedAt registerStatus"
        );
        if (!user) throw new ForbiddenException(i18nApi.whileAuthCanFindYouString);
        user._id = user._id.toString();
        this.userLoginValidate(user);
        let device = await this.userDevice.findById(jwtDecodeRes.deviceId, "_id platform");
        if (!device) throw new HttpException(i18nApi.userDeviceSessionEndDeviceDeletedString, 450);
        user.currentDevice = device;
        return {user, authId: jwtDecodeRes.authId}
    }


    async logOut(dto: LogoutDto) {
        if (dto.logoutFromAll == true) {
            let foundedUser: IUser = await this.userService.findById(
                dto.myUser._id,
                "userDevice verifiedAt lastMail banTo email authMethods"
            );
            let emailMethod: any = foundedUser.authMethods.find((method) => method.type === 'email' && method.identifier === foundedUser.email);
            let bcryptRes = await bcrypt.compare(dto.password, emailMethod.password);
            if (!bcryptRes) {
                throw new BadRequestException(i18nApi.invalidLoginDataString);
            }
            await this.userDevice.deleteMany({
                uId: dto.myUser._id
            });
            return i18nApi.deviceHasBeenLogoutFromAllDevicesString;
        }

        await this.userDevice.findByIdAndDelete(dto.myUser.currentDevice._id);
        return "Device has been logout";
    }

    private async sendMailToUser(user: IUser, mailType: MailType, isDev: boolean, session?) {

    }

    async generateUniqueCode(): Promise<number> {
        let uniqueCode: number;
        let isUnique = false;

        while (!isUnique) {
            uniqueCode = Math.floor(100000 + Math.random() * 900000);

            let existingUser: IUser = await this.userService.findOne({
                uniqueCode: uniqueCode
            }, "uniqueCode");

            if (!existingUser) {
                isUnique = true;
            }
        }

        return uniqueCode;
    }

    private userLoginValidate(user: IUser) {
        // if (!user.verifiedAt) throw new BadRequestException('User not verified yet please verify first')
        if (user.banTo) throw new HttpException(i18nApi.yourAccountBlockedString, 450);
        if (user.deletedAt) throw new HttpException(i18nApi.yourAccountDeletedString, 450);
        // if (user.registerStatus != RegisterStatus.accepted) throw new HttpException(i18nApi.userRegisterStatusNotAcceptedYetString, 450);
    }

    private _signJwt(
        userId: string,
        deviceId: string,
        authId: string,
    ) {
        return this.jwtService.sign({
            id: userId.toString(),
            deviceId: deviceId.toString(),
            accessType: AccessTokenType.Access,
            authId: authId
        });
    }

    private async deleteDevicesAndCreateNew(dto: {
        userId: string,
        session?,
        pushKey?: string,
        userDeviceId: string,
        ip: string,
        deviceInfo: {},
        language: string,
        platform: Platform,
        authId: string,
    }) {
        await this.userDevice.deleteMany({
            uId: dto.userId
        });
        let mongoDeviceId = newMongoObjId().toString();
        let access = this._signJwt(dto.userId, mongoDeviceId, dto.authId);
        await this.userDevice.create({
            _id: mongoDeviceId,
            uId: dto.userId,
            dIp: dto.ip,
            pushProvider: this._getVPushProvider(dto.pushKey),
            pushKey: dto.pushKey,
            userDeviceId: dto.userDeviceId,
            lastSeenAt: new Date(),
            deviceInfo: dto.deviceInfo,
            language: dto.language,
            platform: dto.platform
        }, dto.session);
        return access;
    }

    private _jwtVerify(token: string): JwtDecodeRes {
        try {
            let payload = this.jwtService.verify(token);
            return {
                deviceId: payload["deviceId"],
                userId: payload["id"],
                authId: payload["authId"],
            };
        } catch (err) {
            throw new BadRequestException("Jwt access token not valid " + token);
        }
    }

    private _getVPushProvider(pushKey?: string) {
        if (!pushKey) return null;
        let isOneSignal = isUUID(pushKey.toString());
        return isOneSignal ? VPushProvider.onesignal : VPushProvider.fcm;
    }

    private async _pushNotificationSubscribe(pushKey: string, platform: Platform) {

        if (!pushKey) {
            return;
        }
        if (this._getVPushProvider(pushKey) == VPushProvider.fcm) {
            if (platform == Platform.Android) {
                await this.notificationEmitterService.subscribeFcmTopic(pushKey, PushTopics.AdminAndroid);
            }
            if (platform == Platform.Ios) {
                await this.notificationEmitterService.subscribeFcmTopic(pushKey, PushTopics.AdminIos);
            }
        } else {
            if (platform == Platform.Android) {
                await this.notificationEmitterService.subscribeOnesignalTopic(pushKey, PushTopics.AdminAndroid);
            }
            if (platform == Platform.Ios) {
                await this.notificationEmitterService.subscribeOnesignalTopic(pushKey, PushTopics.AdminIos);
            }
        }
    }

    async comparePassword(dtoPassword, dbHasPassword) {
        let bcryptRes = await bcrypt.compare(dtoPassword, dbHasPassword);
        if (!bcryptRes) {
            throw new BadRequestException(i18nApi.invalidLoginDataString);
        }
        return true
    }

    async checkMethod(dto: CheckMethodDto) {
        let user = await this.userService.findOne({
            authMethods: {
                $elemMatch: {
                    type: dto.authType,
                    identifier: dto.authId
                }
            }
        }, "_id email fullName registerStatus")
        if (!user) return null
        return user
    }


    private async getLoginUserDeviceData(
        userId: string,
        registerStatus: RegisterStatus,
        dto: CommonAuthDto
    ) {

        let oldDevice = await this.userDevice.findOne({
            uId: userId,
            userDeviceId: dto.deviceId
        });
        if (oldDevice) {
            await this.userDevice.findByIdAndUpdate(oldDevice._id, {
                pushProvider: this._getVPushProvider(dto.pushKey),
                pushKey: dto.pushKey
            });
            let access = this._signJwt(userId, oldDevice._id.toString(), dto.authId);
            return {
                "accessToken": access,
                "status": registerStatus
            };
        }
        // this is a new device
        let mongoDeviceId = newMongoObjId().toString();
        let access = this._signJwt(userId, mongoDeviceId, dto.authId);
        await this.userDevice.create({
            _id: mongoDeviceId,
            userDeviceId: dto.deviceId,
            uId: userId,
            language: dto.language,
            platform: dto.platform,
            pushProvider: this._getVPushProvider(dto.pushKey),
            dIp: dto.ip,
            deviceInfo: dto.deviceInfo,
            pushKey: dto.pushKey
        });
        return {
            "accessToken": access,
            "status": registerStatus
        };
    }

    async checkWebScanLogin(dto: MongoIdDto) {
        let qrRes = await this.qrSessionService.findByIdOrThrow(dto.id)
        const currentTime = Date.now();
        if (currentTime > qrRes.exp) {
            throw new BadRequestException('QR code has expired');
        }
        if (!qrRes.userId) {
            throw new BadRequestException('Wait the user to verify the login');
        }
        if (qrRes.isAccepted) {
            throw new BadRequestException('QR code already accepted! if you face problem refresh the page');
        }

        let userId = qrRes.userId;
        await this.userService.findByIdAndUpdate(userId, {
            $push: {
                authMethods: {
                    identifier: dto.id,
                    type: RegisterMethod.qrCode,
                    createdAt: new Date()
                }
            }
        })

        await this.qrSessionService.findByIdAndUpdate(dto.id, {
            isAccepted: true,
        })

        return "Done";
        // this.login()

    }
    async verifyWebScanQr(dto: MongoIdDto) {
        let qrId = dto.id;
        let qrRes = await this.qrSessionService.findByIdOrThrow(qrId)
        const currentTime = Date.now();
        if (currentTime > qrRes.exp) {
            throw new BadRequestException('QR code has expired');
        }
        if (qrRes.isAccepted) {
            throw new BadRequestException('QR code already accepted! if you face problem refresh the page');
        }
        await this.qrSessionService.findByIdAndUpdate(dto.id, {
            userId: dto.myUser._id
        })
        return "Done"
    }


}
