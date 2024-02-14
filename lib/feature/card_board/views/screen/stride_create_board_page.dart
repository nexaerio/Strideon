import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/models/project.dart';
import 'package:strideon/services/kanban/config.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';

class StrideBoardScreen extends ConsumerStatefulWidget {
  const StrideBoardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StrideBoardScreen> createState() => _StrideBoardScreenState();
}

class _StrideBoardScreenState extends ConsumerState<StrideBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your boards',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       GoRouter.of(context)
        //           .pushNamed(RouteConstant.strideBoardMenu.name);
        //     },
        //     icon: const Icon(
        //       Icons.view_kanban_rounded,
        //       color: SColors.buttonPrimary,
        //     ),
        //   ),
        // ],
        centerTitle: false,
        actionsIconTheme: const IconThemeData(opacity: 0.85),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18),
                label: Text(
                  'Board name',
                  style: TextStyle(fontSize: 15),
                ),
                hintText: 'Board name',
                floatingLabelStyle: TextStyle(color: SColors.buttonPrimary),
              ),
            ),
          ),
          const SizedBox(
            height: SSizes.spaceBtwItems,
          ),
          const ProjectName(),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        fanAngle: 10,
        overlayStyle: ExpandableFabOverlayStyle(
          blur: 5,
        ),
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.create),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: SColors.spaletteAccent,
          backgroundColor: const Color(0xFF5E31E6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.small,
          foregroundColor: SColors.spaletteAccent,
          backgroundColor: const Color(0xFF5E31E6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.view_kanban_outlined),
            onPressed: () {
              GoRouter.of(context)
                  .pushNamed(RouteConstant.createProjectView.name);
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.workspaces_outline),
            onPressed: () {
              GoRouter.of(context)
                  .pushNamed(RouteConstant.joinProjectView.name);
            },
          ),
        ],
      ),
    );
  }
}

class ProjectName extends StatefulWidget {
  const ProjectName({super.key});

  @override
  State<ProjectName> createState() => _ProjectNameState();
}

class _ProjectNameState extends State<ProjectName> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: KanQ.getUserProject(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                return ListTile(
                  title: Text(project.projectName),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      color: Color(int.parse(project.projectColor)),
                    ),
                  ),
                  onTap: () async {
                    await KanQ.sharedPreferences
                        .setInt(KanQ.lastProjectIndex, index)
                        .whenComplete(() {
                      GoRouter.of(context).pushNamed(
                          RouteConstant.strideBoardPage.name,
                          pathParameters: {
                            'name': KanQ.myProjects[index].projectName
                          });
                    });
                  },
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          final projectId = KanQ.myProjects[index].projectId;

                          return SizedBox(
                            height:
                                SDeviceUtils.getBottomNavigationBarHeight() * 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(project.projectName),
                                      subtitle: Text(project.projectId),
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Color(
                                              int.parse(project.projectColor)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              KanQ.deleteProject(
                                                  projectId, context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18),
                                                backgroundColor: SColors.error),
                                            child:
                                                const Text("Delete Project")),
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        });
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
