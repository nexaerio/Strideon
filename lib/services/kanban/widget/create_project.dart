import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/feature/card_board/views/select_board_bg.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/models/board_model.dart';
import 'package:strideon/models/sample_project.dart';
import 'package:strideon/services/kanban/config.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/utils/snackbar/show_snackbar.dart';

import '../../../utils/constants/sizes.dart';

class CreateProject extends ConsumerStatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends ConsumerState<CreateProject> {
  final TextEditingController _createController = TextEditingController();
  final _createFormKey = GlobalKey<FormState>();
  bool loading = false;
  String? dropdownValue;
  int projectIndex = 0;

  Map<String, String>? visibilityDropdownValue;

  @override
  Widget build(BuildContext context) {
    final getWorkSpace = ref.watch(userWorkSpaceProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create board',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: false,
          actionsIconTheme: const IconThemeData(opacity: 0.85),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Form(
                      key: _createFormKey,
                      child: TextFormField(
                        controller: _createController,
                        validator: (text) {
                          if (text != null && text.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please Enter the Project's Name.";
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(18),
                          label: Text(
                            'Board name',
                            style: TextStyle(fontSize: 15),
                          ),
                          hintText: 'Board name',
                          floatingLabelStyle:
                              TextStyle(color: SColors.buttonPrimary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      ),
                      hint: const Text("Workspace"),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please select a workspace';
                      //   }
                      //   return null;
                      // },
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: SColors.spaletteAccent),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: getWorkSpace.when(
                        data: (data) {
                          return data
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                ),
                              )
                              .toList();
                        },
                        error: (error, stackTrace) => [
                          DropdownMenuItem<String>(
                            value: '',
                            // Set an appropriate default value or handle it as needed
                            child: Text(error.toString()),
                          ),
                        ],
                        loading: () => [
                          const DropdownMenuItem<String>(
                              value: '', child: Loader())
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Text(
                          "Board Background",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            final selectedBg = await GoRouter.of(context)
                                .pushNamed<String?>(
                                    RouteConstant.selectBgColor.name);

                            if (selectedBg != null) {
                              setState(() {
                                selectedBackground = selectedBg;
                              });
                            }
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration:
                                const BoxDecoration(color: SColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SSizes.spaceBtwItems,
                  ),
                  ReusableButton(
                      text: 'Create the Project',
                      onPressed: () {
                        if (_createFormKey.currentState!.validate() &&
                            selectedBackground != null) {
                          createAndSaveProject();
                        } else {
                          showSnackBar(
                              context, 'Please select Background Color');
                        }
                      }),
                  const SizedBox(
                    height: SSizes.spaceBtwItems,
                  ),
                  SizedBox(
                      height:
                          SDeviceUtils.getBottomNavigationBarHeight() * 6.5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Create a WorkSpace',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 5),
                        ),
                        TextSpan(
                          text: 'Here!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: SColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).pushNamed(
                                  RouteConstant.createWorkSpacePage.name);
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> createAndSaveProject() async {
    setState(() {
      loading = true;
    });
    String projectId =
        "${KanQ.auth.currentUser!.uid}-${DateTime.now().microsecondsSinceEpoch}";
    KanQ.fireStore.collection(KanQ.projectsCollection).doc(projectId).set({
      KanQ.projectId: projectId,
      KanQ.projectName: _createController.text.trim(),
      KanQ.projectOwner: KanQ.auth.currentUser!.uid,
      KanQ.projectMembers: [KanQ.auth.currentUser!.uid],
      KanQ.projectJoinCode: getRandomString(7),
      KanQ.projectCreatedDate: DateTime.now(),
      KanQ.projectColor: selectedBackground.toString(),
      KanQ.projectWorkSpace: dropdownValue.toString(),
    }).then((value) {
      List<Board> sampleBoards = SampleProjectBoards().createSampleBoard();
      for (int i = 0; i < sampleBoards.length; i++) {
        KanQ.fireStore
            .collection(KanQ.projectsCollection)
            .doc(projectId)
            .collection(KanQ.boardCollection)
            .doc(sampleBoards[i].boardId)
            .set(sampleBoards[i].toJson());
      }
    }).then((value) {
      late List userProjects;
      KanQ.fireStore
          .collection(KanQ.userCollection)
          .doc(KanQ.auth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data[KanQ.userProjects] == null ||
            data[KanQ.userProjects].toString() == "[]") {
          userProjects = [];
        } else {
          userProjects = data[KanQ.userProjects];
        }

        userProjects.add(projectId);
      }).then((value) {
        KanQ.fireStore
            .collection(KanQ.userCollection)
            .doc(KanQ.auth.currentUser!.uid)
            .update({KanQ.userProjects: userProjects});
      });
    }).then((value) async {
      await KanQ.getProjects().whenComplete(() async {
        await KanQ.sharedPreferences
            .setInt(KanQ.lastProjectIndex, KanQ.myProjects.length - 1);
        setState(() {
          loading = false;
        });

        GoRouter.of(context).pushReplacementNamed(
            RouteConstant.strideBoardPage.name,
            pathParameters: {
              'name': KanQ.myProjects[projectIndex].projectName,
            });
      });
    });
  }

  navigateTo(page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }
}
