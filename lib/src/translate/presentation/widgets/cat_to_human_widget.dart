import 'package:flutter/material.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';

class CatToHumanTranslate extends StatelessWidget {
  const CatToHumanTranslate({
    required this.leftIconPath,
    required this.rightIconPath,
    required this.callback,
    required this.centerIcon,
    super.key,
  });
  final String leftIconPath;
  final String rightIconPath;
  final VoidCallback callback;
  final IconData centerIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: context.height * 0.11,
        width: context.width,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                leftIconPath,
                height: 40,
              ),
              Icon(centerIcon),
              Image.asset(
                rightIconPath,
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
