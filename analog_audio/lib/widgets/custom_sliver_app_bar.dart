import 'package:analog_audio/models/enums.dart';
import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar(
      {Key? key, required this.flexibleSpaceData})
      : super(key: key);

  final Widget flexibleSpaceData;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      stretch: true,
      pinned: false,
      snap: false,
      floating: false,
      collapsedHeight: 80,
      expandedHeight: 120,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        height: double.infinity,
        child: flexibleSpaceData
      ),
    );
  }
}