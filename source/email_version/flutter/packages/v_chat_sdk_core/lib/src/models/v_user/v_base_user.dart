// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

// class SBaseUser {
//   final String vChatId;
//   final String fullName;
//   final VUserImage userImages;
//
// //<editor-fold desc="Data Methods">
//
//   const SBaseUser({
//     required this.vChatId,
//     required this.fullName,
//     required this.userImages,
//   });
//
//   bool get isMe => VAppConstants.myId == vChatId;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is SBaseUser && vChatId == other.vChatId);
//
//   @override
//   int get hashCode => vChatId.hashCode;
//
//   @override
//   String toString() {
//     return 'SBaseUser{ vChatId: $vChatId, fullName: $fullName, userImages: $userImages,}';
//   }
//
//   SBaseUser copyWith({
//     String? vChatId,
//     String? fullName,
//     VUserImage? userImages,
//   }) {
//     return SBaseUser(
//       vChatId: vChatId ?? this.vChatId,
//       fullName: fullName ?? this.fullName,
//       userImages: userImages ?? this.userImages,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       '_id': vChatId,
//       'fullName': fullName,
//       'userImages': userImages.toMap(),
//     };
//   }
//
//   factory SBaseUser.fromMap(Map<String, dynamic> map) {
//     return SBaseUser(
//       vChatId: map['_id'] as String,
//       fullName: map['fullName'] as String,
//       userImages: VUserImage.fromMap(map['userImages'] as Map<String, dynamic>),
//     );
//   }
//
//   factory SBaseUser.fromFakeData() {
//     return SBaseUser(
//       vChatId: "fake vChatId",
//       fullName: "fake FullName",
//       userImages: VUserImage.fromFakeSingleUrl(),
//     );
//   }
//
// //</editor-fold>
// }

// class SBaseUser {
//   final String identifier;
//   final SBaseUser baseUser;
//
// //<editor-fold desc="Data Methods">
//
//   const SBaseUser({
//     required this.identifier,
//     required this.baseUser,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is SBaseUser &&
//           runtimeType == other.runtimeType &&
//           identifier == other.identifier &&
//           baseUser == other.baseUser);
//
//   @override
//   int get hashCode => identifier.hashCode ^ baseUser.hashCode;
//
//   bool get isMe => baseUser.isMe;
//
//   @override
//   String toString() {
//     return 'SBaseUser{ identifier: $identifier, baseUser: $baseUser,}';
//   }
//
//   SBaseUser copyWith({
//     String? identifier,
//     SBaseUser? baseUser,
//   }) {
//     return SBaseUser(
//       identifier: identifier ?? this.identifier,
//       baseUser: baseUser ?? this.baseUser,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'identifier': identifier,
//       ...baseUser.toMap(),
//     };
//   }
//
//   factory SBaseUser.fromMap(Map<String, dynamic> map) {
//     return SBaseUser(
//       identifier: map['identifier'] as String,
//       baseUser: SBaseUser.fromMap(map),
//     );
//   }
//
// //</editor-fold>
// }
