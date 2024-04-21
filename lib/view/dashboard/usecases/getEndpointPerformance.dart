import 'package:atepp/modules/api/models/queries.dart';
import 'package:atepp/modules/api/services/queries.dart';
import 'package:atepp/modules/global/style.dart';
import 'package:flutter/material.dart';

class GetEndpointPerformance extends StatefulWidget {
  @override
  StateGetEndpointPerformance createState() => StateGetEndpointPerformance();
}

class StateGetEndpointPerformance extends State<GetEndpointPerformance> {
  late QueriesStatsService apiStatsQuery;
  int i = 0;
  List<QueriesStatsModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiStatsQuery = QueriesStatsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiStatsQuery.getStatsPerf(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesStatsModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesStatsModel> contents = snapshot.data ?? [];
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

  Widget _buildListView(List<QueriesStatsModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: [
          const Text(
            "Response Time Taken",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: textLG),
          ),
          const SizedBox(height: spaceSM),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(spaceXMD),
                    margin: EdgeInsets.only(right: spaceXSM),
                    decoration: BoxDecoration(
                        color: darkColor,
                        border: Border.all(color: dangerBG, width: 2)),
                    child: Column(
                      children: [
                        Text(
                          (() {
                            try {
                              return data
                                  .firstWhere((dt) => dt.ctx == 'Fast')
                                  .total
                                  .toString();
                            } catch (e) {
                              return '0';
                            }
                          })(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: textXJumbo),
                        ),
                        const Text(
                          "Fast Response",
                          style: TextStyle(fontSize: textXMD),
                        ),
                        const SizedBox(height: spaceXXSM),
                        Container(
                            decoration: const BoxDecoration(
                              color: successBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedMD)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: spaceMini, horizontal: spaceSM),
                            child: const Text(
                              "About < 1000 ms",
                              style: TextStyle(fontSize: textXSM),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(spaceXMD),
                    margin: EdgeInsets.only(right: spaceXSM),
                    decoration: BoxDecoration(
                        color: darkColor,
                        border: Border.all(color: dangerBG, width: 2)),
                    child: Column(
                      children: [
                        Text(
                          (() {
                            try {
                              return data
                                  .firstWhere((dt) => dt.ctx == 'Medium')
                                  .total
                                  .toString();
                            } catch (e) {
                              return '0';
                            }
                          })(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: textXJumbo),
                        ),
                        const Text(
                          "Medium Response",
                          style: TextStyle(fontSize: textXMD),
                        ),
                        const SizedBox(height: spaceXXSM),
                        Container(
                            decoration: const BoxDecoration(
                              color: warningBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedMD)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: spaceMini, horizontal: spaceSM),
                            child: const Text(
                              "1000 ms < Val < 3000 ms",
                              style: TextStyle(fontSize: textXSM),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(spaceXMD),
                    decoration: BoxDecoration(
                        color: darkColor,
                        border: Border.all(color: dangerBG, width: 2)),
                    child: Column(
                      children: [
                        Text(
                          (() {
                            try {
                              return data
                                  .firstWhere((dt) => dt.ctx == 'Slow')
                                  .total
                                  .toString();
                            } catch (e) {
                              return '0';
                            }
                          })(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: textXJumbo),
                        ),
                        const Text(
                          "Slow Response",
                          style: TextStyle(fontSize: textXMD),
                        ),
                        const SizedBox(height: spaceXXSM),
                        Container(
                            decoration: const BoxDecoration(
                              color: dangerBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(roundedMD)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: spaceMini, horizontal: spaceSM),
                            child: const Text(
                              "About > 3000 ms",
                              style: TextStyle(fontSize: textXSM),
                            ))
                      ],
                    ),
                  )
                ],
              ))
        ],
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
