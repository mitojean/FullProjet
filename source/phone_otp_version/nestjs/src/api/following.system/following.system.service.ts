import { BadRequestException, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import {FilterQuery, Model, QueryOptions} from "mongoose";
import { IFollow } from "./entities/following.system.entity";
import {NotificationEmitterService} from "../../common/notification_emitter/notification_emitter.service";
import {UserService} from "../user_modules/user/user.service";
import {MongoIdDto} from "../../core/common/dto/mongo.id.dto";

@Injectable()
export class FollowingSystemService {
  constructor(
    private userService: UserService,
    @InjectModel("follow") private readonly followModel: Model<IFollow>,
    private readonly emitterService: NotificationEmitterService
  ) {
  }

  async create(dto: MongoIdDto) {
    await this.userService.findByIdOrThrow(dto.id,"fullName userImages");
    if (dto.myUser._id == dto.id) throw new BadRequestException("Cant follow your self");
    let follow: IFollow = await this.followModel.findOne({
      followerId: dto.myUser._id,
      followingId: dto.id
    }).lean();

    if (follow) {
      // there are old following
      if (follow.isEnable) {
        await this.followModel.findByIdAndUpdate(follow._id, {
          isEnable: false
        });
        return  "You Unfollowed"
      } else {
        await this.followModel.findByIdAndUpdate(follow._id, {
          isEnable: true
        });
       return  "You re followed"
      }

    } else {
      // i need to create it
      let x = await  this.followModel.create({
        followerId: dto.myUser._id,
        followingId: dto.id,
        isEnable: true
      });
      await x.save().catch(err => {
        throw new BadRequestException("Unknown Error while follow the user " + err);
      });
      await this.emitterService.followNotification(dto.myUser, dto.id);
      return  "You followed this user"
    }
   // await this.emitterService.followNotification(dto.myUser, dto.id);
  }

  async getUserFollowersCount(_id: string) {
    return this.followModel.countDocuments({
      followingId: _id,
      isEnable: true
    });
  }

  async  findAll(filter?: FilterQuery<IFollow>  , select?: string  , options?: QueryOptions<IFollow> ){
    return this.followModel.find(filter,select,options);
  }

  async getUserFollowingCount(_id: string) {
    return this.followModel.countDocuments({
      followerId: _id,
      isEnable: true
    });
  }

  async isMeFollowThisUser(myId: any, peerId: any) {
    let res = await this.followModel.findOne({ followingId: peerId, followerId: myId });

    if (!res) {
      return false;
    }
    return !!res.isEnable;

  }
  deleteMany(filter: FilterQuery<IFollow>): Promise<any> {
    return Promise.resolve(this.followModel.deleteMany(filter));
  }
}
