import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Container(
              margin: const EdgeInsets.all(20),
              height: context.height * 0.2,
              width: context.width,
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
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
