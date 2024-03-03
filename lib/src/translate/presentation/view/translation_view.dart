import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/core/skeleton/widgets/custom_bottom_bar_widget.dart';
import 'package:humancattranslate/src/translate/presentation/bloc/translate_cubit.dart';
import 'package:humancattranslate/src/translate/presentation/view/translate_screen_mic.dart';
import 'package:humancattranslate/src/translate/presentation/widgets/cat_to_human_widget.dart';
import 'package:iconly/iconly.dart';

class TranslateView extends StatefulWidget {
  const TranslateView({super.key});

  @override
  State<TranslateView> createState() => _TranslateViewState();
}

class _TranslateViewState extends State<TranslateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 30,
              ),
              height: 60,
              width: context.width,
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
                Navigator.of(context).pushNamed(
                  TranslateScreenMic.routeName,
                  arguments: {
                    'operation': 'cth',
                  },
                );
              },
              centerIcon: IconlyBold.arrow_right,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              height: context.height * 0.25,
              width: context.width,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
              child: const Center(
                child: Text('Banner Ad'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
