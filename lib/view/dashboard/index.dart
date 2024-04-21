import 'package:atepp/modules/global/style.dart';
import 'package:atepp/view/dashboard/usecases/getEndpointPerformance.dart';
import 'package:atepp/view/dashboard/usecases/getMyProject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  StateDashboardPageState createState() => StateDashboardPageState();
}

class StateDashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(
          top: Get.height * 0.02, left: spaceXSM, right: spaceXSM),
      children: [GetEndpointPerformance(), GetMyProjectDetail()],
    ));
  }
}
