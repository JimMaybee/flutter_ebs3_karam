import 'package:flutter/cupertino.dart';
import 'package:fluttereval/ui/pages/page_inspections.dart';
import 'package:fluttereval/ui/pages/page_photos.dart';
import 'package:fluttereval/ui/pages/projects/page_projects.dart';
import 'package:fluttereval/ui/pages/page_settings.dart';
import 'package:fluttereval/ui/pages/page_templates.dart';

class HomePage extends StatelessWidget {
  //setting this to false will hide the inspections tab
  final bool inspectionsEnabled = true;

  @override
  Widget build(BuildContext context) {
    var tabs = <_HomePageTab>[
      // _HomePageTab(
      //     BottomNavigationBarItem(
      //       icon: Icon(CupertinoIcons.book_solid),
      //       title: Text('Templates'),
      //     ),
      //        () {
      //   return TemplatesPage();
      // }),
      _HomePageTab(
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bookmark_solid),
          title: Text('Projects'),
        ),
        () {
          return ProjectsPage();
        },
      ),
      if (inspectionsEnabled)
        _HomePageTab(
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye_solid),
            title: Text('Inspections'),
          ),
          () {
            return InspectionsPage();
          },
        ),
      _HomePageTab(
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.photo_camera_solid),
          title: Text('Photos'),
        ),
        () {
          return PhotosPage();
        },
      ),
      _HomePageTab(
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings_solid),
          title: Text('Settings'),
        ),
        () {
          return SettingsPage();
        },
      ),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: (index) {
          _logTabSelection(index);
        },
        items: tabs.map((e) => e.navBarItem).toList(),
      ),
      tabBuilder: (context, index) {
        return tabs[index].tabContentBuilder();
      },
    );
  }

  void _logTabSelection(int index) {
    print("selected tab index: $index");
  }
}

class _HomePageTab {
  final BottomNavigationBarItem navBarItem;
  final Widget Function() tabContentBuilder;

  _HomePageTab(this.navBarItem, this.tabContentBuilder);
}
