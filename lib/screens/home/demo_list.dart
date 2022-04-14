import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/model/demo.dart';
import 'package:login_firebase/screens/home/demo_tile.dart';
import 'package:provider/provider.dart';

class DemoList extends StatefulWidget {
  const DemoList({Key? key}) : super(key: key);

  @override
  State<DemoList> createState() => _DemoListState();
}

class _DemoListState extends State<DemoList> {
  @override
  Widget build(BuildContext context) {
    final demos = Provider.of<List<Demo>>(context); // ?? [];

    return ListView.builder(
      itemCount: demos.length,
      itemBuilder: (context, index) {
        return DemoTile(demo: demos[index]);
      },
    );
  }
}
