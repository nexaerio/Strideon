import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';

class ModsToolsPage extends ConsumerWidget {
  final String name;

  const ModsToolsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workSpace = ref.watch(userWorkSpaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod Tools'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text('Add Moderators'),
            onTap: () {
              GoRouter.of(context)
                  .pushNamed(RouteConstant.addModsPage.name, pathParameters: {
                'name': name,
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Community'),
            onTap: () {
              GoRouter.of(context).pushNamed(
                  RouteConstant.editWorkSpacePage.name,
                  pathParameters: {
                    'name': name,
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.ios_share_rounded),
            title: const Text('Invite'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
