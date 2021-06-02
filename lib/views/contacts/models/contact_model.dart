
import 'dart:io';

class ContactModel {
  String id;
  String imageUrl;
  String name;
  String phoneNo;
  String email;
  File file;

  ContactModel(
      {
        this.name,
        this.id,
        this.phoneNo,
        this.imageUrl,
        this.email,
        this.file});
  ContactModel.fromJson(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.phoneNo = map['phoneNo'];
    this.imageUrl = map['imageUrl'];
    this.email = map['email'];
  }

  toMap() {
    return {
      'name': this.name,
      'phoneNo': this.phoneNo,
      'email': this.email,
      'imageUrl': this.imageUrl
    };
  }
}
