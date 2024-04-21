import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  StateDummyPageState createState() => StateDummyPageState();
}

class StateDummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox());
  }
}
