class UpdateContactResourceParameters {
  String? address;
  String? city;
  String? postCode;
  String? area;
  String? mobilePhone;
  String? homePhone;
  String? email;
  String? taxId;
  String? image;
  bool? updateOfficialContact;

  UpdateContactResourceParameters(
      {this.address,
      this.city,
      this.postCode,
      this.area,
      this.mobilePhone,
      this.homePhone,
      this.email,
      this.taxId,
      this.image,
      this.updateOfficialContact});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (address != null) {
      data['address'] = address;
    }
    if (city != null) {
      data['city'] = city;
    }
    if (postCode != null) {
      data['postCode'] = postCode;
    }
    if (area != null) {
      data['area'] = area;
    }
    if (mobilePhone != null) {
      data['mobilePhone'] = mobilePhone;
    }
    if (homePhone != null) {
      data['homePhone'] = homePhone;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (taxId != null) {
      data['taxId'] = taxId;
    }
    if (image != null) {
      data['image'] = image;
    }
    if (updateOfficialContact != null) {
      data['updateOfficialContact'] = updateOfficialContact;
    }
    return data;
  }
}
