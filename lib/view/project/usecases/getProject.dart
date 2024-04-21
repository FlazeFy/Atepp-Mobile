import 'package:atepp/modules/api/project/models/queries.dart';
import 'package:atepp/modules/api/project/services/queries.dart';
import 'package:atepp/modules/global/global.dart';
import 'package:atepp/modules/global/style.dart';
import 'package:flutter/material.dart';

class GetProject extends StatefulWidget {
  const GetProject({super.key});

  @override
  StateGetProject createState() => StateGetProject();
}

class StateGetProject extends State<GetProject> {
  late QueriesProjectService apiProjectQuery;
  int i = 0;
  List<QueriesMyProjectModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    projectSlug.clear();
    projectSlug.add({'project_slug': '-', 'project_title': '-'});

    apiProjectQuery = QueriesProjectService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiProjectQuery.getListProject(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesMyProjectModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesMyProjectModel> contents = snapshot.data ?? [];
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

  Widget _buildListView(List<QueriesMyProjectModel> data) {
    if (data.isNotEmpty) {
      projectSlug.addAll(data
          .map((dt) => {'project_slug': dt.slug, 'project_title': dt.title}));

      return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.grey[900],
          ),
          child: DropdownButton<String>(
            value: selectedProject,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: whiteColor),
            underline: Container(
              height: 0,
              color: darkColor,
            ),
            onChanged: (String? value) {
              setState(() {
                selectedProject = value!;
              });
            },
            items: projectSlug.map<DropdownMenuItem<String>>((val) {
              return DropdownMenuItem<String>(
                value: val['project_slug']!,
                child: Text(val['project_title']!),
              );
            }).toList(),
          ));
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
