import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/card_board/views/select_board_bg.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/services/stride_board/controller/stride_controller.dart';
import 'package:strideon/utils/constants/board_card.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

class CreateBoardPage extends ConsumerStatefulWidget {
  const CreateBoardPage({super.key});

  @override
  ConsumerState<CreateBoardPage> createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends ConsumerState<CreateBoardPage> {
  String? dropdownValue;

  Map<String, String>? visibilityDropdownValue;
  final TextEditingController strideCreateBoard = TextEditingController();

  void createStrideBoard() {
    ref.watch(createBoardProvider.notifier).createBoard(
          strideCreateBoard.text,
          context,
          selectedBackground.toString(),
          dropdownValue.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final getWorkSpace = ref.watch(userWorkSpaceProvider);
    final isLoading = ref.watch(createBoardProvider);
    final boardName = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: const Text("Create board"),
        centerTitle: false,
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Form(
                    key: boardName,
                    child: TextFormField(
                      controller: strideCreateBoard,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Board name",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 15)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      ),
                      hint: const Text("Workspace"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a workspace';
                        }
                        return null;
                      },
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButton<Map<String, String>>(
                      hint: const Text("Visibility"),
                      isExpanded: true,
                      value: visibilityDropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: SColors.spaletteAccent),
                      underline: Container(
                        height: 2,
                        color: SColors.spaletteAccent,
                      ),
                      onChanged: (Map<String, String>? value) {
                        setState(() {
                          visibilityDropdownValue = value!;
                        });
                      },
                      items: visibilityConfigurations
                          .map<DropdownMenuItem<Map<String, String>>>(
                              (Map<String, String> value) {
                        return DropdownMenuItem<Map<String, String>>(
                          value: value,
                          child: Text(value["type"]!),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  Row(
                    children: [
                      Text(
                        "Board Background",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(RouteConstant.selectBgColor.name);
                        },
                        child: Container(
                            width: 45,
                            height: 45,
                            decoration:
                                const BoxDecoration(color: SColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections),
                  ReusableButton(
                    text: 'Create Board',
                    onPressed: () {
                      if (boardName.currentState!.validate() &&
                          dropdownValue != null) {
                        createStrideBoard();
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
