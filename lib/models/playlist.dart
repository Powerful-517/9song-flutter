class Playlist {
  Playlist(
      {required this.id,
      required this.ownerId,
      required this.name,
      this.curSongId,
      this.curUpdateTime});

  final int id;
  final int ownerId;
  final String name;
  final int? curSongId;
  final DateTime? curUpdateTime;

  factory Playlist.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final ownerId = data['owner_id'] as int;
    final name = data['name'] as String;
    final curSongId = data['cur_song_id'] as int?;
    final curUpdateTimeStr = data['cur_update_time'] as String?;
    final curUpdateTime =
        curUpdateTimeStr != null ? DateTime.parse(curUpdateTimeStr) : null;

    return Playlist(
        id: id,
        ownerId: ownerId,
        name: name,
        curSongId: curSongId,
        curUpdateTime: curUpdateTime);
  }
}

class Playlists {
  Playlists({required this.playlists});

  final List<Playlist> playlists;

  factory Playlists.fromJson(Map<String, dynamic> data) {
    final playlistsData = data as List<dynamic>;
    final playlists =
        playlistsData.map((songData) => Playlist.fromJson(songData)).toList();

    return Playlists(playlists: playlists);
  }
}
