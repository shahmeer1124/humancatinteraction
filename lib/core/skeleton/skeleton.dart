import 'package:flutter/material.dart';
import 'package:humancattranslate/core/skeleton/providers/selected_page_provider.dart';
import 'package:humancattranslate/src/dashboard/presentation/view/dashboard.dart';
import 'package:humancattranslate/src/translate/presentation/view/translation_view.dart';
import 'package:provider/provider.dart';
import 'package:humancattranslate/src/songs/presentation/view/all_songs_list.dart';

List<Widget> pages = [
  const DashBoardScreen(),
  const TranslateView(),
  const DashBoardScreen(),
  const AllSongsListView(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPage =
        Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      body: pages[selectedPage],
    );
  }
}
