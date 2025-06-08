/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import {validateOrReject} from "class-validator";
import {BadRequestException} from "@nestjs/common";

export function jsonDecoder(data: string) {
    try {
        return JSON.parse(data);
    } catch (e) {
        throw new BadRequestException("Not valid json data " + data);
    }
}


export async function appValidator(dto: any) {
    await validateOrReject(dto, {
        enableDebugMessages: false,
        forbidNonWhitelisted: true,
        whitelist: true,
        stopAtFirstError: true
    });
}

export function isNumericString(input: string) {
    // Remove leading '+' if present
    if (input.startsWith('+')) {
        input = input.substring(1);
    }
    if (input.length <= 6) return false

    // Check if the remaining string contains only digits
    let test = /^\d+$/.test(input.trim());
    if (test) {
        return input
    }
    return false
}