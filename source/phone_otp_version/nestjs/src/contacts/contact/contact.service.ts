import {Injectable, NotFoundException} from '@nestjs/common';
import {InjectModel} from "@nestjs/mongoose";
import {FilterQuery, PaginateModel, QueryOptions, UpdateQuery} from "mongoose";
import {BaseService} from "../../core/common/base.service";
import {IContact} from "./entities/contact.entity";

@Injectable()
export class ContactService extends BaseService<IContact>{
    constructor(
        @InjectModel("contact") private readonly model: PaginateModel<IContact>
    ) {
        super();
    }

    create(obj: Partial<IContact>, session?): Promise<any> {
        return Promise.resolve(this.model.create([obj], {session}));
    }


    deleteMany(filter: FilterQuery<IContact>): Promise<any> {
        return Promise.resolve(this.model.deleteMany(filter));
    }

    deleteOne(filter: FilterQuery<IContact>): Promise<any> {
        return Promise.resolve(this.model.deleteOne(filter));
    }

    findAll(
        filter?: FilterQuery<IContact> | undefined,
        select?: string | null | undefined,
        options?: QueryOptions<IContact> | null | undefined
    ) {
        return Promise.resolve(this.model.find(filter, select, options));
    }

    findById(
        id: string,
        select?: string
    ): Promise<IContact | null> {
        return Promise.resolve(this.model.findById(id, select));
    }

    findByIdAndDelete(id: string): Promise<any> {
        return Promise.resolve(this.model.findByIdAndDelete(id));
    }

    findByIdAndUpdate(
        id: string,
        update: UpdateQuery<IContact>
    ): Promise<any> {
        return Promise.resolve(this.model.findByIdAndUpdate(id, update));
    }

    updateMany(
        filter: FilterQuery<IContact>,
        update: UpdateQuery<IContact>,
        options?: QueryOptions<IContact> | null | undefined
    ): Promise<any> {
        return Promise.resolve(this.model.updateMany(filter, update, options));
    }

    async findByIdOrThrow(
        id: string,
        select?: string | null | undefined
    ): Promise<IContact> {
        let m = await this.findById(id, select);
        if (!m)
            throw new NotFoundException(
                "contact with id " + id + " not found in db"
            );
        return m;
    }

    findByRoomId(
        roomId: string,
        select?: string | null | undefined,
        options?: QueryOptions<IContact> | null | undefined
    ) {
        return Promise.resolve(this.findAll({rId: roomId}, select, options));
    }

    findByRoomIdAndDelete(
        roomId: string,
        filter: FilterQuery<IContact>
    ): Promise<any> {
        return Promise.resolve(this.deleteMany({rId: roomId}));
    }


    findOne(
        filter: FilterQuery<IContact>,
        select?: string,
        options?: QueryOptions<IContact>
    ): Promise<IContact | null> {
        return Promise.resolve(this.model.findOne(filter, select, options));
    }

    createMany(obj: Array<Partial<IContact>>, ): Promise<any> {
        return Promise.resolve(this.model.create(obj,{ ordered: false } ));
    }

    findOneAndUpdate(
        filter: FilterQuery<IContact>,
        update: UpdateQuery<IContact>,
        session?,
        options?: QueryOptions<IContact>
    ): Promise<IContact | null> {
        return Promise.resolve(
            this.model.findOneAndUpdate(filter, update, options).session(session)
        );
    }

    findCount(filter: FilterQuery<IContact>, session?): Promise<any> {
        return Promise.resolve(this.model.estimatedDocumentCount(filter).session(session));
    }

    aggregate(stages: any[]): Promise<any> {
        return Promise.resolve(this.model.aggregate(stages));
    }

    // paginate(paginationParameters: any[]) {
    //     return Promise.resolve(this.model.paginate(...paginationParameters));
    // }

    async aggregateV2(stages: any[], page: number, limit: number) {
        let myAggregate = this.model.aggregate(stages);
        // @ts-ignore
        return this.model.aggregatePaginate(myAggregate, {
            page,
            limit,
        });
    }

    private async _deleteAll() {
        await  this.model.deleteMany({});
        console.log("Done")
    }
    paginate(paginationParameters: any[]) {
        return Promise.resolve(this.model.paginate(...paginationParameters));
    }
}

