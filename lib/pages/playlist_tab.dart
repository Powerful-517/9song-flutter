import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nine_song/models/song_model.dart';
import 'package:nine_song/pages/widgets/playlist_row_item.dart';

import 'package:nine_song/api/backend_service.dart';
import '../models/playlist_model.dart';

class PlaylistTab extends StatefulWidget {
  const PlaylistTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlaylistTabState();
}

class _PlaylistTabState extends State<PlaylistTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAllPlaylist(),
      builder: (BuildContext context, AsyncSnapshot<List<Playlist>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.cloud_download,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text("载入中"),
                )
              ],
            ),
          );
        } else {
          var playlists = snapshot.data ?? [];
          return CustomScrollView(
            semanticChildCount: playlists.length,
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text("播放列表"),
              ),
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < playlists.length) {
                      return PlaylistRowItem(
                          playlist: playlists[index],
                          lastItem: index == playlists.length - 1);
                    }
                    return null;
                  }),
                ),
              )
            ],
          );
        }
      },
    );
  }
}

Future<List<Playlist>> _getAllPlaylist() async {
  var playlistModels = await BackendService.getAllPlaylists();
  var playlists = <Playlist>[];
  for (final p in playlistModels) {
    var owner = await BackendService.getUserById(p.ownerId);
    late SongModel? curSong;
    if (p.curSongId != null) {
      curSong = await BackendService.getSongById(p.curSongId!);
    } else {
      curSong = null;
    }
    List<SongModel> songs = await BackendService.getSongsByPlaylistId(p.id);
    if (owner != null && curSong != null) {
      var playlist = Playlist(
          ownerName: owner.nickName,
          curSongName: curSong.name,
          id: p.id,
          ownerId: p.ownerId,
          name: p.name,
          songs: songs);
      playlists.add(playlist);
    }
  }
  return playlists;
}
