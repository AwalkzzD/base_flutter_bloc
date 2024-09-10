import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/cards/cards_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/cards/cards_provider.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../remote/repository/cards_repository/response/card_data_response.dart';
import '../../remote/repository/settings/response/app_settings_response.dart';
import '../../remote/repository/user/response/institute_response.dart';
import '../../remote/repository/user/response/student_relative_extended.dart';
import '../../utils/auth/user_claim_helper.dart';
import '../../utils/auth/user_common_api.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/enum_to_string/enum_to_string.dart';
import '../../utils/stream_helper/common_enums.dart';
import '../../utils/stream_helper/settings_utils.dart';

class CardsBloc extends BaseBloc {
  CardSettingsData? cardSettings;
  String? instituteImg;
  String? instituteName;
  String? customText;
  Color? customBgColor;

  String? userImg;
  String? usersName;
  String? usersNameLabel;
  String? userEmail;
  String? userCode;
  String? pinCode;
  String? phones;
  String? globalRegistrationNumber;
  String? educationalPrograms;

  String? cardCode;
  String? benefitsCardCode;
  DateTime? cardExpirationDate;
  String? cardQrCode;
  String? benefitsCardQrCode;

  void resetValues() {
    instituteImg = null;
    instituteName = null;
    customText = null;
    customBgColor = null;
    userImg = null;
    usersName = null;
    usersNameLabel = null;
    userEmail = null;
    userCode = null;
    pinCode = null;
    phones = null;
    globalRegistrationNumber = null;
    educationalPrograms = null;
    cardCode = null;
    benefitsCardCode = null;
    cardExpirationDate = null;
    cardQrCode = null;
    benefitsCardQrCode = null;
  }

  CardsBloc() {
    on<CardsBlocEvent>((event, emit) async {
      switch (event) {
        /// LoadCardSettingsEvent
        case LoadCardSettingsEvent loadCardSettingsEvent:
          emit(const LoadingState());
          resetValues();
          List<SettingsValue> settingValues = [
            SettingsValue.AvailableDataForCards,
            SettingsValue.CustomColorForCards,
            SettingsValue.CustomTextForCards,
            SettingsValue.CustomColorForTextOnCards,
          ];
          await SettingsProvider.settingsRepository.apiApplicationSettings(
            settingValues,
            (response) {
              CardSettingsData cardSettingsData = CardSettingsData();
              AppSettingsResponse? availableDataForCards = response.data
                  .firstWhereOrNull((element) =>
                      element.setting ==
                      EnumToString.convertToString(
                          SettingsValue.AvailableDataForCards));
              if (availableDataForCards != null) {
                String? data = availableDataForCards.value ?? "";
                cardSettingsData.availableDataForCards = data;
              }
              AppSettingsResponse? customTextForCards = response.data
                  .firstWhereOrNull((element) =>
                      element.setting ==
                      EnumToString.convertToString(
                          SettingsValue.CustomTextForCards));
              if (customTextForCards != null) {
                String? data = customTextForCards.value ?? "";
                cardSettingsData.customTextForCards = data;
              }
              AppSettingsResponse? customColorForTextOnCards = response.data
                  .firstWhereOrNull((element) =>
                      element.setting ==
                      EnumToString.convertToString(
                          SettingsValue.CustomColorForTextOnCards));
              if (customColorForTextOnCards != null) {
                String? data = customColorForTextOnCards.value;
                cardSettingsData.textColor =
                    data != null ? HexColor(data) : themeOf().accentColor;
              }
              AppSettingsResponse? customColorForCards = response.data
                  .firstWhereOrNull((element) =>
                      element.setting ==
                      EnumToString.convertToString(
                          SettingsValue.CustomColorForCards));
              if (customColorForCards != null) {
                String? data = customColorForCards.value;
                cardSettingsData.backgroundColor =
                    data != null ? HexColor(data) : Colors.transparent;
              }
              cardSettings = cardSettingsData;

              add(LoadCardDataEvent(
                  selectedStudent: loadCardSettingsEvent.selectedStudent));
            },
            (error) {
              emit(ErrorState(error.errorMsg));
            },
          );

        /// LoadCardDataEvent
        case LoadCardDataEvent loadCardDataEvent:
          emit(const LoadingState());

          int? entityId = getRequestProperties()?.entityId;
          UserTypes? userTypes = getRequestProperties()?.userType;
          String entityType;
          if (userTypes == UserTypes.Teacher) {
            entityType = EnumToString.convertToString(CardEntityType.Teacher);
          } else if (userTypes == UserTypes.Secretary) {
            entityType = EnumToString.convertToString(CardEntityType.Employee);
          } else if (userTypes == UserTypes.Parent) {
            if (entityId == loadCardDataEvent.selectedStudent?.id) {
              entityType =
                  EnumToString.convertToString(CardEntityType.Relative);
            } else {
              entityType = EnumToString.convertToString(CardEntityType.Student);
              entityId = loadCardDataEvent.selectedStudent?.id;
            }
          } else {
            entityType = EnumToString.convertToString(userTypes);
          }

          await CardsProvider.cardsRepository.apiGetCardData(
            entityId,
            entityType,
            (response) {
              add(LoadAllDataEvent(
                  selectedStudent: loadCardDataEvent.selectedStudent,
                  cardDataResponse: response.data));
            },
            (error) {
              emit(ErrorState(error.errorMsg));
            },
          );

        /// LoadAllDataEvent
        case LoadAllDataEvent loadAllDataEvent:
          await loadAllData(loadAllDataEvent.selectedStudent,
              loadAllDataEvent.cardDataResponse, () {
            emit(DataState(loadAllDataEvent.cardDataResponse));
          });
      }
    });
  }

  Future<void> loadAllData(StudentForRelativeExtended? selectedStudent,
      CardDataResponse? cardData, Function() onSuccess) async {
    List<String> availableCardsData = [];
    if (cardSettings?.availableDataForCards != null &&
        cardSettings?.availableDataForCards?.isNotEmpty == true) {
      availableCardsData =
          cardSettings?.availableDataForCards?.split(",") ?? [];
    }

    InstituteResponse? institute = getInstitute();
    if (institute != null) {
      if (institute.image != null &&
          institute.image?.isNotEmpty == true &&
          isEnumValueInList(
              availableCardsData, CardMobileDataPageProperties.InstituteLogo)) {
        instituteImg = institute.image;
      }
      if (institute.image != null &&
          institute.image?.isNotEmpty == true &&
          isEnumValueInList(
              availableCardsData, CardMobileDataPageProperties.InstituteName)) {
        instituteName = institute.name;
      }
    }

    if (cardSettings?.customTextForCards != null &&
        isEnumValueInList(
            availableCardsData, CardMobileDataPageProperties.CustomText)) {
      customText = cardSettings?.customTextForCards;
    }
    if (cardSettings?.backgroundColor != null &&
        isEnumValueInList(
            availableCardsData, CardMobileDataPageProperties.CustomColor)) {
      customBgColor = cardSettings?.backgroundColor;
    }

    /// Users
    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.Name)) {
      usersName =
          "${cardData?.cardHolder?.firstName} ${cardData?.cardHolder?.lastName}";
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.NameLabel)) {
      usersNameLabel = string("profile.label_name");
    } else {
      usersNameLabel = "";
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.Email)) {
      userEmail = cardData?.cardHolder?.email;
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.UserCode)) {
      userCode = getRequestPropertiesData()?.entityId.toString();
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.PinCode)) {
      pinCode = "Pin: ${cardData?.cardHolder?.pinCode}";
    }

    String userHomePhone = "";
    String userMobilePhone = "";

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.HomePhone)) {
      userHomePhone = cardData?.cardHolder?.homePhone ?? "";
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.MobilePhone)) {
      userMobilePhone = cardData?.cardHolder?.mobilePhone ?? "";
    }

    phones = userHomePhone.isNotEmpty
        ? (userMobilePhone.isNotEmpty
            ? '$userHomePhone, $userMobilePhone'
            : userHomePhone)
        : userMobilePhone;

    if (isEnumValueInList(availableCardsData,
            CardMobileDataPageProperties.GlobalRegistrationNumber) &&
        isUserStudent == true) {
      globalRegistrationNumber = cardData?.cardHolder?.globalRegistrationNumber;
    }

    /// Cards
    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.CardCode)) {
      cardCode = cardData?.cardIdNumber;
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.CardBenefitsCode)) {
      benefitsCardCode = cardData?.cardIdNumberBenefits;
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.ExpirationDate)) {
      cardExpirationDate = cardData?.expirationDate;
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.Card)) {
      cardQrCode = cardData?.qrCode;
    }

    if (isEnumValueInList(
        availableCardsData, CardMobileDataPageProperties.Card)) {
      benefitsCardQrCode = cardData?.qrCode;
    }

    //if(isEnumValueInList(availableCardsData, CardMobileDataPageProperties.QrCodeBenefits)) {
    benefitsCardQrCode = cardData?.qrCodeBenefits;
    //}

    if (isEnumValueInList(
            availableCardsData, CardMobileDataPageProperties.Photo) ||
        isEnumValueInList(availableCardsData,
            CardMobileDataPageProperties.EducationalPrograms)) {
      int? entityId = getUser()?.id;
      String? image = getUser()?.image;
      if (isUserStudent == true) {
        entityId = selectedStudent?.id;
        image = selectedStudent?.image;
      }
      if (isUserParent == true &&
          selectedStudent?.id != getRequestProperties()?.entityId) {
        entityId = selectedStudent?.id;
        image = selectedStudent?.image;
      }
      userImg = image;

      if (isEnumValueInList(availableCardsData,
              CardMobileDataPageProperties.EducationalPrograms) &&
          (isUserStudent == true ||
              (isUserParent == true &&
                  selectedStudent?.id != getRequestProperties()?.entityId))) {
        await getStudentEducationalPrograms(
          selectedStudent?.id,
          (programs) {
            if (programs.isNotEmpty) {
              educationalPrograms = programs
                  .map((c) =>
                      '${c.grade?.description} (${c.stream?.description})')
                  .join(',');
              onSuccess.call();
            } else {
              onSuccess.call();
            }
          },
          (error) {},
        );
      } else {
        onSuccess.call();
      }
    } else {
      onSuccess.call();
    }
  }

  /// Check if the enum value exists in the list
  /// Returns bool value.
  bool isEnumValueInList(
      List<String> availableCardsData, CardMobileDataPageProperties property) {
    return availableCardsData.contains(property.index.toString());
  }
}

class CardSettingsData {
  String? availableDataForCards;
  String? customTextForCards;
  Color? textColor;
  Color? backgroundColor;

  CardSettingsData();
}
