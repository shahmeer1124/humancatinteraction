import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlsScreen extends StatelessWidget {
  const ControlsScreen({required this.player, super.key});
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return IconButton(
            onPressed: player.play,
            icon: const Icon(Icons.play_arrow_rounded),
            iconSize: 80,
            color: Colors.black,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            onPressed: player.pause,
            icon: const Icon(Icons.pause_rounded),
            iconSize: 80,
            color: Colors.black,
          );
        } else {
          return IconButton(
            onPressed: player.play,
            icon: const Icon(Icons.play_arrow_rounded),
            iconSize: 80,
            color: Colors.black,
          );
        }
      },
    );
  }
}
