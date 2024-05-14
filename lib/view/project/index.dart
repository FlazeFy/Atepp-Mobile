import 'package:atepp/modules/global/style.dart';
import 'package:atepp/view/endpoint/index.dart';
import 'package:atepp/view/project/usecases/getProject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  StateProjectPageState createState() => StateProjectPageState();
}

class StateProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: Get.height * 0.02, left: spaceXSM, right: spaceXSM),
        children: [
          GetProject(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: successBG,
        onPressed: () {
          Get.to(const EndpointPage());
        },
        child: const Icon(
          Icons.play_arrow,
          size: textXJumbo * 1.2,
        ),
      ),
    );
  }
}
