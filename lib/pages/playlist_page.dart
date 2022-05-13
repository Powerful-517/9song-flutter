import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nine_song/models/playlist_model.dart';
import 'package:nine_song/pages/widgets/song_row_item.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key, required this.playlist}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          semanticChildCount: playlist.songs.length,
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(playlist.name),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < playlist.songs.length) {
                    return SongRowItem(
                        song: playlist.songs[index],
                        lastItem: index == playlist.songs.length - 1);
                  }
                  return null;
                }),
              ),
            ),
          ]),
    );
  }
}
