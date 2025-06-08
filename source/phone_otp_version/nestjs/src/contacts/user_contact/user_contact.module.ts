import { Module } from '@nestjs/common';
import { UserContactService } from './user_contact.service';
import { UserContactController } from './user_contact.controller';
import {ContactModule} from "../contact/contact.module";
import {UserModule} from "../../api/user_modules/user/user.module";
import {AuthModule} from "../../api/auth/auth.module";

@Module({
  controllers: [UserContactController],
  providers: [UserContactService],
  imports:[
      ContactModule,
      UserModule,
      AuthModule
  ]
})
export class UserContactModule {}
