/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import mongoose, {Schema} from "mongoose";
import bcrypt from "bcrypt";
import pM from "mongoose-paginate-v2"
import {

    MailType,
    RegisterMethod,
    RegisterStatus,
    UserPrivacyTypes,
    UserRole,
    UserType
} from "../../../../core/utils/enums";
import {IUserDevice} from "../../user_device/entities/user_device.entity";
import {UserGlobalCallStatus} from "../../../../chat/call_modules/utils/user-global-call-status.model";


export class AuthMethod {
    type: RegisterMethod
    identifier: string
    createdAt: Date


    constructor(type: RegisterMethod, identifier: string) {
        this.type = type;
        this.identifier = identifier;
        this.createdAt = new Date();
    }
}

export class AuthEmailMethod extends AuthMethod {
    password: string


    constructor(type: RegisterMethod, identifier: string,  password: string) {
        super(type, identifier );
        this.password = password;
    }
}

export interface IUser {
    _id: string
    ///for auth
    email: string;
    phone: string;
    authMethods: AuthMethod[];

    fullName: string;
    fullNameEn: string;
    uniqueCode: number,
    bio?: string,
    lastMail: {
        type: MailType,
        sendAt: Date,
        code: number,
        expired: boolean
    },
    registerStatus: RegisterStatus,
    banTo?: Date,
    verifiedAt?: Date,
    userImage: string,
    isBusiness: boolean,
    createdAt: Date,
    deletedAt?: Date,
    countryId?: string,
    updatedAt: Date,
    lastSeenAt: Date,
    roles: UserRole[]
    userPrivacy: UserPrivacy
    //not saved in db
    currentDevice: IUserDevice
    userGlobalCallStatus?: UserGlobalCallStatus,

}

export interface UserPrivacy {
    startChat: UserPrivacyTypes
    publicSearch: boolean
    showStory: UserPrivacyTypes
    lastSeen: boolean
}

export const UserSchema = new mongoose.Schema(
    {
        email: {type: String,  default: null},
        phone: {type: String,    default: null},
        authMethods: {type: [], default: []},
        fullName: {type: String, required: true},
        fullNameEn: {type: String, required: true},
        bio: {type: String, default: null},
        userGlobalCallStatus: {type: Object, default: UserGlobalCallStatus.createEmpty()},
        uniqueCode: {type: Number, required: true},
        lastMail: {type: Object, default: {}},
        isBusiness: {type: Boolean, default: false},
        verifiedAt: {type: Date, default: null},
        userImage: {type: String, default: "default_user_image.png"},
        roles: {
            type: [String], // Define as an array of strings
            default: [],
            enum: Object.values(UserRole), // Ensure UserRole values are strings
        },
        banTo: {type: Date, default: null},
        countryId: {type: Schema.Types.ObjectId, default: null, ref: "countries"},
        createdAt: {type: Date,},
        deletedAt: {type: Date, default: null,},
        registerStatus: {
            type: String,
            enum: Object.values(RegisterStatus),
            required: true
        },
        userPrivacy: {
            type: Object,
            default: {
                startChat: UserPrivacyTypes.ForReq,
                publicSearch: true,
                showStory: UserPrivacyTypes.ForReq,
                lastSeen: true,
            }
        },
        lastSeenAt: {type: Date, default: Date.now},
        updatedAt: {type: Date}
    },
    {
        timestamps: true
    }
);

UserSchema.pre("save", async function (next) {
    let user = this;

    // Loop through authMethods array to find the one with type 'email'
    for (const method of user.authMethods) {
        if (method.type === 'email' && method.password && user.isModified('authMethods')) {
            // If the password field is modified, hash it
            const salt = await bcrypt.genSalt(10);
            method.password = await bcrypt.hashSync(method.password, salt);
        }
    }

    return next();
});
UserSchema.pre("findOneAndUpdate", async function (next) {
    let update:any = this.getUpdate();

    // Check if authMethods array is part of the update and contains an email login
    if (!update || !update.authMethods) {
        return next();
    }

    // Iterate over the authMethods array to find the email method and hash the password
    for (let i = 0; i < update.authMethods.length; i++) {
        let method = update.authMethods[i];
        if (method.type === 'email' && method.password) {
            // Hash the password if it's an email method and the password is being modified
            const salt = await bcrypt.genSalt(10);
            method.password = await bcrypt.hash(method.password, salt);
        }
    }

    // Instruct mongoose to update the nested fields with '$set'
    this.setUpdate({ $set: update });

    return next();
});
UserSchema.plugin(pM)

// export const UserEntity = mongoose.model<IUser>("User", userSchema);

