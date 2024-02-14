import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/firebase/firebase_storage/firebase_storage.dart';
import 'package:strideon/core/image_picker/image_picker.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/device/device_utility.dart';


import '../../../utils/constants/sizes.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  Uint8List? _image;

  final TextEditingController nameController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    final userData = ref.read(firebaseStorageProvider.notifier);
    String? name = nameController.text;
    if (name != null || _image != null) {
      await userData.saveUserData(name: name, file: _image);
      GoRouter.of(context).pop();
    } else {
      print("No data to update");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            CupertinoIcons.back,
            size: 25,
          ),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: selectImage,
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: const CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(SImages.avatarDefault),
                                    ),
                                  ),
                            const Positioned(
                                right: 10,
                                bottom: -2,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: SColors.greyColor,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),
                      Text(
                        'Tap to upload new image',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: SColors.info),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: SSizes.spaceBtwSections,
                ),
                // Text(
                //   'Name',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                const SizedBox(
                  height: SSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(
                        CupertinoIcons.profile_circled,
                        size: 30,
                      )),
                ),
                // const SizedBox(
                //   height: SSizes.spaceBtwInputFields,
                // ),
                // Text(
                //   'Phone number',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // const SizedBox(
                //   height: SSizes.spaceBtwInputFields,
                // ),
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   decoration: const InputDecoration(
                //       prefixIcon: Icon(
                //     CupertinoIcons.phone_circle_fill,
                //     size: 30,
                //   )),
                // ),
                // const SizedBox(
                //   height: SSizes.spaceBtwInputFields,
                // ),
                SizedBox(
                  height: SDeviceUtils.getBottomNavigationBarHeight() * 6,
                ),
                ReusableButton(
                  text: 'Save changes',
                  onPressed: saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
