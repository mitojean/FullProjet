/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */
import {Schema} from "mongoose";
import pM from "mongoose-paginate-v2"

export interface IContact extends Document {
    userId: string;
    contactName: string;
    contactPhone: string;
    contactId: string;
}

export const ContactSchema = new Schema(
    {
        userId: { type: Schema.Types.ObjectId, required: true, ref: 'user', index: true },
        contactName: { type: String, required: true },
        contactPhone: { type: String, required: true, index: true,ref: 'user' },
        contactId: { type: String, required: true, index: true },
    },
    {
        timestamps: false,
    }
);
ContactSchema.plugin(pM);
ContactSchema.index({userId: 1, contactPhone: 1}, {unique: true})
