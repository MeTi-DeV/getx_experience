import 'package:cloud_firestore/cloud_firestore.dart';
//comment : it's my user model
class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";

   String id;
   String name;
   String email;

  UserModel({this.id, this.name, this.email});
//comment
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
  }
}
