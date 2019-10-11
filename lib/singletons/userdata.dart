
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static final UserData _userData = UserData._internal();

  String title = '';
  String description = '';
  String icon = '';
  String color = '';
  String type = '';
  String length = '';
  int amount;
  String date = '';
  String uid = '';

  QuerySnapshot users;
  Stream posts;
  DocumentSnapshot viewUser;

  factory UserData() {
    return _userData;
  }

  UserData._internal();
}

final userData = UserData();