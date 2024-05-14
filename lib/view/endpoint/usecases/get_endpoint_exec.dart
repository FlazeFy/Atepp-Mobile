import 'dart:convert';

import 'package:atepp/modules/global/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;

class GetEndpointExec extends StatefulWidget {
  const GetEndpointExec({super.key});

  @override
  StateGetEndpointExecState createState() => StateGetEndpointExecState();
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

class StateGetEndpointExecState extends State<GetEndpointExec> {
  String selectedMethod = listMethod.first;
  String selectedSend = listSend.first;
  Client client = Client();
  var urlCtrl = TextEditingController();

  // Result
  String responseText = '';
  int responseCode = 0;
  Color colorResponse = successBG;

  Future sendEndpoint() async {
    final header = {
      'Accept': 'application/json',
    };

    // https://mifik.leonardhors.site/api/v1/dictionaries/type/TAG-001
    final response = await client.get(Uri.parse(urlCtrl.text), headers: header);
    setState(() {
      responseCode = response.statusCode;
    });
    if (response.statusCode == 200) {
      setState(() {
        responseText = const JsonEncoder.withIndent('  ')
            .convert(json.decode(response.body));
      });
    } else {
      setState(() {
        responseText = response.statusCode.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[900],
                ),
                child: DropdownButton<String>(
                  value: selectedMethod,
                  icon: null,
                  elevation: 16,
                  style: const TextStyle(color: whiteColor),
                  underline: Container(
                    height: 0,
                    color: darkColor,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                  items:
                      listMethod.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            const Spacer(),
            Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[900],
                ),
                child: DropdownButton<String>(
                  value: selectedSend,
                  icon: null,
                  elevation: 16,
                  style: const TextStyle(color: whiteColor),
                  underline: Container(
                    height: 0,
                    color: darkColor,
                  ),
                  onChanged: (String? value) {
                    sendEndpoint();
                  },
                  items: listSend.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
        const SizedBox(height: spaceSM),
        TextField(
          controller: urlCtrl,
          decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: spaceMD),
              border: OutlineInputBorder(),
              labelText: 'Endpoint URL',
              labelStyle: TextStyle(color: whiteColor)),
        ),
        const SizedBox(height: spaceMD),
        Row(
          children: [
            const Text("Response"),
            const SizedBox(
              width: spaceMD,
            ),
            responseCode != 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: spaceSM, vertical: spaceMini),
                    decoration: BoxDecoration(
                        color: colorResponse,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(roundedLG))),
                    child: Text(responseCode.toString()))
                : const SizedBox()
          ],
        ),
        SizedBox(height: spaceMD),
        Text(responseText)
      ],
    );
  }
}
