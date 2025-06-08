/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import mongoose from "mongoose";
import {parsePhoneNumberFromString} from "libphonenumber-js";

export const isValidMongoId = (id) => {
  return mongoose.Types.ObjectId.isValid(id);
};
export const newMongoObjId = (string?:string) => {
  if(string){
    return new mongoose.Types.ObjectId(string);
  }
  return new mongoose.Types.ObjectId();
};

export const humanFileSize = (size: number) => {
  let i = Math.floor(Math.log(size) / Math.log(1024));
  // @ts-ignore
  return (size / Math.pow(1024, i)).toFixed(2) * 1 + " " + ["B", "kB", "MB", "GB", "TB"][i];
};

export const humanAudioTime = (time: number) => {
  const sec = parseInt(time.toString(), 10);

  let m = sec % 60;
  return Math.floor(sec / 60) + ":" + (m ? m : "00");
};
export function isValidEmail(email: string) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
export function normalizePhoneNumber(
    phoneNumber: string,
    defaultCountry  : string,
): string | null {

  // @ts-ignore
  const parsedNumber = parsePhoneNumberFromString(phoneNumber, defaultCountry);
  if (parsedNumber && parsedNumber.isValid()) {
    return parsedNumber.number; // Returns in E.164 format
  }
  return null;
}
export const emptyListRes= {
  "docs": [],
  "totalDocs": 0,
  "offset": 0,
  "limit": 30,
  "totalPages": 1,
  "page": 1,
  "pagingCounter": 1,
  "hasPrevPage": false,
  "hasNextPage": false,
  "prevPage": null,
  "nextPage": null
}