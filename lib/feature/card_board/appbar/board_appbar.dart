import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/router.dart';

class BoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoardAppBar({super.key, required this.boardName});

  final String boardName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(RouteConstant.boardMenu.name);
          },
          icon: const Icon(Icons.menu),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt_sharp),
        ),
      ],
      centerTitle: false,
      title: GestureDetector(
        child: Text(boardName),
        onTap: () {},
      ),
      titleSpacing: 10,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
