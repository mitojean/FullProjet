/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import {
    Allow,
    IsBoolean,
    IsDefined,
    IsEmail,
    IsEnum,
    IsNotEmpty, IsOptional,
    MaxLength,
    MinLength,
    ValidateIf
} from "class-validator";
import {Trim} from "class-sanitizer";
import {Platform, RegisterMethod} from "../../../core/utils/enums";
import CommonDto from "../../../core/common/dto/common.dto";
import {i18nApi} from "../../../core/utils/res.helpers";
import {usersMaxNameSize, usersMaxPasswordSize, usersMimePasswordSize} from "../../../core/utils/constants";
import {Type} from "class-transformer";

export class CheckMethodDto {

    @IsEnum(RegisterMethod)
    authType: RegisterMethod

    @IsDefined()
    authId: string

}

export class CommonAuthDto {
    ip: string;
    @IsNotEmpty()
    @Trim()
    @MaxLength(255)
    deviceId: string;

    @Allow()
    @Trim()
    pushKey?: string;


    @IsDefined()
    authId: string

    @IsNotEmpty()
    language: string;

    @IsNotEmpty()
    deviceInfo: string;

    @IsEnum(Platform)
    platform: Platform;

    @IsEnum(RegisterMethod)
    method: RegisterMethod;

    @Allow()
    @Trim()
    @IsDefined()
    @ValidateIf(object => object['method'] == RegisterMethod.phone)
    phone: string;

    @Allow()
    @Trim()
    @ValidateIf(object => object['method'] == RegisterMethod.apple)
    @IsDefined()
    identifier: string;
}

export class LoginDto extends CommonAuthDto {


    @Allow()
    @ValidateIf(object => object['registerMethod'] == RegisterMethod.email)
    @IsEmail({}, {message: "Email is required and must be email format"})
    @Trim()
    email: string;


    @IsNotEmpty()
    @MaxLength(255)
    @ValidateIf(object => object['method'] == RegisterMethod.email)
    password: string;
}


export class LogoutDto extends CommonDto {
    @Allow()
    @ValidateIf(object => object['logoutFromAll'])
    @IsDefined()
    password: string;

    @IsBoolean()
    logoutFromAll: boolean;
}

export class RegisterDto extends CommonAuthDto {

    imageBuffer?: Buffer;

    @Allow()
    @Trim()
    @ValidateIf(object => object['method'] == RegisterMethod.email)
    @IsEmail({}, {message: i18nApi.emailMustBeValid})
    email: string;


    @IsNotEmpty()
    @Trim()
    @MaxLength(usersMaxNameSize)
    fullName: string;


    @MaxLength(usersMaxPasswordSize)
    @MinLength(usersMimePasswordSize)
    @ValidateIf(object => object['method'] == RegisterMethod.email)
    @IsNotEmpty()
    password: string;

    @Type(() => Boolean)
    @IsOptional()
    isBusiness?: boolean;


}