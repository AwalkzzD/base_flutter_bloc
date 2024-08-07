class DropDownOptionModel {
  dynamic key;
  String? value;
  dynamic extraKey;
  dynamic extraKeyTwo;
  dynamic extraKeyThree;

  DropDownOptionModel({
    this.value,
    this.key,
    this.extraKey,
    this.extraKeyTwo,
    this.extraKeyThree
  });

  @override
  String toString() {
    return value ?? "";
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DropDownOptionModel &&
            (identical(other.key, key) || other.key == key));
  }

/*  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DropDownOptionModel &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }*/

  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  Map<String, dynamic> toJson() => {
    "id": key,
    "description": value,
  };
}