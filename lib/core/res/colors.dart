import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Colours {
  static const gradient = [
    Color(0xFFEDF8FF),
    Color(0xFFFDC1E8),
    Color(0xFFFFFFFF),
    Color(0xFFFDFAE1),
  ];

  static const Color primaryColor = Color(0xFF458CFF);

  static const Color neutralTextColor = Color(0xFF757C8E);

  static const Color physicsTileColor = Color(0xFFD3D5FE);

  static const Color scienceTileColor = Color(0xFFFFEFDA);

  static const Color chemistryTileColor = Color(0xFFFFE4F1);

  static const Color biologyTileColor = Color(0xFFCFE5FC);

  static const Color mathTileColor = Color(0xFFFFCECA);

  static const Color languageTileColor = Color(0xFFDAFF06);

  static const Color literatureTileColor = Color(0xFFD58EF8);

  static const Color redColor = Color(0xFFFF5C5E);

  static const Color greenColor = Color(0xFF286A6C);

  static const Color chatFieldColorDarker = Color(0xFFE8E9EA);

  static const Color currentUserChatBubbleColor = Color(0xFF2196F3);

  static const Color otherUserChatBubbleColor = Color(0xFFEEEEEE);

  static const Color currentUserChatBubbleColorDarker = Color(0xFF197602);

  static const Color otherUserChatBubbleColorDarter = Color(0xFFE0E0E0);
}

TextStyle appstyle(
  double size,
  Color color,
  FontWeight fw,
) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}
