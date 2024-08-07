class LanguageModel {
  int? id;
  String? languageTitle;
  String? languageCode;
  bool? isRTL;
  bool? isSelected;

  LanguageModel({
    this.id,
    this.languageTitle,
    this.languageCode,
    this.isRTL,
    this.isSelected = false,
  });
}