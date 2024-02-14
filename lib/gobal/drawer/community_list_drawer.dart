import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/utils/constants/colors.dart';

class CommunityListDrawer extends ConsumerStatefulWidget {
  const CommunityListDrawer({super.key});

  @override
  ConsumerState<CommunityListDrawer> createState() =>
      _CommunityListDrawerState();
}

class _CommunityListDrawerState extends ConsumerState<CommunityListDrawer> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? SColors.darkBackground
          : SColors.primaryBackground,
      child: SafeArea(
          child: Column(
        children: [
          ListTile(
              title: Text('Create a Workspace',
                  style: Theme.of(context).textTheme.titleSmall),
              leading: const Icon(Icons.add),
              onTap: () {
                context.pushNamed(RouteConstant.createWorkSpacePage.name);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Expanded(child: Text('Your WorkSpace')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        active = !active;
                      });
                    },
                    icon: Icon(active
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up)),
              ],
            ),
          ),
          ref.watch(userWorkSpaceProvider).when(
                data: (mywork) => Expanded(
                  child: (active)
                      ? ListView.builder(
                          itemCount: mywork.length,
                          itemBuilder: (BuildContext context, int index) {
                            final workSpace = mywork[index];
                            return ListTile(
                              title: Text(workSpace.name),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(workSpace.avatar),
                              ),
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                    RouteConstant.workSpaceScreen.name,
                                    pathParameters: {'name': workSpace.name});
                              },
                            );
                          },
                        )
                      : Container(),
                ),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
        ],
      )),
    );
  }
}
