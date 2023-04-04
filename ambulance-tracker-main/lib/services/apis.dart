import 'package:ambulance_tracker/models/hospitalRequsr.dart';
import 'package:ambulance_tracker/models/user.dart';
import 'package:ambulance_tracker/screens/driver_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class apis {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get user => auth.currentUser!;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallavailableusers() {
    return firestore
        .collection('users')
        .where('isFree', isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getworkingusers() {
    return firestore
        .collection('users')
        .where('isFree', isEqualTo: false)
        .where('isAvailable', isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getofflineusers() {
    return firestore
        .collection('users')
        .where('isFree', isEqualTo: false)
        .where('isAvailable', isEqualTo: false)
        .snapshots();
  }

  static Future<void> createuser(String drivername, String reg_id) async {
    final users = Users(
        isAvailable: false,
        isFree: false,
        name: drivername,
        id: 4,
        regId: reg_id);

    return await firestore.collection('users').doc().set(users.toJson());
  }

  static void createRequest(String currLoc) async {
    final requests = Requests(name: "Aman", location: currLoc);

    return await firestore.collection('requests').doc().set(requests.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallRequests() {
    return firestore.collection('requests').snapshots();
  }
}
