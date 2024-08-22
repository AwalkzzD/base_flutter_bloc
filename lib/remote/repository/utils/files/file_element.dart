import '../../../../utils/file_picker/file_picker_utils.dart';

class FileElement {
  int? id;
  String? name;
  String? extension;
  int? size;
  String? provider;
  String? link;

  FileElement({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.provider,
    this.link,
  });

  CustomFileData toCustomFileData() {
    if (provider == "Link") {
      return CustomFileData(
          id, "$name", extension, link, size, CustomFileType.Link, true);
    } else {
      return CustomFileData(id, "$name$extension", extension, link, size,
          CustomFileType.BlobStorage, true);
    }
  }

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        name: json["name"],
        extension: json["extension"],
        size: json["size"],
        provider: json["provider"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "extension": extension,
        "size": size,
        "provider": provider,
        "link": link,
      };

  String getSize() {
    if (link != null) {
      return FilePickerUtils.getFileSize(size ?? 0, 1);
    } else {
      return "-";
    }
  }

  bool isValidURL() => Uri.parse(link ?? "").isAbsolute;
}
