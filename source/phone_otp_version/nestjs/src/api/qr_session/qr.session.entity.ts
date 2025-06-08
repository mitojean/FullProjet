/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import mongoose, {Schema} from "mongoose";
import {Platform} from "../../core/utils/enums";


export interface IQrSession {
    _id: string
    exp: number,
    deviceId: string,
    isAccepted: boolean,
    userId?: string,
}


export const QrSessionSchema = new mongoose.Schema(
    {
        isAccepted: {type: Boolean, default: false},
        exp: {type: Number, require: true},
        deviceId: {type: String, require: true},
        userId: {type: Schema.Types.ObjectId, default: null},
    },
    {
        timestamps: true,
    }
);