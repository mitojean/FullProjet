import {Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req, Put, Query} from '@nestjs/common';
import {UserContactService} from './user_contact.service';
import {V1Controller} from "../../core/common/v1-controller.decorator";
import {VerifiedAuthGuard} from "../../core/guards/verified.auth.guard";
import {CreateContactDto, CreateContactsDto, DeleteContactsDto} from "./dto/contact.dto";
import {resOK} from "../../core/utils/res.helpers";
import {UserService} from "../../api/user_modules/user/user.service";

@UseGuards(VerifiedAuthGuard)
@V1Controller('contact')
export class UserContactController {
    constructor(private readonly contactsService: UserContactService) {
    }

    @Post("/")
    async create(
        @Body() dto: CreateContactsDto,
        @Req() req: any
    ) {
        dto.myUser = req.user;

        return resOK(await this.contactsService.create(dto));
    }



    @Get("/")
    async getAll(
        @Req() req: any,
          @Query() dto: Object
    ) {
        return resOK(await this.contactsService.getAll(dto,req.user));
    }
    // Delete a contact
    @Delete("/")
    async deleteContact(
        @Req() req: any,
        @Body() dto: DeleteContactsDto,
    ) {
        dto.myUser = req.user
        return resOK(await this.contactsService.deleteContact(dto));
    }

    // Update an existing contact
    @Put()
    async updateContact(
        @Body() dto: CreateContactsDto,
        @Req() req: any
    ) {
        dto.myUser = req.user;
        return resOK(await this.contactsService.updateContact(dto));
    }

}
