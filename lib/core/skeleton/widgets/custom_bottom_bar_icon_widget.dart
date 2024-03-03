import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/res/colors.dart';

class CustomBottomBarIconWidget extends StatelessWidget {
  const CustomBottomBarIconWidget({
    required this.callback,
    required this.isSelected,
    required this.iconTitle,
    required this.iconData,
    super.key,
  });

  final VoidCallback callback;
  final bool isSelected;
  final Icon iconData;

  final String iconTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: 70.h,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD9EBFD) : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(21)),
              ),
              height: 32.h,
              width: 76.w,
              child: Center(
                child: iconData,
              ),
            ),
            Text(
              iconTitle,
              style: appstyle(
                12.sp,
                isSelected ? Colours.primaryColor : Colors.grey,
                FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
