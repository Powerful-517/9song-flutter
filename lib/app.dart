import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:nine_song/utils/init.dart';
import 'package:nine_song/utils/local_storage.dart';
import 'package:nine_song/pages/login_page.dart';
import 'package:nine_song/pages/music_tab.dart';
import 'package:nine_song/pages/playlist_tab.dart';
import 'package:nine_song/pages/setting_tab.dart';

class NineSongApp extends StatefulWidget {
  const NineSongApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NineSongHomePageState();
  }
}

class NineSongHomePageState extends State<NineSongApp> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: NineSongHomePage(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    }
    Init.initAll().then((value) {
      if (LocalStorage.getToken() == null) {
        Get.off(const LoginPage());
      }
    });
  }
}

class NineSongHomePage extends StatelessWidget {
  const NineSongHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_note), label: "歌曲"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_note_list), label: "列表"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: "设置"),
          ],
        ),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: MusicTab());
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: PlaylistTab());
              });
              break;
            case 2:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(child: SettingTab());
              });
              break;
          }
          return returnValue;
        });
  }
}
