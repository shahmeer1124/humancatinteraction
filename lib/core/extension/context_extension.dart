import 'package:flutter/material.dart';
import 'package:humancattranslate/core/common/app/providers/tab_navigator.dart';

import 'package:provider/provider.dart';


extension contextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaquery => MediaQuery.of(this);
  Size get size => mediaquery.size;
  double get width => size.width;
  double get height => size.height;
 double get pixelRatio => mediaquery.devicePixelRatio;

  TabNavigator get tabNavigator => read<TabNavigator>();
  void pop() => tabNavigator.pop();
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
