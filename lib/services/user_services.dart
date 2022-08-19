

import '../data/constants.dart';
import '../models/user_model.dart';

class UserServices {
  String collection = "USERS";

  void createUser(
      {String? id,
      String? name,
      String? email,
      String? phone,
     }) {
    firebaseFiretore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
      
    });
  }

  void updateUserData(Map<String, dynamic> values) {
    firebaseFiretore.collection(collection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserById(String id) =>
      firebaseFiretore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
