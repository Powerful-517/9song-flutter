import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nine_song/models/playlist_model.dart';

class PlaylistRowItem extends StatelessWidget {
  const PlaylistRowItem(
      {required this.playlist, required this.lastItem, Key? key})
      : super(key: key);

  final Playlist playlist;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = GestureDetector(
      onTap: () {
        // TODO
        print(playlist.name + " Tapped!");
      },
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 32,
          top: 8,
          bottom: 8,
          right: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              playlist.name,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Text(
              playlist.curSongName,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
    if (lastItem) return row;
    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100),
          child: Container(
            height: 1,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
