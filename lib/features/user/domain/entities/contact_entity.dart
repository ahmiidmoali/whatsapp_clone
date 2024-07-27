// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class ContactEntity {
  final String? phoneNumber;
  final String? lable;
  final String? uid;
  final String? status;
  final Uint8List? userProfile;
  ContactEntity({
    this.phoneNumber,
    this.lable,
    this.uid,
    this.status,
    this.userProfile,
  });
}
