import 'package:cloud_firestore/cloud_firestore.dart';



class DatabaseManager{
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String mobile, String email, String password, String location, String uid) async {
    return await profileList
        .doc(uid)
        .set({'name': name, 'mobile' : mobile, 'email': email, 'password': password, 'location' : location});
  }


  Future updateUserList(String name, String mobile, String email, String password, String location, String uid) async {
    return await profileList.doc(uid).update({
      'name': name, 'mobile' : mobile, 'email': email, 'password': password, 'location' : location,
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}