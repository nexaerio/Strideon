import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/firebase/get_name.dart';
import 'package:strideon/core/firebase/get_photo.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/gobal/delegate/search_delegated.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed(RouteConstant.settingScreen.name);
            },
            child: const GetProfile(),
          ),
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              " Hello I'm ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          subtitle: const GetName(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(RouteConstant.notificationPage.name);
                    },
                    icon: const Icon(CupertinoIcons.bell)),
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: SearchWorkSpace(ref));
                    },
                    icon: const Icon(CupertinoIcons.search)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
