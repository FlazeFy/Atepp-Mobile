import 'package:atepp/modules/global/global.dart';
import 'package:atepp/modules/global/style.dart';
import 'package:atepp/view/dashboard/index.dart';
import 'package:atepp/view/dummy/index.dart';
import 'package:atepp/view/global/index.dart';
import 'package:atepp/view/project/index.dart';
import 'package:atepp/view/workingspace/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final List<Widget> _widgetOptions = <Widget>[
    const DashboardPage(),
    const ProjectPage(),
    const WorkingSpace(),
    const DummyPage(),
    const GlobalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(roundedLG),
              topLeft: Radius.circular(roundedLG),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.tableColumns),
                      label: 'Dashboard',
                      key: ValueKey('dashboard_nav')),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.folder),
                      label: 'Project',
                      key: ValueKey('project_nav')),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.sliders),
                      label: 'WorkingSpace',
                      key: ValueKey('workingspace_nav')),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.robot),
                      label: 'Dummy',
                      key: ValueKey('dummy_nav')),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.globe),
                      label: 'Global',
                      key: ValueKey('global_nav')),
                ],
                backgroundColor: darkColor,
                unselectedItemColor: shadowColor,
                selectedItemColor: whiteColor,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            )));
  }
}
