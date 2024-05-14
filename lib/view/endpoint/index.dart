import 'package:atepp/modules/global/style.dart';
import 'package:atepp/view/endpoint/usecases/get_endpoint_exec.dart';
import 'package:flutter/material.dart';

class EndpointPage extends StatefulWidget {
  const EndpointPage({super.key});

  @override
  StateEndpointPageState createState() => StateEndpointPageState();
}

const List<String> listMethod = <String>[
  'GET',
  'POST',
  'PUT',
  'DELETE',
  'PATCH',
  'HEAD',
  'OPTIONS'
];
const List<String> listSend = <String>[
  '-',
  'Send',
  'Send & Download',
  'Send & Share'
];

class StateEndpointPageState extends State<EndpointPage> {
  String selectedMethod = listMethod.first;
  String selectedSend = listSend.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(color: whiteColor),
          iconTheme: const IconThemeData(color: whiteColor),
          title: const Text('Endpoint', style: TextStyle(color: whiteColor)),
          backgroundColor: darkColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Setting',
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: [GetEndpointExec()],
        ));
  }
}
