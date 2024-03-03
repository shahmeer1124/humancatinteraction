import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:iconly/iconly.dart';

class TranslateResultScreen extends StatefulWidget {
  const TranslateResultScreen({super.key});
  static const routeName = '/translateResult';

  @override
  State<TranslateResultScreen> createState() => _TranslateResultScreenState();
}

class _TranslateResultScreenState extends State<TranslateResultScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int index = 0;
  int? randomVal;
  bool playerState = false;
  void playAudio(int index) {
    String selectedAudio;

    if (index == 0) {
      if (randomVal == null) {
        final random = Random();
        randomVal = random.nextInt(49);
      }

      selectedAudio = SoundsData.catAudioList[randomVal!];
    } else if (index == 1) {

      selectedAudio = SoundsData.dogAudioList[index];
    } else {
      return;
    }
    assetsAudioPlayer.open(
      Audio(
        selectedAudio,
      ),
      autoStart: true,
      showNotification: true,
      playInBackground: PlayInBackground.enabled,
    );
    setState(() {
      playerState = true;
    });
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    assetsAudioPlayer.playlistFinished.listen((finished) {
      if (finished) {
        setState(() {
          playerState = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colours.primaryColor,
        title: Text(
          'Translate',
          style: appstyle(18, Colors.white, FontWeight.normal),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(
              IconlyLight.home,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.h),
              height: context.height * 0.25,
              width: context.width,
              decoration: BoxDecoration(border: Border.all()),
            ),
            Text(
              'Select a Translation',
              style: appstyle(19, Colors.black, FontWeight.normal),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colours.chatFieldColorDarker,
                        border: Border.all(
                            color: index == 0
                                ? Colours.primaryColor
                                : Colors.transparent,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    height: 70,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Image.asset(MediaRes.cat, fit: BoxFit.cover),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: index == 1
                                ? Colours.primaryColor
                                : Colors.transparent,
                            width: 3),
                        color: Colours.chatFieldColorDarker,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(39))),
                    height: 70,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(MediaRes.dog, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.2,
            ),
            GestureDetector(
              onTap: () {
                if (playerState == true) {
                  assetsAudioPlayer.pause();
                  setState(() {
                    playerState = false;
                  });
                } else {
                  playAudio(index);
                }
              },
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    color: Colours.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(39))),
                child: Center(
                  child: Text(
                    playerState ? 'Pause' : 'Play',
                    style: appstyle(14, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
