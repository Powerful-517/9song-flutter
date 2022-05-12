import 'package:json_annotation/json_annotation.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  SongModel(
      {required this.id,
      required this.uploaderId,
      required this.name,
      required this.artist,
      required this.album,
      required this.fileName});

  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "uploader_id")
  final int uploaderId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "artist")
  final String artist;
  @JsonKey(name: "album")
  final String album;
  @JsonKey(name: "file_name")
  final String fileName;

  factory SongModel.fromJson(Map<String, dynamic> data)  => _$SongModelFromJson(data);

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
