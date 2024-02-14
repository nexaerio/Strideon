import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/firebase/firebase_storage/firebase_storage.dart';
import 'package:strideon/core/image_picker/image_picker.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/gobal/dotted_border/dotted_border.dart';
import 'package:strideon/models/workspace_model.dart';
import 'package:strideon/utils/constants/image_strings.dart';

class EditWorkSpacePage extends ConsumerStatefulWidget {
  final String name;

  const EditWorkSpacePage({super.key, required this.name});

  @override
  ConsumerState createState() => _EditWorkSpacePageState();
}

class _EditWorkSpacePageState extends ConsumerState<EditWorkSpacePage> {
  Uint8List? _bannerImage;
  Uint8List? _profileImage;

  void selectBannerImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _bannerImage = img;
    });
  }

  void selectProfileImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _profileImage = img;
    });
  }

  void save(WorkSpace space) async {
    ref.read(firebaseStorageProvider.notifier).saveWorkSpaceData(
          bannerFile: _bannerImage,
          profileFile: _profileImage,
          workSpace: space,
        );
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getWorkSpaceNameProvider(widget.name)).when(
          data: (workSpace) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit WorkSpace'),
              actions: [
                TextButton(
                  onPressed: () => save(workSpace),
                  child: const Text('Save'),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorderContainer(
                            borderRadius: 40.0,
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: _bannerImage != null
                                    ? Image(image: MemoryImage(_bannerImage!))
                                    : const Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                        ),
                                      )),
                          ),
                        ),
                        Positioned(
                          bottom: 18,
                          left: 25,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: _profileImage != null
                                ? CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        MemoryImage(_profileImage!),
                                  )
                                : const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(SImages.avatarDefault)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
