import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/skeleton/providers/selected_page_provider.dart';
import 'package:humancattranslate/core/skeleton/widgets/custom_bottom_bar_icon_widget.dart';
import 'package:iconly/iconly.dart';

import 'package:provider/provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPage =
        Provider.of<SelectedPageProvider>(context).selectedPage;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24),),
        color: Colors.white,
      ),
      height: context.height * 0.09.h,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBottomBarIconWidget(
              iconData: selectedPage == 0
                  ? const Icon(
                      IconlyBold.more_square,
                      color: Colours.primaryColor,
                    )
                  : const Icon(
                      IconlyBold.more_square,
                      color: Colors.grey,
                    ),
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(0);
              },
              isSelected: selectedPage == 0,
              iconTitle: 'Sounds',
            ),
            CustomBottomBarIconWidget(
              iconData: selectedPage == 1
                  ? const Icon(
                      Icons.translate_sharp,
                      color: Colours.primaryColor,
                    )
                  : const Icon(
                      Icons.translate_sharp,
                      color: Colors.grey,
                    ),
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(1);
              },
              isSelected: selectedPage == 1,
              iconTitle: 'Translate',
            ),
            CustomBottomBarIconWidget(
              iconData: selectedPage == 2
                  ? const Icon(
                      IconlyBold.game,
                      color: Colours.primaryColor,
                    )
                  : const Icon(
                      IconlyBold.game,
                      color: Colors.grey,
                    ),
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(2);
              },
              isSelected: selectedPage == 2,
              iconTitle: 'Game',
            ),
            CustomBottomBarIconWidget(
              iconData: selectedPage == 3
                  ? const Icon(
                      Icons.music_note_rounded,
                      color: Colours.primaryColor,
                    )
                  : const Icon(
                      Icons.music_note_rounded,
                      color: Colors.grey,
                    ),
              callback: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(3);
              },
              isSelected: selectedPage == 3,
              iconTitle: 'Songs',
            ),
          ],
        ),
      ),
    );
  }
}
