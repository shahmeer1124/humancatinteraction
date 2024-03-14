import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';

class TranslateResultScreen extends StatefulWidget {
  const TranslateResultScreen({super.key});
  static const routeName = '/translateResult';

  @override
  State<TranslateResultScreen> createState() => _TranslateResultScreenState();
}

class _TranslateResultScreenState extends State<TranslateResultScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isNativeAdLoaded = false;
  late NativeAd nativeAd;
  int index = 0;
  int? randomVal;
  bool playerState = false;
  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-8519627525427787/6045436468',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isNativeAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            isNativeAdLoaded = false;
          });
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
    );
    nativeAd.load();
  }

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
      showNotification: true,
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
    loadNativeAd();

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isNativeAdLoaded)
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                margin: EdgeInsets.only(
                  top: 5.h,
                  left: 10.h,
                  right: 10.h,
                  bottom: 5.h,
                ),
                height: context.height * 0.25.h,
                width: context.width,
                child: const Center(),
              )
            else
              SizedBox(
                width: context.width,
                height: context.height * 0.45,
                child: AdWidget(ad: nativeAd),
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
                        width: 3,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(39),
                      ),
                    ),
                    height: 70,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
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
                        width: 3,
                      ),
                      color: Colours.chatFieldColorDarker,
                      borderRadius: const BorderRadius.all(Radius.circular(39)),
                    ),
                    height: 70,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
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
                    borderRadius: BorderRadius.all(Radius.circular(39)),),
                child: Center(
                  child: Text(
                    playerState ? 'Pause' : 'Play',
                    style: appstyle(14, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
