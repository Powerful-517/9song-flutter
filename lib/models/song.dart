class Song {
  Song(
      {required this.id,
      required this.uploaderId,
      required this.name,
      required this.artist,
      required this.album,
      required this.fileName});

  final int id;
  final int uploaderId;
  final String name;
  final String artist;
  final String album;
  final String fileName;

  factory Song.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final uploaderId = data['uploader_id'] as int;
    final name = data['name'] as String;
    final artist = data['artist'] as String;
    final album = data['album'] as String;
    final fileName = data['file_name'] as String;

    return Song(
        id: id,
        uploaderId: uploaderId,
        name: name,
        artist: artist,
        album: album,
        fileName: fileName);
  }
}

class Songs {
  Songs({required this.songs});

  final List<Song> songs;

  factory Songs.fromJson(Map<String, dynamic> data) {
    final songsData = data as List<dynamic>;
    final songs = songsData.map((songData) => Song.fromJson(songData)).toList();

    return Songs(songs: songs);
  }
}
