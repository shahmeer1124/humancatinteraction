import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  SelectedPageProvider({required this.showbottomwidget, this.selectedPage = 0});
  int selectedPage;
  bool showbottomwidget;

  void changePage(int newValue) {
    selectedPage = newValue;
    notifyListeners();
  }

}
