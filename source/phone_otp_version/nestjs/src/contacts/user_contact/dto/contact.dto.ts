import {IsString, IsArray, IsOptional, IsISO8601, ValidateNested, ArrayNotEmpty} from 'class-validator';
import {PartialType} from "@nestjs/mapped-types";
import CommonDto from "../../../core/common/dto/common.dto";
import {Transform, Type} from "class-transformer";

export class CreateContactDto {
    @IsString()
    contactId: string;

    @IsString()
    displayName: string;

    @IsString()
    phone: string;

}


export class CreateContactsDto extends CommonDto {
    @IsArray()
    @ValidateNested({each: true})
    @Type(() => CreateContactDto)
    contacts: CreateContactDto[];


    @IsString()
    countryCode: string;

}


export class DeleteContactsDto extends CommonDto {
    @IsArray()
    @ArrayNotEmpty()
    phones: string[];


    @IsString()
    countryCode: string;

}