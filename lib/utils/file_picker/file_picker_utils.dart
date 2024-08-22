import 'dart:math';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {
  static Future<FilePickerResult?> pickFile({bool allowMultiple = true}) async {
    return await FilePicker.platform.pickFiles(allowMultiple: allowMultiple);
  }

  static getFileSize(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static FileData toFileData(PlatformFile file) {
    return FileData(file.path, file.name, file.extension, file.size);
  }

  static CustomFileData toCustomFileData(PlatformFile file) {
    return CustomFileData(0, file.name, file.extension, file.path, file.size,
        CustomFileType.BlobStorage, false);
  }

  static List<CustomFileData> toCustomFileDataList(List<PlatformFile> files) {
    return files.map((e) => toCustomFileData(e)).toList();
  }

  static List<FileData> toFileDataList(List<PlatformFile> files) {
    return files.map((e) => toFileData(e)).toList();
  }
}

enum CustomFileType { BlobStorage, Link }

class CustomFileData {
  final int? id;
  final String? name;
  final String? extension;
  final String? path;
  final int? size;
  final CustomFileType? type;
  final bool isFromNetwork;

  CustomFileData(this.id, this.name, this.extension, this.path, this.size,
      this.type, this.isFromNetwork);

  String getSize() {
    if (path != null) {
      return FilePickerUtils.getFileSize(size ?? 0, 1);
    } else {
      return "-";
    }
  }

  bool isValidURL() => Uri.parse(path ?? "").isAbsolute;
}

class FileData {
  final int? id;
  final String? path;
  final String? name;
  final String? extension;
  final int? size;
  final bool isFromNetwork;

  FileData(this.path, this.name, this.extension, this.size,
      {this.id, this.isFromNetwork = false});

  String getSize() {
    if (path != null) {
      return FilePickerUtils.getFileSize(size ?? 0, 1);
    } else {
      return "-";
    }
  }
}
