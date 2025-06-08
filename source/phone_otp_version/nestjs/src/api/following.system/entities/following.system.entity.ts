import { Document, Schema } from "mongoose";

export interface IFollow extends Document {
  followerId: string;
  followingId: string;
  isEnable: boolean;
  createdAt: Date,

}

export const FollowSchema: Schema = new Schema({
  followerId: { type: Schema.Types.ObjectId, required: true,ref:"User" },
  followingId: { type: Schema.Types.ObjectId, required: true, ref:"User" },
  isEnable: { type: Boolean },
  createdAt: { type: Date, select: false },
  updatedAt: { type: Date, select: false }
}, {
  timestamps: true,
  versionKey: false
});

FollowSchema.index({ followerId: 1, followingId: 1 }, { unique: true });
