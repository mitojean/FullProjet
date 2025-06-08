import {Controller, Get, Post, Body, Patch, Param, Delete, Req, UseGuards} from "@nestjs/common";
import {FollowingSystemService} from "./following.system.service";
import {MongoIdDto} from "../../core/common/dto/mongo.id.dto";
import {resOK} from "../../core/utils/res.helpers";
import {VerifiedAuthGuard} from "../../core/guards/verified.auth.guard";
import {V1Controller} from "../../core/common/v1-controller.decorator";

@UseGuards(VerifiedAuthGuard)
@V1Controller("follow")
export class FollowingSystemController {
    constructor(private readonly followingSystemService: FollowingSystemService) {
    }


    @Post('/')
    async create(@Body() dto: MongoIdDto, @Req() req:any) {
        dto.myUser = req.user;
        return resOK(await this.followingSystemService.create(dto));
    }
}
