import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:humancattranslate/src/songs/presentation/widgets/player_controls.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

int? indexOfSong;

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
  static const routeName = '/songsViewScreen';
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
    player = AudioPlayer()..setUrl(SoundsData.songsPath[indexOfSong!]);
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
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.network(
              SoundsData.catImagesAddress[indexOfSong!],
              height: context.height * 0.5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: context.height * 0.1,
            ),
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
            ),
            SizedBox(
              height: context.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
