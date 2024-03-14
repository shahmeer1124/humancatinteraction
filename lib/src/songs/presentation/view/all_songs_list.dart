import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/skeleton/widgets/custom_bottom_bar_widget.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:humancattranslate/src/songs/presentation/view/songs_view.dart';

class AllSongsListView extends StatefulWidget {
  const AllSongsListView({super.key});
  static const routeName = '/allSongsPlayList';

  @override
  State<AllSongsListView> createState() => _AllSongsListViewState();
}

class _AllSongsListViewState extends State<AllSongsListView> {
  bool isNativeAdLoaded = false;
  late NativeAd nativeAd;
  late InterstitialAd _interstitialAd;
  bool isInterstitialAdLoaded = false;
  void loadInterAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-8519627525427787/5913466725',
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

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-8519627525427787/3842779104',
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

  @override
  void initState() {
    loadNativeAd();
    loadInterAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colours.primaryColor,
        title: Text(
          'Songs',
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
                    top: 5.h, left: 10.h, right: 10.h, bottom: 5.h,),
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
            SizedBox(
              height: context.height * 0.6,
              width: context.width,
              child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 45.h),
                  itemCount: SoundsData.songsPath.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (isInterstitialAdLoaded) {
                          _interstitialAd.show();
                        }
                        Navigator.of(context).pushNamed(SongsView.routeName);
                        indexOfSong = index;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        height: context.height * 0.1,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                child: Image.asset(MediaRes.kitty),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              SoundsData.songsName[index],
                              style:
                                  appstyle(18, Colors.black, FontWeight.normal),
                            )
                          ,],
                        ),
                      ),
                    );
                  },),
            )
          ,],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
