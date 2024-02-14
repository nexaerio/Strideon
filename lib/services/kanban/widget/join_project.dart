import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/services/kanban/config.dart';
import 'package:strideon/utils/constants/colors.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({Key? key}) : super(key: key);

  @override
  State<JoinProject> createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {
  final TextEditingController _joinController = TextEditingController();
  final _joinFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _joinFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                  "Join to Project",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                ),
                const SizedBox(
                  height: kToolbarHeight,
                ),
                TextFormField(
                  controller: _joinController,
                  validator: (text) {
                    if (text != null && text
                        .trim()
                        .isNotEmpty) {
                      return null;
                    } else {
                      return "Please Enter the Project's Join Code.";
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text(
                        "Enter Project Code", style: TextStyle(fontSize: 15)),

                    hintText: 'Enter Project Code',
                    floatingLabelStyle:
                    TextStyle(color: SColors.buttonPrimary),
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     contentPadding: EdgeInsets.all(18),
                  //     label: Text(
                  //       'Board name',
                  //       style: TextStyle(fontSize: 15),
                  //     ),
                  //     hintText: 'Board name',
                  //     floatingLabelStyle:
                  //     TextStyle(color: SColors.buttonPrimary),
                  //   ),
                  // ),
                ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 17)),
              onPressed: () {
                if (_joinFormKey.currentState!.validate()) {
                  join();
                }
              },
              child: SizedBox(
                width: double.infinity - 10,
                height: kToolbarHeight,
                child: Center(
                  child: loading
                      ? const Loader()
                      : const Text(
                    "Join to the Project",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> join() async {
    String projectId = "";
    List projectMembers = [];
    setState(() {
      loading = true;
    });

    await KanQ.fireStore
        .collection(KanQ.projectsCollection)
        .where(KanQ.projectJoinCode, isEqualTo: _joinController.text.trim())
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        projectId = doc[KanQ.projectId];
        projectMembers = doc[KanQ.projectMembers];
      }
      print("//////////////////////////////");
      print(projectId);
    }).whenComplete(() {
      late bool alreadyJoined;
      List<String> userProjects = [];
      for (int i = 0; i < KanQ.myProjects.length; i++) {
        userProjects.add(KanQ.myProjects[i].projectId);
      }

      if (projectId != "") {
        if (userProjects.contains(projectId)) {
          alreadyJoined = true;
        } else {
          alreadyJoined = false;
          userProjects.add(projectId);
        }

        if (alreadyJoined) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Already joined to this Project")));
          setState(() {
            loading = false;
          });
        } else {
          String? userUID = KanQ.auth.currentUser?.uid;
          if (userUID != null) {
            projectMembers.add(userUID);
          }

          KanQ.fireStore
              .collection(KanQ.projectsCollection)
              .doc(projectId)
              .update({KanQ.projectMembers: projectMembers}).whenComplete(() {
            KanQ.fireStore
                .collection(KanQ.userCollection)
                .doc(KanQ.auth.currentUser!.uid)
                .update({KanQ.userProjects: userProjects}).whenComplete(
                    () async {
                  await KanQ.getProjects().whenComplete(() async {
                    int index = KanQ.myProjects.length - 1;
                    for (int i = 0; i < KanQ.myProjects.length; i++) {
                      if (projectId == KanQ.myProjects[i].projectId) {
                        index = i;
                      }
                    }
                    await KanQ.sharedPreferences
                        .setInt(KanQ.lastProjectIndex, index);
                    setState(() {
                      loading = false;
                    });
                    GoRouter.of(context)
                        .pushNamed(RouteConstant.strideBoardPage.name);
                  });
                });
          });
        }
      } else {
        setState(() {
          loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Project doesn't exist.")));
      }
    });
  }
}
