import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/model/demo.dart';
import 'package:login_firebase/model/the_user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  //Firestore change FirebaseFirestore
  final CollectionReference demoCollection =
      FirebaseFirestore.instance.collection('Demo');
  Future updateUserData(String sugars, String name, int strength) async {
    return await demoCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Demo list from snapshot
  List<Demo> _demoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Demo(
          name: e.get('name') ?? '',
          strength: e.get('strength') ?? 0,
          sugars: e.get('sugars') ?? '0');
    }).toList();
  }

  //TheUserData from snapshot
  TheUserData _theUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return TheUserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  Stream<List<Demo>> get Demos {
    return demoCollection.snapshots().map(_demoListFromSnapshot);
  }

  Stream<TheUserData> get userData {
    return demoCollection.doc(uid).snapshots().map(_theUserDataFromSnapshot);
  }
}
