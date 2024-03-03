import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humancattranslate/core/extension/context_extension.dart';


class DashBoardDrawer extends StatefulWidget {
  const DashBoardDrawer({
    super.key,
  });

  @override
  State<DashBoardDrawer> createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: context.width - 60.w,
      child: ListView(
        
      ),
    );
  }
}
