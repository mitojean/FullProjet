import {BadRequestException, Injectable} from '@nestjs/common';
import {CreateContactDto, CreateContactsDto, DeleteContactsDto,} from './dto/contact.dto';
import {ContactService} from "../contact/contact.service";
import {IContact} from "../contact/entities/contact.entity";
import {parsePhoneNumberFromString, PhoneNumber} from "libphonenumber-js";
import {UserService} from "../../api/user_modules/user/user.service";
import {IUser} from "../../api/user_modules/user/entities/user.entity";
import {PaginationParameters} from "mongoose-paginate-v2";

@Injectable()
export class UserContactService {

    constructor(
        private readonly contactsService: ContactService,
        private readonly userService: UserService,
    ) {
    }

    async create(dto: CreateContactsDto) {
        let countryCode = dto.countryCode;
        let contactsToCreate: Array<Partial<IContact>> = [];

        for (let contact of dto.contacts) {
            const obj = {
                userId: dto.myUser._id,
                contactId: contact.contactId,
                contactName: contact.displayName,
                contactPhone: null,
            };

            // Remove any formatting from the phone number
            let phoneNumber = this._getPhoneNumber(contact.phone, countryCode)
            if (!(phoneNumber && phoneNumber.isValid())) {
                console.log(`Skipping invalid phone number: ${contact.phone}`);
                continue;
            }

            // Format the phone number to E.164 standard
            obj.contactPhone = phoneNumber.number;
            contactsToCreate.push({...obj}); // Use spread operator to avoid reference issues

        }

        try {
            await this.contactsService.createMany(contactsToCreate);
        } catch (e) {
            if (e.name === 'MongoServerError' && e.code === 11000) {
                console.error('Duplicate key error:', e.message);
                return 'Duplicate key error';
            } else {
                throw new BadRequestException(e);
            }
        }

        return 'Users have been synced number is ' + contactsToCreate.length;
    }

    async deleteContact(dto: DeleteContactsDto) {
        let phonesToDelete: string[] = []
        for (let phone of dto.phones) {
            let phoneNumber = this._getPhoneNumber(phone, dto.countryCode)
            if (!(phoneNumber && phoneNumber.isValid())) {
                console.log(`Skipping invalid phone number: ${phone}`);
                continue;
            }
            let res = await this.contactsService.findOne({
                contactPhone: phoneNumber.number,
                userId: dto.myUser._id
            })
            if (!res) {
                console.log(`Skipping Phone number not exists in your db: ${phoneNumber.number}`);
                continue;
            }
            phonesToDelete.push(phoneNumber.number)
        }

        await this.contactsService.deleteMany({
            contactPhone: {
                $in: phonesToDelete
            },
            userId: dto.myUser._id
        })
        return "Phone has been deleted Now is " + phonesToDelete.length
    }


    async updateContact(dto: CreateContactsDto) {
        let countryCode = dto.countryCode;
        let number = 0
        for (let contact of dto.contacts) {
            let phoneNumber = this._getPhoneNumber(contact.phone, countryCode)
            if (!(phoneNumber && phoneNumber.isValid())) {
                console.log(`Skipping invalid phone number: ${contact.phone}`);
                continue;
            }
            let res = await this.contactsService.findOne({
                contactPhone: phoneNumber.number,
                userId: dto.myUser._id
            })
            if (!res) {
                console.log(`Skipping Phone number not exists in your db: ${phoneNumber.number}`);
                continue;
            }
            ++number
            await this.contactsService.findOneAndUpdate({
                userId: dto.myUser._id,
                contactPhone: phoneNumber.number
            }, {
                userId: dto.myUser._id,
                contactId: contact.contactId,
                contactName: contact.displayName,
                contactPhone: phoneNumber.number,
            })
        }
        return "Phone updated is " + number
    }

    private _getPhoneNumber(phone: string, countryCode: string) {
        phone = phone.trim();

        let phoneNumber: PhoneNumber | undefined;

        if (phone.startsWith('+')) {
            // International format with country code
            phoneNumber = parsePhoneNumberFromString(phone);
        } else {
            // Local number without country code
            // @ts-ignore
            phoneNumber = parsePhoneNumberFromString(phone, countryCode);
        }
        return phoneNumber
    }

    async getAll(dto: Object, user: IUser) {
        let myUsers = await this.contactsService.findAll({
            userId: user._id
        }, "contactPhone")
        return this.userService.searchV2(dto, [user._id], {phone: {$in: myUsers.map(value => value.contactPhone)}})
    }

}
