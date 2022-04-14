import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/model/the_user.dart';
import 'package:login_firebase/screens/services/database.dart';
import 'package:login_firebase/shared/constants.dart';
import 'package:login_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currenStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<TheUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TheUserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'update your demo setting.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: TextInputDecoration,
                    validator: (value) {
                      value!.isEmpty ? 'Please enter a name' : null;
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: TextInputDecoration,
                    items: sugar.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),

                  Slider(
                    value: (_currenStrength ?? userData.strength).toDouble(),
                    //value: (userData.strength)!.toDouble(),
                    activeColor:
                        Colors.brown[_currenStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currenStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currenStrength = val.round()),
                  ),
                  //slider
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400],
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
                      'Update',
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currenStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
