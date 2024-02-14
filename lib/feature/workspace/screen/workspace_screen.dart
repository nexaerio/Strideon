import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/models/project.dart';
import 'package:strideon/models/workspace_model.dart';
import 'package:strideon/services/kanban/config.dart';

class WorkSpaceScreen extends ConsumerWidget {
  final String name;

  const WorkSpaceScreen({super.key, required this.name});

  void joinWorkSpace(WidgetRef ref, WorkSpace workSpace) {
    ref.read(workSpaceControllerProvider.notifier).joinWorkSpace(workSpace);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: ref.watch(getWorkSpaceNameProvider(name)).when(
            data: (workspace) => NestedScrollView(
                headerSliverBuilder: (context, innerIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      snap: true,
                      floating: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(workspace.banner,
                                fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(workspace.avatar),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(workspace.name),
                            workspace.mods.contains(user.uid)
                                ? OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                    onPressed: () {
                                      GoRouter.of(context).pushNamed(
                                          RouteConstant.modsToolsPage.name,
                                          pathParameters: {
                                            'name': workspace.name
                                          });
                                    },
                                    child: const Text('Mod tools'))
                                : OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                    onPressed: () =>
                                        joinWorkSpace(ref, workspace),
                                    child: Text(
                                        workspace.members.contains(user.uid)
                                            ? 'Joined'
                                            : 'Join')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('${workspace.members.length} members'),
                        ),
                      ])),
                    )
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        '${workspace.name} Projects',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      StreamBuilder(
                        stream: KanQ.getUserPWorkSpace(workspace.name),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loader();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            KanQ.myProjects = snapshot.data!;
                            return Expanded(
                              child: ListView.builder(
                                itemCount: KanQ.myProjects.length,
                                itemBuilder: (context, index) {
                                  Project project = KanQ.myProjects[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(project.projectName),
                                      leading: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Color(
                                              int.parse(project.projectColor)),
                                        ),
                                      ),
                                      onTap: () async {
                                        // GoRouter.of(context).pushNamed(
                                        //     RouteConstant.strideBoardPage.name,
                                        //     pathParameters: {
                                        //       'name': KanQ
                                        //           .myProjects[index].projectName
                                        //     });

                                        await KanQ.sharedPreferences
                                            .setInt(
                                                KanQ.lastProjectIndex, index)
                                            .whenComplete(() {
                                          GoRouter.of(context).pushNamed(
                                              RouteConstant
                                                  .strideBoardPage.name,
                                              pathParameters: {
                                                'name': KanQ.myProjects[index]
                                                    .projectName
                                              });
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                )),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
