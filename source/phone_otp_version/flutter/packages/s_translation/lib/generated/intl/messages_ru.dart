// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(seconds) => "Повторная отправка через ${seconds} с";

  static String m1(phone) => "Мы отправили 6-значный код на ${phone}";

  static String m2(message) => "Ошибка подтверждения: ${message}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О приложении"),
    "aboutToBlockUserWithConsequences": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь заблокировать этого пользователя. Вы не сможете отправлять ему чаты и не сможете добавлять его в группы или рассылки!",
    ),
    "acceptCallsFromUsers": MessageLookupByLibrary.simpleMessage(
      "Принимать звонки от пользователей",
    ),
    "acceptContactsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Если вы хотите видеть свои контакты, которые используют приложение, вам нужно разрешить доступ к контактам",
    ),
    "accepted": MessageLookupByLibrary.simpleMessage("Принято"),
    "account": MessageLookupByLibrary.simpleMessage("Учетная запись"),
    "actions": MessageLookupByLibrary.simpleMessage("Действия"),
    "addMembers": MessageLookupByLibrary.simpleMessage("Добавить участников"),
    "addNewStory": MessageLookupByLibrary.simpleMessage(
      "Добавить новую историю",
    ),
    "addParticipants": MessageLookupByLibrary.simpleMessage(
      "Добавить участников",
    ),
    "addedYouToNewBroadcast": MessageLookupByLibrary.simpleMessage(
      "Добавил вас в новую рассылку",
    ),
    "admin": MessageLookupByLibrary.simpleMessage("Админ"),
    "adminNotification": MessageLookupByLibrary.simpleMessage(
      "Уведомление администратора",
    ),
    "allDataHasBeenBackupYouDontNeedToManageSaveTheDataByYourself":
        MessageLookupByLibrary.simpleMessage(
          "Все данные были сохранены, вам не нужно управлять сохранением данных самостоятельно! Если вы выйдете и войдете в систему снова, вы увидите все чаты такие же, как в веб-версии",
        ),
    "allDeletedMessages": MessageLookupByLibrary.simpleMessage(
      "Все удаленные сообщения",
    ),
    "allowAds": MessageLookupByLibrary.simpleMessage("Разрешить рекламу"),
    "allowCalls": MessageLookupByLibrary.simpleMessage("Разрешить вызовы"),
    "allowCreateBroadcast": MessageLookupByLibrary.simpleMessage(
      "Разрешить создание трансляций",
    ),
    "allowCreateGroups": MessageLookupByLibrary.simpleMessage(
      "Разрешить создание групп",
    ),
    "allowDesktopLogin": MessageLookupByLibrary.simpleMessage(
      "Разрешить вход с рабочего стола",
    ),
    "allowMobileLogin": MessageLookupByLibrary.simpleMessage(
      "Разрешить мобильный вход",
    ),
    "allowSendMedia": MessageLookupByLibrary.simpleMessage(
      "Разрешить отправку медиафайлов",
    ),
    "allowWebLogin": MessageLookupByLibrary.simpleMessage(
      "Разрешить вход через веб",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?",
    ),
    "android": MessageLookupByLibrary.simpleMessage("Android"),
    "appMembers": MessageLookupByLibrary.simpleMessage("Участники приложения"),
    "appleStoreAppUrl": MessageLookupByLibrary.simpleMessage(
      "URL приложения в App Store",
    ),
    "areYouSure": MessageLookupByLibrary.simpleMessage("Вы уверены?"),
    "areYouSureToBlock": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите заблокировать",
    ),
    "areYouSureToLeaveThisGroupThisActionCantUndo":
        MessageLookupByLibrary.simpleMessage(
          "Вы уверены, что хотите покинуть эту группу? Это действие нельзя отменить",
        ),
    "areYouSureToPermitYourCopyThisActionCantUndo":
        MessageLookupByLibrary.simpleMessage(
          "Вы уверены, что хотите разрешить копирование? Это действие нельзя отменить",
        ),
    "areYouSureToReportUserToAdmin": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите отправить жалобу об этом пользователе администратору?",
    ),
    "areYouSureToUnBlock": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите разблокировать",
    ),
    "areYouWantToMakeVideoCall": MessageLookupByLibrary.simpleMessage(
      "Вы хотите сделать видеозвонок?",
    ),
    "areYouWantToMakeVoiceCall": MessageLookupByLibrary.simpleMessage(
      "Вы хотите сделать голосовой звонок?",
    ),
    "audio": MessageLookupByLibrary.simpleMessage("Аудио"),
    "audioCall": MessageLookupByLibrary.simpleMessage("Аудиозвонок"),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "banAt": MessageLookupByLibrary.simpleMessage("Заблокирован в"),
    "banTo": MessageLookupByLibrary.simpleMessage("Заблокирован до"),
    "bio": MessageLookupByLibrary.simpleMessage("Биография"),
    "block": MessageLookupByLibrary.simpleMessage("Блокировать"),
    "blockUser": MessageLookupByLibrary.simpleMessage(
      "Заблокировать пользователя",
    ),
    "blocked": MessageLookupByLibrary.simpleMessage("Заблокировано"),
    "blockedUsers": MessageLookupByLibrary.simpleMessage(
      "Заблокированные пользователи",
    ),
    "broadcast": MessageLookupByLibrary.simpleMessage("Трансляция"),
    "broadcastInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о рассылке",
    ),
    "broadcastMembers": MessageLookupByLibrary.simpleMessage(
      "Участники рассылки",
    ),
    "broadcastName": MessageLookupByLibrary.simpleMessage("Имя рассылки"),
    "broadcastParticipants": MessageLookupByLibrary.simpleMessage(
      "Участники рассылки",
    ),
    "broadcastSettings": MessageLookupByLibrary.simpleMessage(
      "Настройки рассылки",
    ),
    "callNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Звонок не разрешен",
    ),
    "callTimeoutInSeconds": MessageLookupByLibrary.simpleMessage(
      "Тайм-аут вызова (в секундах)",
    ),
    "calls": MessageLookupByLibrary.simpleMessage("Звонки"),
    "camera": MessageLookupByLibrary.simpleMessage("Камера"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "canceled": MessageLookupByLibrary.simpleMessage("Отменено"),
    "changeSubject": MessageLookupByLibrary.simpleMessage("Изменить тему"),
    "chat": MessageLookupByLibrary.simpleMessage("Чат"),
    "chats": MessageLookupByLibrary.simpleMessage("ЧАТЫ"),
    "checkForUpdates": MessageLookupByLibrary.simpleMessage(
      "Проверить обновления",
    ),
    "chooseAtLestOneMember": MessageLookupByLibrary.simpleMessage(
      "Выберите хотя бы одного участника",
    ),
    "chooseHowAutomaticDownloadWorks": MessageLookupByLibrary.simpleMessage(
      "Выберите, как работает автоматическая загрузка",
    ),
    "chooseRoom": MessageLookupByLibrary.simpleMessage("Выберите комнату"),
    "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
    "clearAllCache": MessageLookupByLibrary.simpleMessage("Очистить весь кэш"),
    "clearAppStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Этот параметр очистит хранилище приложения. Не беспокойтесь, вы всегда можете скачать его заново, если включена функция автоматической загрузки. Сообщение будет загружено автоматически.",
    ),
    "clearCallsConfirm": MessageLookupByLibrary.simpleMessage(
      "Подтвердить очистку звонков",
    ),
    "clearChat": MessageLookupByLibrary.simpleMessage("Очистить чат"),
    "clickThisOptionWillClearAppStorage": MessageLookupByLibrary.simpleMessage(
      "Этот параметр очистит хранилище приложения. Не волнуйтесь, вы все равно сможете загрузить его в любое время, если включена автоматическая загрузка. Сообщение будет загружено автоматически",
    ),
    "clickToAddGroupDescription": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы добавить описание группы",
    ),
    "clickToJoin": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы присоединиться",
    ),
    "clickToSee": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы увидеть",
    ),
    "clickToSeeAllUserCountries": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все страны пользователя",
    ),
    "clickToSeeAllUserDevicesDetails": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все сведения об устройствах пользователя",
    ),
    "clickToSeeAllUserInformations": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все сведения о пользователе",
    ),
    "clickToSeeAllUserMessagesDetails": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все сведения о сообщениях пользователя",
    ),
    "clickToSeeAllUserReports": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все отчеты пользователя",
    ),
    "clickToSeeAllUserRoomsDetails": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы посмотреть все сведения о комнатах пользователя",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "codeHasBeenExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия кода истек",
    ),
    "codeMustEqualToSixNumbers": MessageLookupByLibrary.simpleMessage(
      "Код должен состоять из шести цифр",
    ),
    "codePage": MessageLookupByLibrary.simpleMessage("Страница кода"),
    "codeSentAgain": MessageLookupByLibrary.simpleMessage(
      "Код был отправлен снова на ваш адрес электронной почты",
    ),
    "completeYourProfile": MessageLookupByLibrary.simpleMessage(
      "Заполните свой профиль",
    ),
    "configureYourAccountPrivacy": MessageLookupByLibrary.simpleMessage(
      "Настройте конфиденциальность аккаунта",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirmPasswordMustHaveValue": MessageLookupByLibrary.simpleMessage(
      "Подтверждение пароля должно иметь значение",
    ),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, подтвердите ваш пароль",
    ),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите ваш пароль",
    ),
    "congregationsYourAccountHasBeenAccepted":
        MessageLookupByLibrary.simpleMessage("Поздравляем, ваш аккаунт принят"),
    "connecting": MessageLookupByLibrary.simpleMessage("Подключение..."),
    "contactInfo": MessageLookupByLibrary.simpleMessage(
      "Контактная информация",
    ),
    "contactPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Доступ к контактам отклонен",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("Свяжитесь с нами"),
    "contactsHasBeenSynced": MessageLookupByLibrary.simpleMessage(
      "Контакты были синхронизированы",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "countries": MessageLookupByLibrary.simpleMessage("Страны"),
    "country": MessageLookupByLibrary.simpleMessage("Страна"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createBroadcast": MessageLookupByLibrary.simpleMessage("Создать рассылку"),
    "createGroup": MessageLookupByLibrary.simpleMessage("Создать группу"),
    "createMediaStory": MessageLookupByLibrary.simpleMessage(
      "Создать медиа-историю",
    ),
    "createStory": MessageLookupByLibrary.simpleMessage("Создать историю"),
    "createTextStory": MessageLookupByLibrary.simpleMessage(
      "Создать текстовую историю",
    ),
    "createYourStory": MessageLookupByLibrary.simpleMessage(
      "Создайте свою историю",
    ),
    "createdAt": MessageLookupByLibrary.simpleMessage("Создано в"),
    "creator": MessageLookupByLibrary.simpleMessage("Создатель"),
    "currentDevice": MessageLookupByLibrary.simpleMessage("Текущее устройство"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Панель"),
    "dataPrivacy": MessageLookupByLibrary.simpleMessage("Защита данных"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteAppCache": MessageLookupByLibrary.simpleMessage(
      "Удалить кэш приложения?",
    ),
    "deleteChat": MessageLookupByLibrary.simpleMessage("Удалить чат"),
    "deleteFromAll": MessageLookupByLibrary.simpleMessage("Удалить для всех"),
    "deleteFromMe": MessageLookupByLibrary.simpleMessage("Удалить для меня"),
    "deleteMember": MessageLookupByLibrary.simpleMessage("Удалить участника"),
    "deleteMyAccount": MessageLookupByLibrary.simpleMessage(
      "Удалить мой аккаунт",
    ),
    "deleteThisDeviceDesc": MessageLookupByLibrary.simpleMessage(
      "Удаление этого устройства приведет к немедленному выходу из учетной записи на этом устройстве",
    ),
    "deleteUser": MessageLookupByLibrary.simpleMessage("Удалить пользователя"),
    "deleteYouCopy": MessageLookupByLibrary.simpleMessage("Удалить вашу копию"),
    "deleted": MessageLookupByLibrary.simpleMessage("Удалено"),
    "deletedAt": MessageLookupByLibrary.simpleMessage("Удалено в"),
    "delivered": MessageLookupByLibrary.simpleMessage("Доставлено"),
    "description": MessageLookupByLibrary.simpleMessage("Описание"),
    "descriptionIsRequired": MessageLookupByLibrary.simpleMessage(
      "Описание обязательно",
    ),
    "desktopAndOtherDevices": MessageLookupByLibrary.simpleMessage(
      "ПК и другие устройства",
    ),
    "deviceHasBeenLogoutFromAllDevices": MessageLookupByLibrary.simpleMessage(
      "Устройство было выведено из системы со всех устройств",
    ),
    "deviceStatus": MessageLookupByLibrary.simpleMessage(
      "Состояние устройства",
    ),
    "devices": MessageLookupByLibrary.simpleMessage("Устройства"),
    "didntReceiveCode": MessageLookupByLibrary.simpleMessage(
      "Не получили код? ",
    ),
    "directChat": MessageLookupByLibrary.simpleMessage("Личный чат"),
    "directRooms": MessageLookupByLibrary.simpleMessage("Прямые комнаты"),
    "dismissedToMemberBy": MessageLookupByLibrary.simpleMessage(
      "Понижен до участника",
    ),
    "dismissesToMember": MessageLookupByLibrary.simpleMessage(
      "Уволить до участника",
    ),
    "docs": MessageLookupByLibrary.simpleMessage("Документы"),
    "done": MessageLookupByLibrary.simpleMessage("Готово"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Нет учетной записи?",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Скачать"),
    "downloading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailMustBeValid": MessageLookupByLibrary.simpleMessage(
      "Email должен быть действительным",
    ),
    "emailNotValid": MessageLookupByLibrary.simpleMessage(
      "Email недействителен",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Адрес электронной почты обязателен для заполнения",
    ),
    "enableSearchByEmail": MessageLookupByLibrary.simpleMessage(
      "Включить поиск по электронной почте",
    ),
    "enableSearchByUserName": MessageLookupByLibrary.simpleMessage(
      "Включить поиск по имени пользователя",
    ),
    "enterNameAndAddOptionalProfilePicture":
        MessageLookupByLibrary.simpleMessage(
          "Введите имя и добавьте необязательное фото профиля",
        ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Введите новый пароль",
    ),
    "enterTheCodeAndNewPassword": MessageLookupByLibrary.simpleMessage(
      "Введите код подтверждения, отправленный на ваш адрес электронной почты, и создайте новый пароль",
    ),
    "enterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Введите код подтверждения",
    ),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage(
      "Введите ваш адрес электронной почты",
    ),
    "enterYourFullName": MessageLookupByLibrary.simpleMessage(
      "Введите свое полное имя",
    ),
    "enterYourName": MessageLookupByLibrary.simpleMessage("Введите ваше имя"),
    "enterYourPassword": MessageLookupByLibrary.simpleMessage(
      "Введите ваш пароль",
    ),
    "enterYourPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Введите ваш номер телефона",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "exitGroup": MessageLookupByLibrary.simpleMessage("Покинуть группу"),
    "explainWhatHappens": MessageLookupByLibrary.simpleMessage(
      "Объясните здесь, что происходит",
    ),
    "feedBackEmail": MessageLookupByLibrary.simpleMessage(
      "Email обратной связи",
    ),
    "fileHasBeenSavedTo": MessageLookupByLibrary.simpleMessage(
      "Файл сохранен в",
    ),
    "fileMessages": MessageLookupByLibrary.simpleMessage("Файлы"),
    "files": MessageLookupByLibrary.simpleMessage("Файлы"),
    "finished": MessageLookupByLibrary.simpleMessage("Завершено"),
    "forRequest": MessageLookupByLibrary.simpleMessage("Для запроса"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль"),
    "forgetPasswordExpireTime": MessageLookupByLibrary.simpleMessage(
      "Время действия сброса пароля",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "forgotPasswordNavigating": MessageLookupByLibrary.simpleMessage(
      "Переход на страницу восстановления пароля",
    ),
    "forward": MessageLookupByLibrary.simpleMessage("Переслать"),
    "fullName": MessageLookupByLibrary.simpleMessage("Полное имя"),
    "gallery": MessageLookupByLibrary.simpleMessage("Галерея"),
    "globalSearch": MessageLookupByLibrary.simpleMessage("Глобальный поиск"),
    "googlePlayAppUrl": MessageLookupByLibrary.simpleMessage(
      "URL приложения в Google Play",
    ),
    "group": MessageLookupByLibrary.simpleMessage("Группа"),
    "groupCreatedBy": MessageLookupByLibrary.simpleMessage("Группу создал"),
    "groupDescription": MessageLookupByLibrary.simpleMessage("Описание группы"),
    "groupIcon": MessageLookupByLibrary.simpleMessage("Иконка группы"),
    "groupInfo": MessageLookupByLibrary.simpleMessage("Информация о группе"),
    "groupMembers": MessageLookupByLibrary.simpleMessage("Участники группы"),
    "groupName": MessageLookupByLibrary.simpleMessage("Имя группы"),
    "groupParticipants": MessageLookupByLibrary.simpleMessage(
      "Участники группы",
    ),
    "groupSettings": MessageLookupByLibrary.simpleMessage("Настройки группы"),
    "groupWith": MessageLookupByLibrary.simpleMessage("Группа с"),
    "harassmentOrBullyingDescription": MessageLookupByLibrary.simpleMessage(
      "Домогательство или запугивание: эта опция позволяет пользователям сообщать о лицах, нацеленных на них или других, с помощью домогательных сообщений, угроз или других форм запугивания.",
    ),
    "help": MessageLookupByLibrary.simpleMessage("Помощь"),
    "hiIamUse": MessageLookupByLibrary.simpleMessage("Привет, я использую"),
    "ifThisOptionDisabledTheCreateChatBroadcastWillBeBlocked":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция отключена, будет заблокировано создание трансляций чата",
        ),
    "ifThisOptionDisabledTheCreateChatGroupsWillBeBlocked":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция отключена, будет заблокировано создание групповых чатов",
        ),
    "ifThisOptionDisabledTheDesktopLoginOrRegisterWindowsMacWillBeBlocked":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция отключена, будет заблокирован вход или регистрация на рабочем столе (Windows и macOS)",
        ),
    "ifThisOptionDisabledTheMobileLoginOrRegisterWillBeBlockedOnAndroidIosOnly":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция включена, будет показываться баннер Google Ads в чатах",
        ),
    "ifThisOptionDisabledTheSendChatFilesImageVideosAndLocationWillBeBlocked":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция отключена, будет заблокирована отправка файлов чата, изображений, видео и местоположения",
        ),
    "ifThisOptionDisabledTheWebLoginOrRegisterWillBeBlocked":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция отключена, будет заблокирован вход или регистрация через веб",
        ),
    "ifThisOptionEnabledTheVideoAndVoiceCallWillBeAllowed":
        MessageLookupByLibrary.simpleMessage(
          "Если эта опция включена, разрешены видео и голосовые вызовы",
        ),
    "image": MessageLookupByLibrary.simpleMessage("Изображение"),
    "imageMessages": MessageLookupByLibrary.simpleMessage("Изображения"),
    "images": MessageLookupByLibrary.simpleMessage("Изображения"),
    "inAppAlerts": MessageLookupByLibrary.simpleMessage(
      "Оповещения в приложении",
    ),
    "inCall": MessageLookupByLibrary.simpleMessage("В разговоре"),
    "inappropriateContentDescription": MessageLookupByLibrary.simpleMessage(
      "Неуместное содержание: Пользователи могут выбрать эту опцию, чтобы сообщить о любом сексуально откровенном материале, ненавистнической речи, или другом контенте, который нарушает стандарты сообщества.",
    ),
    "info": MessageLookupByLibrary.simpleMessage("Информация"),
    "infoMessages": MessageLookupByLibrary.simpleMessage(
      "Информационные сообщения",
    ),
    "invalidCode": MessageLookupByLibrary.simpleMessage("Неверный код"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный адрес электронной почты",
    ),
    "invalidLoginData": MessageLookupByLibrary.simpleMessage(
      "Неверные данные для входа",
    ),
    "invalidVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Введенный вами код подтверждения недействителен. Пожалуйста, проверьте и попробуйте снова.",
    ),
    "ios": MessageLookupByLibrary.simpleMessage("iOS"),
    "isPrime": MessageLookupByLibrary.simpleMessage("Премиум пользователь"),
    "joinedAt": MessageLookupByLibrary.simpleMessage("Присоединился в"),
    "joinedBy": MessageLookupByLibrary.simpleMessage("Присоединился"),
    "kickMember": MessageLookupByLibrary.simpleMessage("Исключить участника"),
    "kickedBy": MessageLookupByLibrary.simpleMessage("Исключен"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "lastActiveFrom": MessageLookupByLibrary.simpleMessage(
      "Последняя активность с",
    ),
    "leaveGroup": MessageLookupByLibrary.simpleMessage("Покинуть группу"),
    "leaveGroupAndDeleteYourMessageCopy": MessageLookupByLibrary.simpleMessage(
      "Покинуть группу и удалить вашу копию сообщения",
    ),
    "leftTheGroup": MessageLookupByLibrary.simpleMessage("Покинул группу"),
    "linkADeviceSoon": MessageLookupByLibrary.simpleMessage(
      "Скоро подключить устройство",
    ),
    "linkByQrCode": MessageLookupByLibrary.simpleMessage("Ссылка по QR-коду"),
    "linkedDevices": MessageLookupByLibrary.simpleMessage(
      "Подключенные устройства",
    ),
    "links": MessageLookupByLibrary.simpleMessage("Ссылки"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "location": MessageLookupByLibrary.simpleMessage("Местоположение"),
    "locationMessages": MessageLookupByLibrary.simpleMessage("Местоположение"),
    "logOut": MessageLookupByLibrary.simpleMessage("Выйти"),
    "login": MessageLookupByLibrary.simpleMessage("Вход"),
    "loginAgain": MessageLookupByLibrary.simpleMessage("Войдите снова!"),
    "loginNowAllowedNowPleaseTryAgainLater":
        MessageLookupByLibrary.simpleMessage(
          "Вход разрешен. Пожалуйста, попробуйте позже.",
        ),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage(
      "Вход выполнен успешно!",
    ),
    "logoutFromAllDevices": MessageLookupByLibrary.simpleMessage(
      "Выйти со всех устройств?",
    ),
    "macOs": MessageLookupByLibrary.simpleMessage("macOS"),
    "makeCall": MessageLookupByLibrary.simpleMessage("Сделать звонок"),
    "media": MessageLookupByLibrary.simpleMessage("Медиа"),
    "mediaLinksAndDocs": MessageLookupByLibrary.simpleMessage(
      "Медиа, Ссылки и Документы",
    ),
    "member": MessageLookupByLibrary.simpleMessage("Участник"),
    "members": MessageLookupByLibrary.simpleMessage("Участники"),
    "messageCounter": MessageLookupByLibrary.simpleMessage("Счетчик сообщений"),
    "messageHasBeenDeleted": MessageLookupByLibrary.simpleMessage(
      "Сообщение удалено",
    ),
    "messageHasBeenViewed": MessageLookupByLibrary.simpleMessage(
      "Сообщение просмотрено",
    ),
    "messageInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о сообщении",
    ),
    "messagePrivatelyWithFriendsAndFamily":
        MessageLookupByLibrary.simpleMessage(
          "Отправляйте личные сообщения друзьям и семье через ваш браузер.",
        ),
    "messages": MessageLookupByLibrary.simpleMessage("Сообщения"),
    "microphoneAndCameraPermissionMustBeAccepted":
        MessageLookupByLibrary.simpleMessage(
          "Microphone and camera permission must be accepted",
        ),
    "microphonePermissionMustBeAccepted": MessageLookupByLibrary.simpleMessage(
      "Microphone permission must be accepted",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Минуты"),
    "more": MessageLookupByLibrary.simpleMessage("Еще"),
    "mute": MessageLookupByLibrary.simpleMessage("Отключить"),
    "muteNotifications": MessageLookupByLibrary.simpleMessage(
      "Отключить уведомления",
    ),
    "myPrivacy": MessageLookupByLibrary.simpleMessage("Моя конфиденциальность"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameMustHaveValue": MessageLookupByLibrary.simpleMessage(
      "Имя должно иметь значение",
    ),
    "nameRequired": MessageLookupByLibrary.simpleMessage(
      "Имя обязательно для заполнения",
    ),
    "needNewAccount": MessageLookupByLibrary.simpleMessage(
      "Нужен новый аккаунт?",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Ошибка сети. Пожалуйста, проверьте ваше соединение и попробуйте снова.",
    ),
    "newBroadcast": MessageLookupByLibrary.simpleMessage("Новая рассылка"),
    "newGroup": MessageLookupByLibrary.simpleMessage("Новая группа"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newPasswordMustHaveValue": MessageLookupByLibrary.simpleMessage(
      "Новый пароль должен иметь значение",
    ),
    "newUpdateIsAvailable": MessageLookupByLibrary.simpleMessage(
      "Доступно новое обновление",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Далее"),
    "nickname": MessageLookupByLibrary.simpleMessage("Никнейм"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noBio": MessageLookupByLibrary.simpleMessage("Нет биографии"),
    "noCodeHasBeenSendToYouToVerifyYourEmail":
        MessageLookupByLibrary.simpleMessage(
          "На ваш email не отправлен код для подтверждения",
        ),
    "noUpdatesAvailableNow": MessageLookupByLibrary.simpleMessage(
      "Сейчас нет доступных обновлений",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Нет"),
    "notAccepted": MessageLookupByLibrary.simpleMessage("Не принято"),
    "notification": MessageLookupByLibrary.simpleMessage("Уведомление"),
    "notificationDescription": MessageLookupByLibrary.simpleMessage(
      "Описание уведомления",
    ),
    "notificationTitle": MessageLookupByLibrary.simpleMessage(
      "Заголовок уведомления",
    ),
    "notificationsPage": MessageLookupByLibrary.simpleMessage(
      "Страница уведомлений",
    ),
    "off": MessageLookupByLibrary.simpleMessage("Выкл"),
    "offline": MessageLookupByLibrary.simpleMessage("Офлайн"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "oldPassword": MessageLookupByLibrary.simpleMessage("Старый пароль"),
    "on": MessageLookupByLibrary.simpleMessage("Вкл"),
    "oneSeenMessage": MessageLookupByLibrary.simpleMessage(
      "Одно просмотренное сообщение",
    ),
    "oneTimeSeen": MessageLookupByLibrary.simpleMessage("Просмотрено один раз"),
    "online": MessageLookupByLibrary.simpleMessage("В сети"),
    "openAppOnYourPhoneInstructions": MessageLookupByLibrary.simpleMessage(
      "1. Откройте приложение на своем телефоне. Нажмите Настройки на Android или на iPhone. Нажмите Связанные устройства, затем Привязать устройство. Наведите телефон на этот экран, чтобы сканировать QR-код.",
    ),
    "orLoginWith": MessageLookupByLibrary.simpleMessage(
      "или войдите с помощью",
    ),
    "other": MessageLookupByLibrary.simpleMessage("Другое"),
    "otherCategoryDescription": MessageLookupByLibrary.simpleMessage(
      "Другое: Эта общая категория может использоваться для нарушений, которые не легко подпадают под вышеуказанные категории. Может быть полезно включить текстовое поле, чтобы пользователи могли предоставить дополнительные сведения.",
    ),
    "otpCode": MessageLookupByLibrary.simpleMessage("OTP-код"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordHasBeenChanged": MessageLookupByLibrary.simpleMessage(
      "Пароль был изменен",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Пароль обязателен",
    ),
    "passwordMustHaveValue": MessageLookupByLibrary.simpleMessage(
      "Пароль должен иметь значение",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Пароль обязателен для заполнения",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Пароль должен содержать не менее 8 символов",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "peerUserDeviceOffline": MessageLookupByLibrary.simpleMessage(
      "Устройство пользователя недоступно",
    ),
    "peerUserInCallNow": MessageLookupByLibrary.simpleMessage(
      "Пользователь сейчас в разговоре",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Ожидает"),
    "phone": MessageLookupByLibrary.simpleMessage("Телефон"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "pleaseEnterValid6DigitCode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный 6-значный код",
    ),
    "pleaseEnterValidCode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите действительный 6-значный код",
    ),
    "pleaseEnterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите код подтверждения",
    ),
    "pleaseEnterYourName": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите свое имя",
    ),
    "pleaseProvideYourNameToContinue": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, укажите свое имя для продолжения",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "privacyUrl": MessageLookupByLibrary.simpleMessage(
      "URL политики конфиденциальности",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "promotedToAdminBy": MessageLookupByLibrary.simpleMessage(
      "Повышен до администратора",
    ),
    "public": MessageLookupByLibrary.simpleMessage("Общественный"),
    "read": MessageLookupByLibrary.simpleMessage("Прочитано"),
    "recentUpdate": MessageLookupByLibrary.simpleMessage("Недавнее обновление"),
    "recentUpdates": MessageLookupByLibrary.simpleMessage(
      "Последние обновления",
    ),
    "recording": MessageLookupByLibrary.simpleMessage("Запись..."),
    "reenterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Введите новый пароль еще раз",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "registerMethod": MessageLookupByLibrary.simpleMessage("Метод регистрации"),
    "registerStatus": MessageLookupByLibrary.simpleMessage(
      "Статус регистрации",
    ),
    "registrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Регистрация прошла успешно!",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Отклонено"),
    "repliedToYourSelf": MessageLookupByLibrary.simpleMessage(
      "Ответил самому себе",
    ),
    "reply": MessageLookupByLibrary.simpleMessage("Ответить"),
    "replyToYourSelf": MessageLookupByLibrary.simpleMessage(
      "Ответить самому себе",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Пожаловаться"),
    "reportHasBeenSubmitted": MessageLookupByLibrary.simpleMessage(
      "Ваше сообщение было отправлено",
    ),
    "reportUser": MessageLookupByLibrary.simpleMessage(
      "Пожаловаться на пользователя",
    ),
    "reports": MessageLookupByLibrary.simpleMessage("Отчеты"),
    "resend": MessageLookupByLibrary.simpleMessage("Отправить повторно"),
    "resendInSeconds": m0,
    "resetPassword": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "ring": MessageLookupByLibrary.simpleMessage("Звонок"),
    "roomAlreadyInCall": MessageLookupByLibrary.simpleMessage(
      "Комната уже в разговоре",
    ),
    "roomCounter": MessageLookupByLibrary.simpleMessage("Счетчик комнат"),
    "saveLogin": MessageLookupByLibrary.simpleMessage("Сохранить вход"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "searchByUserFullEmail": MessageLookupByLibrary.simpleMessage(
      "Искать по полной электронной почте",
    ),
    "searchByUserNameOrFullUserEmail": MessageLookupByLibrary.simpleMessage(
      "Искать по имени пользователя или полной электронной почте",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("секунд"),
    "send": MessageLookupByLibrary.simpleMessage("Отправить"),
    "sendCodeToMyEmail": MessageLookupByLibrary.simpleMessage(
      "Отправить код на мой email",
    ),
    "sendMessage": MessageLookupByLibrary.simpleMessage("Отправить сообщение"),
    "sendVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Отправить код подтверждения",
    ),
    "sentSixDigitCode": m1,
    "sessionEnd": MessageLookupByLibrary.simpleMessage("Конец сессии"),
    "setMaxBroadcastMembers": MessageLookupByLibrary.simpleMessage(
      "Установить максимальное количество участников трансляции",
    ),
    "setMaxGroupMembers": MessageLookupByLibrary.simpleMessage(
      "Установить максимальное количество участников группы",
    ),
    "setMaxMessageForwardAndShare": MessageLookupByLibrary.simpleMessage(
      "Установить максимальное количество сообщений для пересылки и обмена",
    ),
    "setNewPrivacyPolicyUrl": MessageLookupByLibrary.simpleMessage(
      "Установить новый URL политики конфиденциальности",
    ),
    "setToAdmin": MessageLookupByLibrary.simpleMessage(
      "Установить администратором",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "shareMediaAndLocation": MessageLookupByLibrary.simpleMessage(
      "Поделиться медиа и местоположением",
    ),
    "shareYourStatus": MessageLookupByLibrary.simpleMessage(
      "Поделитесь своим статусом",
    ),
    "showHistory": MessageLookupByLibrary.simpleMessage("Показать историю"),
    "showMedia": MessageLookupByLibrary.simpleMessage("Показать медиа"),
    "soon": MessageLookupByLibrary.simpleMessage("Скоро"),
    "spamOrScamDescription": MessageLookupByLibrary.simpleMessage(
      "Спам или мошенничество: с помощью этой опции пользователи могут сообщать о счетах, которые отправляют спам-сообщения, нежелательную рекламу или пытаются обмануть других.",
    ),
    "star": MessageLookupByLibrary.simpleMessage("Звезда"),
    "starMessage": MessageLookupByLibrary.simpleMessage("Звездное сообщение"),
    "starredMessage": MessageLookupByLibrary.simpleMessage(
      "Помеченное сообщение",
    ),
    "starredMessages": MessageLookupByLibrary.simpleMessage(
      "Помеченные сообщения",
    ),
    "startChat": MessageLookupByLibrary.simpleMessage("Начать чат"),
    "startNewChatWithYou": MessageLookupByLibrary.simpleMessage(
      "Начать новый чат с вами",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "storageAndData": MessageLookupByLibrary.simpleMessage(
      "Хранилище и данные",
    ),
    "storeUrls": MessageLookupByLibrary.simpleMessage("Ссылки на магазины"),
    "stories": MessageLookupByLibrary.simpleMessage("Истории"),
    "storyCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "История успешно создана",
    ),
    "success": MessageLookupByLibrary.simpleMessage("Успешно"),
    "successfullyDownloadedIn": MessageLookupByLibrary.simpleMessage(
      "Успешно скачано в",
    ),
    "supportChatSoon": MessageLookupByLibrary.simpleMessage(
      "Чат поддержки (скоро)",
    ),
    "syncContacts": MessageLookupByLibrary.simpleMessage(
      "Синхронизировать контакты",
    ),
    "tapADeviceToEditOrLogOut": MessageLookupByLibrary.simpleMessage(
      "Коснитесь устройства, чтобы отредактировать или выйти.",
    ),
    "tapForPhoto": MessageLookupByLibrary.simpleMessage("Коснитесь для фото"),
    "tapToSelectAnIcon": MessageLookupByLibrary.simpleMessage(
      "Коснитесь, чтобы выбрать иконку",
    ),
    "tellAFriend": MessageLookupByLibrary.simpleMessage("Расскажи другу"),
    "textFieldHint": MessageLookupByLibrary.simpleMessage(
      "Введите сообщение...",
    ),
    "textMessages": MessageLookupByLibrary.simpleMessage("Текстовые сообщения"),
    "thereIsFileHasSizeBiggerThanAllowedSize":
        MessageLookupByLibrary.simpleMessage(
          "Есть файл больше разрешенного размера",
        ),
    "thereIsVideoSizeBiggerThanAllowedSize":
        MessageLookupByLibrary.simpleMessage(
          "Есть видео больше разрешенного размера",
        ),
    "timeout": MessageLookupByLibrary.simpleMessage("Тайм-аут"),
    "titleIsRequired": MessageLookupByLibrary.simpleMessage(
      "Заголовок обязателен",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
    "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Слишком много попыток. Пожалуйста, попробуйте позже.",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Всего"),
    "totalMessages": MessageLookupByLibrary.simpleMessage("Всего сообщений"),
    "totalRooms": MessageLookupByLibrary.simpleMessage("Всего комнат"),
    "totalVisits": MessageLookupByLibrary.simpleMessage("Всего посещений"),
    "translate": MessageLookupByLibrary.simpleMessage("Перевести"),
    "typing": MessageLookupByLibrary.simpleMessage("Печатает..."),
    "unBlock": MessageLookupByLibrary.simpleMessage("Разблокировать"),
    "unBlockUser": MessageLookupByLibrary.simpleMessage(
      "Разблокировать пользователя",
    ),
    "unMute": MessageLookupByLibrary.simpleMessage("Включить"),
    "unStar": MessageLookupByLibrary.simpleMessage("Убрать звезду"),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
    "updateBroadcastTitle": MessageLookupByLibrary.simpleMessage(
      "Обновить заголовок рассылки",
    ),
    "updateFeedBackEmail": MessageLookupByLibrary.simpleMessage(
      "Обновить адрес электронной почты для обратной связи",
    ),
    "updateGroupDescription": MessageLookupByLibrary.simpleMessage(
      "Обновить описание группы",
    ),
    "updateGroupDescriptionWillUpdateAllGroupMembers":
        MessageLookupByLibrary.simpleMessage(
          "Обновление описания группы затронет всех участников группы",
        ),
    "updateGroupTitle": MessageLookupByLibrary.simpleMessage(
      "Обновить название группы",
    ),
    "updateImage": MessageLookupByLibrary.simpleMessage("Обновить изображение"),
    "updateNickname": MessageLookupByLibrary.simpleMessage("Обновить никнейм"),
    "updateTitle": MessageLookupByLibrary.simpleMessage("Обновить заголовок"),
    "updateTitleTo": MessageLookupByLibrary.simpleMessage(
      "Обновить заголовок на",
    ),
    "updateYourBio": MessageLookupByLibrary.simpleMessage(
      "Обновите свою биографию",
    ),
    "updateYourName": MessageLookupByLibrary.simpleMessage("Обновите свое имя"),
    "updateYourPassword": MessageLookupByLibrary.simpleMessage(
      "Обновите свой пароль",
    ),
    "updateYourProfile": MessageLookupByLibrary.simpleMessage(
      "Обновите свой профиль",
    ),
    "updatedAt": MessageLookupByLibrary.simpleMessage("Обновлено в"),
    "upgradeToAdmin": MessageLookupByLibrary.simpleMessage(
      "Повысить до администратора",
    ),
    "userAction": MessageLookupByLibrary.simpleMessage("Действия пользователя"),
    "userAlreadyRegister": MessageLookupByLibrary.simpleMessage(
      "Пользователь уже зарегистрирован",
    ),
    "userDeviceSessionEndDeviceDeleted": MessageLookupByLibrary.simpleMessage(
      "Сеанс устройства пользователя завершен, устройство удалено",
    ),
    "userEmailNotFound": MessageLookupByLibrary.simpleMessage(
      "Email пользователя не найден",
    ),
    "userInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о пользователе",
    ),
    "userName": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "userPage": MessageLookupByLibrary.simpleMessage("Страница пользователя"),
    "userProfile": MessageLookupByLibrary.simpleMessage("Профиль пользователя"),
    "userRegisterStatus": MessageLookupByLibrary.simpleMessage(
      "Статус регистрации пользователя",
    ),
    "userRegisterStatusNotAcceptedYet": MessageLookupByLibrary.simpleMessage(
      "Статус регистрации пользователя еще не принят",
    ),
    "users": MessageLookupByLibrary.simpleMessage("Пользователи"),
    "usersAddedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Пользователи успешно добавлены",
    ),
    "vMessageInfoTrans": MessageLookupByLibrary.simpleMessage(
      "Информация о сообщении",
    ),
    "vMessagesInfoTrans": MessageLookupByLibrary.simpleMessage(
      "Информация о сообщениях",
    ),
    "verificationFailed": m2,
    "verificationSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Срок действия сессии подтверждения истек. Пожалуйста, запросите новый код.",
    ),
    "verificationTimedOut": MessageLookupByLibrary.simpleMessage(
      "Время проверки истекло. Пожалуйста, попробуйте еще раз.",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("Подтверждено"),
    "verifiedAt": MessageLookupByLibrary.simpleMessage("Подтверждено"),
    "verify": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "video": MessageLookupByLibrary.simpleMessage("Видео"),
    "videoCallMessages": MessageLookupByLibrary.simpleMessage("Видеозвонки"),
    "videoMessages": MessageLookupByLibrary.simpleMessage("Видео сообщения"),
    "visits": MessageLookupByLibrary.simpleMessage("Посещения"),
    "voiceCall": MessageLookupByLibrary.simpleMessage("Голосовой вызов"),
    "voiceCallMessage": MessageLookupByLibrary.simpleMessage(
      "Голосовое сообщение",
    ),
    "voiceCallMessages": MessageLookupByLibrary.simpleMessage(
      "Голосовые вызовы",
    ),
    "voiceMessages": MessageLookupByLibrary.simpleMessage(
      "Голосовые сообщения",
    ),
    "wait2MinutesToSendMail": MessageLookupByLibrary.simpleMessage(
      "Подождите 2 минуты, чтобы отправить письмо",
    ),
    "waitingList": MessageLookupByLibrary.simpleMessage("Очередь ожидания"),
    "weHighRecommendToDownloadThisUpdate": MessageLookupByLibrary.simpleMessage(
      "Мы настоятельно рекомендуем скачать это обновление",
    ),
    "weWillSendYouAVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Мы отправим вам код подтверждения",
    ),
    "web": MessageLookupByLibrary.simpleMessage("Веб"),
    "welcome": MessageLookupByLibrary.simpleMessage("Добро пожаловать"),
    "whenUsingMobileData": MessageLookupByLibrary.simpleMessage(
      "При использовании мобильных данных",
    ),
    "whenUsingWifi": MessageLookupByLibrary.simpleMessage(
      "При использовании Wi-Fi",
    ),
    "whileAuthCanFindYou": MessageLookupByLibrary.simpleMessage(
      "Во время аутентификации не удалось найти вас",
    ),
    "windows": MessageLookupByLibrary.simpleMessage("Windows"),
    "writeACaption": MessageLookupByLibrary.simpleMessage(
      "Напишите подпись...",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
    "you": MessageLookupByLibrary.simpleMessage("Вы"),
    "youAreAboutToDeleteThisUserFromYourList":
        MessageLookupByLibrary.simpleMessage(
          "Вы собираетесь удалить этого пользователя из вашего списка",
        ),
    "youAreAboutToDeleteYourAccountYourAccountWillNotAppearAgainInUsersList":
        MessageLookupByLibrary.simpleMessage(
          "Вы собираетесь удалить свою учетную запись, и ваша учетная запись больше не будет отображаться в списке пользователей",
        ),
    "youAreAboutToDismissesToMember": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь уволить участника",
    ),
    "youAreAboutToKick": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь исключить",
    ),
    "youAreAboutToUpgradeToAdmin": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь повысить до администратора",
    ),
    "youDontHaveAccess": MessageLookupByLibrary.simpleMessage(
      "У вас нет доступа",
    ),
    "youInPublicSearch": MessageLookupByLibrary.simpleMessage(
      "Вы в публичном поиске",
    ),
    "youNotParticipantInThisGroup": MessageLookupByLibrary.simpleMessage(
      "Вы не участник этой группы",
    ),
    "yourAccountBlocked": MessageLookupByLibrary.simpleMessage(
      "Ваш аккаунт заблокирован",
    ),
    "yourAccountDeleted": MessageLookupByLibrary.simpleMessage(
      "Ваш аккаунт удален",
    ),
    "yourAccountIsUnderReview": MessageLookupByLibrary.simpleMessage(
      "Ваш аккаунт находится на рассмотрении",
    ),
    "yourAreAboutToLogoutFromThisAccount": MessageLookupByLibrary.simpleMessage(
      "Вы собираетесь выйти из этой учетной записи",
    ),
    "yourLastSeen": MessageLookupByLibrary.simpleMessage(
      "В последний раз видели",
    ),
    "yourLastSeenInChats": MessageLookupByLibrary.simpleMessage(
      "В последний раз видели в чатах",
    ),
    "yourProfileAppearsInPublicSearchAndAddingForGroups":
        MessageLookupByLibrary.simpleMessage(
          "Ваш профиль отображается в публичном поиске и добавлении в группы",
        ),
    "yourSessionIsEndedPleaseLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Ваша сессия завершена, пожалуйста, войдите снова!",
    ),
    "yourStory": MessageLookupByLibrary.simpleMessage("Ваша история"),
  };
}
