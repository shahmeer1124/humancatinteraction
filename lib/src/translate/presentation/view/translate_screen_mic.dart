import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:humancattranslate/core/utils/typedef.dart';
import 'package:humancattranslate/src/translate/presentation/bloc/translate_cubit.dart';
import 'package:humancattranslate/src/translate/presentation/view/translate_result_screen.dart';
import 'package:humancattranslate/src/translate/presentation/widgets/stop_watch.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class TranslateScreenMic extends StatefulWidget {
  const TranslateScreenMic({super.key});

  static const routeName = '/translateScreenMic';

  @override
  State<TranslateScreenMic> createState() => _TranslateScreenMicState();
}

class _TranslateScreenMicState extends State<TranslateScreenMic>
    with TickerProviderStateMixin {
  bool isNativeAdLoaded = false;
  late NativeAd nativeAd;
  late final AnimationController _controller;
  int randomVal = 0;
  final random = Random();
  String? operation;
  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-8519627525427787/1922250823',
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
  void didChangeDependencies() {
    super.didChangeDependencies();


    final arguments = ModalRoute.of(context)?.settings.arguments as DataMap?;
    if (arguments != null) {
      operation = arguments['operation'] as String;
    }
  }

  @override
  void initState() {
    loadNativeAd();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    nativeAd.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TranslateCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colours.primaryColor,
          centerTitle: true,
          title: Text(
            'Record',
            style: appstyle(18, Colors.white, FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TranslateCubit, TranslateState>(
                  builder: (context, state) {
                if (state.state == TranslateStates.listening) {
                  return SizedBox(
                      height: context.height * 0.35,
                      child: Lottie.asset(
                        MediaRes.listeningAnimation,
                        repeat: true,
                      ),);
                }
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colours.primaryColor,
                      child: Center(
                        child: Icon(
                          IconlyLight.voice_2,
                          size: 104,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },),
              SizedBox(
                height: 100.h,
              ),
              BlocBuilder<TranslateCubit, TranslateState>(
                builder: (context, state) {
                  if (state.state == TranslateStates.listening) {
                    return GestureDetector(
                        onTap: () {
                          randomVal = 0;
                          randomVal = random.nextInt(49);

                          context.read<TranslateCubit>().stopListening();
                          if (operation == 'htc' &&
                              stopwatch.elapsed.inSeconds >= 3) {
                            Navigator.of(context)
                                .pushNamed(TranslateResultScreen.routeName);
                          } else if (operation == 'cth' &&
                              stopwatch.elapsed.inSeconds >= 3) {
                            showModalBottomSheet(
                                context: context,
                                builder: (contexts) {
                                  return Container(
                                    width: context.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(19),
                                        topRight: Radius.circular(19),
                                      ),
                                    ),
                                    height: 500.h,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 70.h),
                                          height: 150,
                                          width: 150,
                                          child: CachedNetworkImage(
                                            imageUrl: SoundsData
                                                .catImagesAddress[randomVal],
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress,) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(3),),
                                              child: Image(
                                                image: imageProvider,
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: context.width,
                                          child: Center(
                                            child: Text(
                                              SoundsData.petMessages[randomVal],
                                              style: appstyle(19, Colors.black,
                                                  FontWeight.normal,),
                                            ),
                                          ),
                                        )
                                      ,],
                                    ),
                                  );
                                },);
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (contexts) {
                                  return Container(
                                    width: context.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(19),
                                        topRight: Radius.circular(19),
                                      ),
                                    ),
                                    height: 500.h,
                                    child: Center(
                                      child: Text(
                                        'Message is not recorded properly',
                                        style: appstyle(
                                            20, Colors.red, FontWeight.bold,),
                                      ),
                                    ),
                                  );
                                },);
                          }
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colours.chatFieldColorDarker,
                          child: Center(
                            child: Text(
                              'Stop',
                              style:
                                  appstyle(18, Colors.black, FontWeight.bold),
                            ),
                          ),
                        ),);
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(
                            context.width * 0.5,
                            context.height *
                                0.08,), // Adjust the width and height as needed
                      ),
                    ),
                    onPressed: () {
                      context.read<TranslateCubit>().startListening();
                    },
                    child: const Icon(IconlyBold.voice),
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocBuilder<TranslateCubit, TranslateState>(
                builder: (context, state) {
                  if (state.state == TranslateStates.listening) {
                    return const StopwatchWidget();
                  } else {
                    return Text(
                      'Tap mic to talk',
                      style: appstyle(18, Colors.black, FontWeight.normal),
                    );
                  }
                },
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
