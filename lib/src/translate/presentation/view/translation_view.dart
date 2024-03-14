import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/skeleton/widgets/custom_bottom_bar_widget.dart';
import 'package:humancattranslate/src/translate/presentation/view/translate_screen_mic.dart';
import 'package:humancattranslate/src/translate/presentation/widgets/cat_to_human_widget.dart';
import 'package:iconly/iconly.dart';

class TranslateView extends StatefulWidget {
  const TranslateView({super.key});

  @override
  State<TranslateView> createState() => _TranslateViewState();
}

class _TranslateViewState extends State<TranslateView> {
  late InterstitialAd _interstitialAd;
  bool isInterstitialAdLoaded = false;
  late NativeAd nativeAd;
  bool isNativeAdLoaded = false;
  late BannerAd _bannerAd;
  bool _isLoaded = false;
  @override
  void initState() {
    loadAd();
    loadInterAd();
    loadNativeAd();
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    nativeAd.dispose();
    super.dispose();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-8519627525427787/8970982707',
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        setState(() {
          isNativeAdLoaded = false;
        });
      },),
      request: const AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
    );
    nativeAd.load();
  }

  void loadInterAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-8519627525427787/8787042073',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');

            _interstitialAd = ad;
            setState(() {
              isInterstitialAdLoaded = true;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd.dispose();
            setState(() {
              isInterstitialAdLoaded = false;
            });
          },
        ),);
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-8519627525427787/9657857341',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meow Interpreter',
          style: appstyle(18, Colors.white, FontWeight.bold),
        ),
        backgroundColor: Colours.primaryColor,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Select Translation',
              style: appstyle(18, Colors.black, FontWeight.normal),
            ),
            Text(
              'This activity may include advertisements.',
              style: appstyle(12, Colors.grey, FontWeight.w300),
            ),
            const SizedBox(
              height: 40,
            ),
            CatToHumanTranslate(
              leftIconPath: MediaRes.human,
              rightIconPath: MediaRes.cat,
              callback: () {
                if (isInterstitialAdLoaded) {
                  _interstitialAd.show();
                }

                Navigator.of(context).pushNamed(
                  TranslateScreenMic.routeName,
                  arguments: {
                    'operation': 'htc',
                  },
                );
              },
              centerIcon: IconlyBold.arrow_right,
            ),
            const SizedBox(
              height: 20,
            ),
            CatToHumanTranslate(
              leftIconPath: MediaRes.cat,
              rightIconPath: MediaRes.human,
              callback: () {
                if (isInterstitialAdLoaded) {
                  _interstitialAd.show();
                }
                Navigator.of(context).pushNamed(
                  TranslateScreenMic.routeName,
                  arguments: {
                    'operation': 'cth',
                  },
                );
              },
              centerIcon: IconlyBold.arrow_right,
            ),
            if (!isNativeAdLoaded)
              Container(
                height: context.height * 0.25,
                width: context.width,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
                child: const Center(),
              )
            else
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: context.width,
                height: context.height,
                child: AdWidget(ad: nativeAd),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
