import 'package:json_annotation/json_annotation.dart';

part 'playlist_model.g.dart';

@JsonSerializable()
class PlaylistModel {
  PlaylistModel(
      {required this.id,
      required this.ownerId,
      required this.name,
      this.curSongId,
      this.curUpdateTime});

  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "owner_id")
  final int ownerId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "cur_song_id")
  final int? curSongId;
  @JsonKey(name: "cur_update_time")
  final DateTime? curUpdateTime;

  factory PlaylistModel.fromJson(Map<String, dynamic> data) =>
      _$PlaylistModelFromJson(data);

  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);
}

class Playlist extends PlaylistModel {
  Playlist(
      {required this.ownerName,
      required this.curSongName,
      required int id,
      required int ownerId,
      required String name})
      : super(id: id, ownerId: ownerId, name: name);

  final String ownerName;
  final String curSongName;
}
