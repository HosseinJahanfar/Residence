import 'package:flutter/material.dart';

import '../../../const/responsive.dart';
import '../../public_features/widget/search_bar_widget.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: false,
      scrolledUnderElevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: Responsive.isTablet(context) ? 80 : 70,
      pinned: true,
      elevation: 0,
      flexibleSpace: const SearchBarWidget(),
    );
  }
}
