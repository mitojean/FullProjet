/**
 * Copyright 2023, the hatemragab project author.
 * All rights reserved. Use of this source code is governed by a
 * MIT license that can be found in the LICENSE file.
 */

import {Injectable} from "@nestjs/common";
import {EventEmitter2} from "@nestjs/event-emitter";
import {UserService} from "../../api/user_modules/user/user.service";
import {UserDeviceService} from "../../api/user_modules/user_device/user_device.service";
import {NotificationType, PushTopics} from "../../core/utils/enums";

import {NotificationData} from "./notification.event";

import {PushCallDataModel} from "../../chat/call_modules/utils/push-call-data.model";
import {IUser} from "../../api/user_modules/user/entities/user.entity";

export  const rExp: RegExp = new RegExp("\\[(@[^:]+):([^\\]]+)\]", "g");

@Injectable()
export class NotificationEmitterService {
    constructor(
        private readonly eventEmitter: EventEmitter2,
        private readonly userDevice: UserDeviceService,
    ) {
    }

    async adminNotification(title: string, body: string) {
        this.eventEmitter.emit("send.all.active", title, body);
    }

    async subscribeOnesignalTopic(token: string, topic: PushTopics) {
        this.eventEmitter.emit("topic.onesignal", {
            token,
            topic
        });
    }

    async subscribeFcmTopic(token: string, topic: PushTopics) {
        this.eventEmitter.emit("topic.fcm", {
            token,
            topic
        });
    }

    sendVoipCall(tokens: string[], model: PushCallDataModel) {
        this.eventEmitter.emit("send.all.voip", {
            tokens,
            model
        });
    }

    async unSubscribeFcmTopic(token: string, topic: PushTopics) {
        this.eventEmitter.emit("un.sub", {
            token,
            topic
        });
    }
    async followNotification(myUser: IUser, peerId: string) {
        let tokens = await this.userDevice.getUserFcmTokens(peerId);
        let dto = new NotificationData({
            tokens,
            title: "New follower",
            body: myUser.fullName + " start follow you",
            tag: myUser._id,
            data: {
                type: NotificationType.NewFollow
            },
        });
        this.fcmSend(dto);
    }
    fcmSend(notificationData: NotificationData) {
        this.eventEmitter.emit("send.fcm", notificationData);
    }


    oneSignalSend(notificationData: NotificationData) {
        this.eventEmitter.emit("send.onesignal", notificationData);
    }

}
