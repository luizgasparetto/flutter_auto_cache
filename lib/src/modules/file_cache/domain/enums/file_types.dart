enum FileTypes { png, jpg, jpeg, none }

extension FileTypeParser on FileTypes {
  static FileTypes fromString(String value) {
    return FileTypes.values.firstWhere(
      (type) => type.name == value.toLowerCase(),
      orElse: () => FileTypes.none,
    );
  }
}
