import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/player_controls.dart';

class PositionData {
  PositionData(
      {required this.position,
      required this.bufferPosition,
      required this.duration});
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;
}

class SongsView extends StatefulWidget {
  const SongsView({super.key});

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView> {
  late AudioPlayer player;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position: position,
          bufferPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );
  @override
  void initState() {
    player = AudioPlayer()
      ..setUrl(
          'https://firebasestorage.googleapis.com/v0/b/fbaw-486da.appspot.com/o/When%20Irish%20Eyes%20Are%20Smiling%20-%20Freedom%20Trail%20Studio.mp3?alt=media&token=2cc38e39-1dcb-4bf0-95ce-e49543ec8350');

    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<PositionData>(
              stream: positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  barHeight: 8,
                  baseBarColor: Colors.grey[600],
                  bufferedBarColor: Colors.grey,
                  progressBarColor: Colors.red,
                  thumbColor: Colors.red,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ), // TextStyle
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: player.seek,
                ); // ProgressBar
              },
            ), // StreamBuilder
            ControlsScreen(
              player: player,
            )
          ],
        ),
      ),
    );
  }
}
