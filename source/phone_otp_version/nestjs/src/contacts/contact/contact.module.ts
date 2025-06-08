import { Module } from '@nestjs/common';
import { ContactService } from './contact.service';
import {MongooseModule} from "@nestjs/mongoose";
 import {ContactSchema} from "./entities/contact.entity";

@Module({
  exports: [ContactService],
  providers: [ContactService],
  imports:[
    MongooseModule.forFeature([{
      name: "contact",
      schema: ContactSchema
    }]),
  ]
})
export class ContactModule {}
