import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryRed = Color(0xFF9F224E);
  static const Color bgWhite = Colors.white;
  static const Color bgNavBar = Color.fromARGB(255, 239, 209, 209);
  static const Color textDark = Color(0xFF222222);
  static const Color textGrey = Colors.grey;
  static const Color borderGrey = Color(0xFFE5E5E5);
  static const Color textLightGrey = Colors.blueGrey;

  static const TextStyle sloganText = TextStyle(
    fontSize: 12,
    color: textLightGrey,
  );
  static const TextStyle topLinkText = TextStyle(color: textGrey, fontSize: 14);
  static const TextStyle navItemText = TextStyle(
    color: Color(0xFF4F4F4F),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle eIconText = TextStyle(
    color: primaryRed,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle articleTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: textDark,
    height: 1.3,
  );
  static const TextStyle articleDescription = TextStyle(
    fontSize: 14,
    color: Color(0xFF4F4F4F),
    height: 1.4,
  );
  static const TextStyle articleMeta = TextStyle(fontSize: 12, color: textGrey);

  static const TextStyle detailTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
    height: 1.3,
  );
  static const TextStyle detailTime = TextStyle(fontSize: 13, color: textGrey);
  static const TextStyle detailDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
    height: 1.5,
  );
  static const TextStyle detailContent = TextStyle(
    fontSize: 17,
    color: Color(0xFF333333),
    height: 1.6,
  );

  static final BoxDecoration headerBox = BoxDecoration(
    color: bgWhite,
    border: const Border(bottom: BorderSide(color: borderGrey, width: 1.0)),
  );

  static final BoxDecoration navBarBox = BoxDecoration(
    color: bgNavBar,
    border: const Border(bottom: BorderSide(color: borderGrey, width: 1.0)),
  );

  static final BoxDecoration redBorderIcon = BoxDecoration(
    border: Border.all(color: primaryRed, width: 2),
    borderRadius: BorderRadius.circular(4),
  );

  static const BoxDecoration circleGreyBg = BoxDecoration(
    color: textGrey,
    shape: BoxShape.circle,
  );


  static final BoxDecoration searchBox = BoxDecoration(
    color: const Color(0xFFF0F0F0),
    borderRadius: BorderRadius.circular(24),
  );
}
