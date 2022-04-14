import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/model/demo.dart';
import 'package:login_firebase/screens/home/demo_list.dart';
import 'package:login_firebase/screens/home/setting_form.dart';
import 'package:login_firebase/screens/services/auth.dart';
import 'package:login_firebase/screens/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Demo>>.value(
      value: DatabaseService(uid: '').Demos,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Home login'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _authService.signOut();
                await FirebaseAuth.instance.signOut();
              },
            ),
            TextButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text('setting'),
                onPressed: () {
                  _showSettingsPanel(context);
                }),
          ],
        ),
        body: const DemoList(),
      ),
    );
  }

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: const SettingForm(),
          );
        });
  }
}
