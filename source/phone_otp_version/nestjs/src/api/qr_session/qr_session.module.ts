import { Module } from '@nestjs/common';
import { QrSessionService } from './qr_session.service';
import {MongooseModule} from "@nestjs/mongoose";
import {VersionSchema} from "../versions/versions.entity";
import {QrSessionSchema} from "./qr.session.entity";

@Module({
  providers: [QrSessionService],
  exports: [QrSessionService],
  imports:[
    MongooseModule.forFeature([{
      name: "qr_session",
      schema: QrSessionSchema
    }]),
  ]
})
export class QrSessionModule {}
