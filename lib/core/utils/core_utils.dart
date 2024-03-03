import 'package:flutter/material.dart';
import 'package:humancattranslate/core/res/colors.dart';

class CoreUtils {
  const CoreUtils._();
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.literatureTileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(
            10,
          ),
        ),
      );
  }
}
