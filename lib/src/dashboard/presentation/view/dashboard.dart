import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/skeleton/widgets/custom_bottom_bar_widget.dart';
import 'package:humancattranslate/core/sounds_data/sounds_data.dart';
import 'package:humancattranslate/src/dashboard/presentation/widgets/dashboard_drawer.dart';
import 'package:humancattranslate/src/dashboard/presentation/widgets/reuseable_text.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  static const routeName = '/';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const DashBoardDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 24,
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Meow Interpreter',
          style: appstyle(18, Colors.white, FontWeight.bold),
        ),
        backgroundColor: Colours.primaryColor,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: const Icon(
              Icons.watch_later_rounded,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              margin: EdgeInsets.only(
                  top: 5.h, left: 10.h, right: 10.h, bottom: 5.h),
              height: context.height * 0.35.h,
              width: context.width,
              child: const Center(
                child: Text('Interstitial Ad'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.h, right: 10.h, top: 5.h),
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                  color: Colours.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12.h))),
              child: TabBar(
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: Colours.primaryColor,
                  labelStyle:
                      appstyle(24, Colours.primaryColor, FontWeight.w700),
                  unselectedLabelColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.h)),
                  ),
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: context.width * 0.5,
                        child: Center(
                          child: ReuseableText(
                              text: 'Cat',
                              style:
                                  appstyle(16, Colors.black, FontWeight.bold)),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: context.width * 0.5,
                        child: Center(
                          child: ReuseableText(
                              text: 'Dog',
                              style:
                                  appstyle(16, Colors.black, FontWeight.bold)),
                        ),
                      ),
                    )
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.h, right: 10.h),
              height: context.height * 0.48.h,
              width: context.width,
              child: TabBarView(controller: tabController, children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: context.width,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          AssetsAudioPlayer.newPlayer().open(
                            Audio(SoundsData.catAudioList[index]),
                            autoStart: true,
                            showNotification: true,
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: SoundsData.catImagesAddress[index],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(7)),
                                  child: Image(
                                    image: imageProvider,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  SoundsData.catsSoundsName[index],
                                  style: appstyle(
                                      12, Colors.black, FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 40,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: context.width,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          AssetsAudioPlayer.newPlayer().open(
                            Audio(SoundsData.dogAudioList[index]),
                            autoStart: true,
                            showNotification: true,
                          );
                        },
                        child: Center(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: SoundsData.dogImagesAddress[index],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) =>
                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(7)),
                                      child: Image(
                                        image: imageProvider,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  SoundsData.dogSoundsName[index],
                                  style: appstyle(
                                      12, Colors.black, FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 50,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
