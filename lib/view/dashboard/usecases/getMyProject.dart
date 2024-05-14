import 'package:atepp/modules/api/project/models/queries.dart';
import 'package:atepp/modules/api/project/services/queries.dart';
import 'package:atepp/modules/global/style.dart';
import 'package:atepp/modules/helpers/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GetMyProjectDetail extends StatefulWidget {
  @override
  StateGetMyProjectDetail createState() => StateGetMyProjectDetail();
}

class StateGetMyProjectDetail extends State<GetMyProjectDetail> {
  late QueriesProjectService apiProjectQuery;
  int i = 0;
  List<QueriesMyProjectDetailModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiProjectQuery = QueriesProjectService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiProjectQuery.getMyProject(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesMyProjectDetailModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesMyProjectDetailModel> contents = snapshot.data ?? [];
            return _buildListView(contents);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<QueriesMyProjectDetailModel> data) {
    if (data.isNotEmpty) {
      List<String> arrDate = [];
      for (var el in data) {
        arrDate.add(el.createdAt);
      }

      return Column(
        children: [
          const Text(
            "My Project",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          const SizedBox(height: spaceSM),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(spaceXMD),
                margin: const EdgeInsets.only(right: spaceXSM),
                width: Get.width * 0.46,
                height: 140,
                decoration: BoxDecoration(
                    color: darkColor,
                    border: Border.all(color: dangerBG, width: 2)),
                child: Column(
                  children: [
                    Text(
                      data.length.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: textXJumbo),
                    ),
                    const Text(
                      "My Project",
                      style: TextStyle(fontSize: textXMD),
                    ),
                    const SizedBox(height: spaceXXSM),
                    Container(
                        decoration: const BoxDecoration(
                          color: infoBG,
                          borderRadius:
                              BorderRadius.all(Radius.circular(roundedMD)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: spaceMini, horizontal: spaceSM),
                        child: Column(children: [
                          const Text(
                            "Last Activity",
                            style: TextStyle(fontSize: textXSM),
                          ),
                          Text(
                            generateLastDate(arrDate),
                            style: const TextStyle(fontSize: textXSM),
                          )
                        ]))
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 140,
                padding: const EdgeInsets.all(spaceXMD),
                width: Get.width * 0.46,
                decoration: BoxDecoration(
                    color: darkColor,
                    border: Border.all(color: dangerBG, width: 2)),
                child: Column(
                  children: [
                    const FaIcon(FontAwesomeIcons.fileExport,
                        color: whiteColor, size: textXJumbo * 1.75),
                    const Text(
                      "Import & Export",
                      style: TextStyle(fontSize: textXMD),
                    ),
                    const SizedBox(height: spaceXXSM),
                    Container(
                        decoration: const BoxDecoration(
                          color: infoBG,
                          borderRadius:
                              BorderRadius.all(Radius.circular(roundedMD)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: spaceMini, horizontal: spaceSM),
                        child: const Text(
                          "JSON, CSV, XLS",
                          style: TextStyle(fontSize: textXSM),
                        ))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: spaceSM),
          Column(
              children: data.map((dt) {
            return Container(
                padding: const EdgeInsets.all(spaceXMD),
                margin: const EdgeInsets.only(bottom: spaceXMD),
                width: Get.width,
                decoration: BoxDecoration(
                    color: darkColor,
                    border: Border.all(color: dangerBG, width: 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dt.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: textLG)),
                    const SizedBox(height: spaceSM),
                    Container(
                        margin: const EdgeInsets.only(bottom: spaceXMD),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: spaceMD, vertical: 4.5),
                                decoration: const BoxDecoration(
                                    color: successBG,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(roundedLG))),
                                child: Text(dt.category,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: textLG))),
                            const SizedBox(width: spaceSM),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: spaceSM, vertical: 4.5),
                                decoration: const BoxDecoration(
                                    color: infoBG,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(roundedLG))),
                                child: Text("${dt.totalEndpoint} endpoint",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: textLG))),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spaceSM, vertical: 4.5),
                        child: Column(children: [
                          Text(
                              "${dt.desc == null ? "- No Description Provided -" : dt.desc}")
                        ])),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spaceSM, vertical: 4.5),
                        child: Column(children: [
                          Text(
                              "${getDateToContext(DateTime.parse(dt.createdAt), 'calendar')}")
                        ])),
                  ],
                ));
          }).toList())
        ],
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
