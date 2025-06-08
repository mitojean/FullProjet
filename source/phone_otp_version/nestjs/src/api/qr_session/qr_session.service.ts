import {Injectable, NotFoundException} from '@nestjs/common';
import {InjectModel} from "@nestjs/mongoose";
import {FilterQuery, Model, QueryOptions, UpdateQuery} from "mongoose";
import {BaseService} from "../../core/common/base.service";
import {IQrSession} from "./qr.session.entity";

@Injectable()
export class QrSessionService extends BaseService<IQrSession> {


    constructor(
        @InjectModel("qr_session") private readonly model: Model<IQrSession>,
    ) {
        super()
    }

    create(obj: Partial<IQrSession>, session?): Promise<any> {
        return Promise.resolve(this.model.create([obj], {session}));
    }

    deleteMany(filter: FilterQuery<IQrSession>): Promise<any> {
        return Promise.resolve(this.model.deleteMany(filter));
    }

    deleteOne(filter: FilterQuery<IQrSession>): Promise<any> {
        return Promise.resolve(this.model.deleteOne(filter));
    }

    findAll(
        filter?: FilterQuery<IQrSession> | undefined,
        select?: string | null | undefined,
        options?: QueryOptions<IQrSession> | null | undefined,
    ) {
        return Promise.resolve(this.model.find(filter, select, options));
    }

    findById(
        id: string,
        select?: string,
    ): Promise<IQrSession | null> {
        return Promise.resolve(this.model.findById(id, select));
    }

    findByIdAndDelete(id: string): Promise<any> {
        return Promise.resolve(this.model.findByIdAndDelete(id));
    }

    findByIdAndUpdate(
        id: string,
        update: UpdateQuery<IQrSession>,
    ): Promise<any> {
        return Promise.resolve(this.model.findByIdAndUpdate(id, update));
    }

    updateMany(
        filter: FilterQuery<IQrSession>,
        update: UpdateQuery<IQrSession>,
        options?: QueryOptions<IQrSession> | null | undefined,
    ): Promise<any> {
        return Promise.resolve(this.model.updateMany(filter, update, options));
    }

    async findByIdOrThrow(
        id: string,
        select?: string | null | undefined,
    ): Promise<IQrSession> {
        let m = await this.findById(id, select);
        if (!m)
            throw new NotFoundException(
                'QR code with id ' + id + ' not found in db',
            );
        return m;
    }

    findOne(
        filter: FilterQuery<IQrSession>,
        select?: string,
        options?: QueryOptions<IQrSession>,
    ): Promise<IQrSession | null> {
        return Promise.resolve(this.model.findOne(filter, select,options));
    }

    createMany(obj: Array<Partial<IQrSession>>, session): Promise<any> {
        return Promise.resolve(this.model.create(obj, {session}));
    }

    findOneAndUpdate(
        filter: FilterQuery<IQrSession>,
        update: UpdateQuery<IQrSession>,
        session?,
        options?: QueryOptions<IQrSession>,
    ): Promise<IQrSession | null> {
        return Promise.resolve(
            this.model.findOneAndUpdate(filter, update, options).session(session),
        );
    }

    findCount(filter: FilterQuery<IQrSession>, session?): Promise<any> {
        return Promise.resolve(this.model.estimatedDocumentCount(filter).session(session),);
    }
    
}
