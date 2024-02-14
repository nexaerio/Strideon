/*
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/models/project.dart';
import 'package:strideon/services/kanban/config.dart';

class WorkSpaceProject extends StatefulWidget {
  const WorkSpaceProject({super.key});

  @override
  State<WorkSpaceProject> createState() => _WorkSpaceProjectState();
}

class _WorkSpaceProjectState extends State<WorkSpaceProject> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: KanQ.getUserPWorkSpace(),
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
                    width: 100,
                    height: 100,
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
                );
              },
            ),
          );
        }
      },
    );
  }
}
*/
