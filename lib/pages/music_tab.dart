import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nine_song/api/backend_service.dart';

class MusicTab extends StatefulWidget {
  const MusicTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicTabState();
}

class MusicTabState extends State<MusicTab> {
  static late AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            return _playerButton(playerState!);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Widget _playerButton(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: const CircularProgressIndicator(),
      );
    } else if (audioPlayer.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: audioPlayer.play,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: audioPlayer.pause,
      );
    }
  }

  static Future<void> play(String songFileName, Duration? start) async {
    audioPlayer.setUrl(await BackendService.getSongUrl(songFileName));
    if (start != null) audioPlayer.seek(start);
    audioPlayer.play();
  }
}
