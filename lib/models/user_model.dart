// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   static const ID = "id";
//   static const NAME = "name";
//   static const EMAIL = "email";
//   static const PHONE = "phone";

//   String? id;
//   String? name;
//   String? email;
//   String? phone;

//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//   });

//   UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     name = snapshot[NAME];
//     email = snapshot[EMAIL];
//     id = snapshot[ID];
//     phone = snapshot[PHONE];
//   }

//   Map<String, Object?> toJson() => {
//         UserModel.EMAIL: email,
//         UserModel.ID: id,
//         UserModel.NAME: name,
//         UserModel.PHONE: phone,
//       };
// }
