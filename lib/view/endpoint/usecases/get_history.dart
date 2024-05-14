import 'package:atepp/modules/api/history/models/queries.dart';
import 'package:atepp/modules/api/history/services/queries.dart';
import 'package:atepp/modules/global/style.dart';
import 'package:flutter/material.dart';

class GetHistory extends StatefulWidget {
  final String id;
  const GetHistory({required this.id});

  @override
  StateGetHistory createState() => StateGetHistory();
}

class StateGetHistory extends State<GetHistory> {
  late QueriesHistoryService apiHistoryQuery;
  List<QueriesHistoryModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiHistoryQuery = QueriesHistoryService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiHistoryQuery.getListHistory(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesHistoryModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesHistoryModel> contents = snapshot.data ?? [];
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

  Widget _buildListView(List<QueriesHistoryModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: [
          const Text(
            "History",
          ),
          const SizedBox(height: spaceSM),
          Column(
              children: data.map<Widget>((e) {
            double resTime = double.parse(e.resTime);

            return Container(
                margin: const EdgeInsets.only(bottom: spaceLG),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          margin: const EdgeInsets.only(right: spaceSM),
                          padding:
                              const EdgeInsets.symmetric(horizontal: spaceSM),
                          decoration: const BoxDecoration(
                              color: successBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedLG))),
                          child: Text(e.resMethod)),
                      Container(
                          margin: const EdgeInsets.only(right: spaceSM),
                          padding:
                              const EdgeInsets.symmetric(horizontal: spaceSM),
                          decoration: const BoxDecoration(
                              color: successBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedLG))),
                          child: Text(e.resStatus)),
                      Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: spaceSM),
                          decoration: BoxDecoration(
                              color: resTime > 3000
                                  ? dangerBG
                                  : resTime > 1000
                                      ? warningBG
                                      : successBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedLG))),
                          child: Text(" ${resTime.toStringAsFixed(2)} ms"))
                    ]),
                    Container(
                      margin: const EdgeInsets.only(top: spaceXSM),
                      child: Text("On ${e.endpointName} from ${e.resEnv}"),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: spaceSM),
                        padding: const EdgeInsets.all(spaceXSM),
                        decoration: BoxDecoration(
                            color: darkColor,
                            border: Border.all(
                                color: primaryColor, width: spaceMini / 3)),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: textXLG,
                                  color: whiteColor,
                                ),
                              ),
                              TextSpan(
                                  text: " Response Body",
                                  style: TextStyle(fontSize: textXMD)),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => {},
                    )
                  ],
                ));
          }).toList()),
        ],
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
