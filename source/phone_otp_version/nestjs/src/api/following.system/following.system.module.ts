import { Module } from '@nestjs/common';
import { FollowingSystemService } from './following.system.service';
import { FollowingSystemController } from './following.system.controller';
import { MongooseModule } from "@nestjs/mongoose";
import { FollowSchema } from "./entities/following.system.entity";
import {UserModule} from "../user_modules/user/user.module";
import {AuthModule} from "../auth/auth.module";
import {NotificationEmitterModule} from "../../common/notification_emitter/notification_emitter.module";

@Module({
  controllers: [FollowingSystemController],
  providers: [FollowingSystemService],
  imports:[
    MongooseModule.forFeature([{
      name: "follow",
      schema: FollowSchema
    }]),
    UserModule,
    AuthModule,
    NotificationEmitterModule
  ],
  exports:[
    FollowingSystemService
  ]
})
export class FollowingSystemModule {}
