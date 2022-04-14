import 'package:flutter/material.dart';
import 'package:login_firebase/model/the_user.dart';
import 'package:login_firebase/screens/authenticate/authenticate.dart';
import 'package:login_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Warapper extends StatelessWidget {
  const Warapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
