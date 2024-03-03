import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';
import 'package:humancattranslate/core/res/colors.dart';
import 'package:humancattranslate/core/res/media_res.dart';
import 'package:humancattranslate/src/translate/presentation/bloc/translate_cubit.dart';
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
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TranslateCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.primaryColor,
          centerTitle: true,
          title: Text(
            'Record',
            style: appstyle(18, Colors.black, FontWeight.normal),
          ),
          automaticallyImplyLeading: true,
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
                      ));
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
              }),
              SizedBox(
                height: 100.h,
              ),
              BlocBuilder<TranslateCubit, TranslateState>(
                builder: (context, state) {
                  if (state.state == TranslateStates.listening) {
                    return GestureDetector(
                        onTap: () {
                          context.read<TranslateCubit>().stopListening();
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
                        ));
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(
                            context.width * 0.5,
                            context.height *
                                0.08), // Adjust the width and height as needed
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
                    return StopwatchWidget();
                  } else {
                    return Text(
                      'Tap mic to talk',
                      style: appstyle(18, Colors.black, FontWeight.normal),
                    );
                  }
                },
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                height: context.height * 0.3,
                width: context.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
