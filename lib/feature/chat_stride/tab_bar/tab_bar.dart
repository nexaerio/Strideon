import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strideon/feature/chat_stride/views/stride_text.dart';
import 'package:strideon/feature/chat_stride/views/stride_text_image.dart';
import 'package:strideon/utils/constants/colors.dart';

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        bottom: TabBar(
          indicatorColor: SColors.buttonPrimary,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.image,
                color: SColors.primary,
              ),
            ),
            Tab(
              icon: Icon(
                CupertinoIcons.pen,
                color: SColors.primary,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          StrideImageChat(),
          StrideText(),
        ],
      ),
    );
  }
}
