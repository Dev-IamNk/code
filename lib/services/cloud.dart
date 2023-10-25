
import 'package:cloud_firestore/cloud_firestore.dart';

class Databased{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addData(Map<String,dynamic> data) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add(data);
  }

}