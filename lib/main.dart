import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/model/the_user.dart';
import 'package:login_firebase/screens/services/auth.dart';
import 'package:login_firebase/screens/warapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        home: Warapper(),
      ),
    );
  }
}
