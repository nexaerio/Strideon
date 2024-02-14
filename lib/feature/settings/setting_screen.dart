import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/firebase/get_name.dart';
import 'package:strideon/core/firebase/get_photo.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/utils/theme/theme_notifier/theme_notifier.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  String? displayEmail = FirebaseAuth.instance.currentUser!.email;
  String? displayName = FirebaseAuth.instance.currentUser!.displayName;

  void signOut(BuildContext context) {
    ref.read(authControllerProvider.notifier).signOut(context);
  }

  void deleteUser(BuildContext context) {
    ref.read(authControllerProvider.notifier).deleteAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    bool switchValue = false;
    final appThemeState = ref.watch(appThemeStateNotifier);
    final userAuth = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Settings',
        style: Theme.of(context).textTheme.headlineLarge,
      )),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const GetProfile(),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GetName(),
                                Text(
                                  displayEmail!,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  RouteConstant.profileEditPage.name);
                            },
                            label: const Center(child: Text('Edit')),
                            icon: const Center(
                                child: Icon(
                              Icons.edit,
                              size: 20,
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Company workspace',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      ref.watch(userWorkSpaceProvider).when(
                            data: (mywork) => mywork.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      height: 80,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          transform: GradientRotation(10),
                                          colors: [
                                            SColors.spaletteAccent,
                                            SColors.white
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: SizedBox(
                                          width: 300,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: mywork.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final workSpace = mywork[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    GoRouter.of(context)
                                                        .pushNamed(
                                                      RouteConstant
                                                          .workSpaceScreen.name,
                                                      pathParameters: {
                                                        'name': workSpace.name
                                                      },
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                workSpace
                                                                    .avatar),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        workSpace.name,
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? SColors.dark
                                                                : SColors.dark),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      height: 75,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          transform: GradientRotation(10),
                                          colors: [
                                            SColors.spaletteAccent,
                                            SColors.white
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SSizes.circleAvatar),
                                              child: const CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    SImages.avatarDefault),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                  RouteConstant
                                                      .createWorkSpacePage.name,
                                                );
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Strideon',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .apply(
                                                          color:
                                                              SColors.primary,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Create your WorkSpace',
                                                    softWrap: false,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .apply(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? SColors.dark
                                                              : SColors.dark
                                                                  .withOpacity(
                                                                      0.5),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            error: (error, stackTrace) =>
                                ErrorText(error: error.toString()),
                            loading: () => const Loader(),
                          ),

                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(25),
                      //   child: Container(
                      //     height: 75,
                      //     width: double.infinity,
                      //     decoration: const BoxDecoration(
                      //         gradient: LinearGradient(
                      //             transform: GradientRotation(10),
                      //             colors: [
                      //           SColors.spaletteAccent,
                      //           SColors.white,
                      //         ])),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(10),
                      //       child: Row(
                      //         children: [
                      //           ClipRRect(
                      //             borderRadius: BorderRadius.circular(
                      //                 SSizes.circleAvatar),
                      //             child: CircleAvatar(
                      //               radius: 25,
                      //               child: Image.network(SImages.avatarDefault),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 20,
                      //           ),
                      //           Column(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceEvenly,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text('Om Bhusal',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .headlineSmall!
                      //                       .apply(
                      //                         color: SColors.primary,
                      //                       )),
                      //               Text('ombhusal@gmail.com',
                      //                   softWrap: false,
                      //                   maxLines: 1,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .labelMedium),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Theme',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      /*    const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(SSizes.circleAvatar),
                                child: const CircleAvatar(
                                  radius: 25,
                                  child: Icon(CupertinoIcons.bell_circle),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Turn on',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      const SizedBox(
                                        width: 110,
                                      ),
                                      Switch(
                                          activeColor: SColors.primary,
                                          value: switchValue,
                                          // changes the state of the switch
                                          onChanged: (value) => setState(() {
                                                switchValue = value;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),
                      SizedBox(
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(SSizes.circleAvatar),
                                child: const CircleAvatar(
                                  radius: 25,
                                  child: Icon(CupertinoIcons.bell_circle),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Push notification',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Switch(
                                          activeColor: SColors.primary,
                                          value: switchValue,
                                          // changes the state of the switch
                                          onChanged: (value) => setState(() {
                                                switchValue = value;
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),*/
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 75,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(SSizes.circleAvatar),
                                child: const CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.dark_mode),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Dark Mode',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      const SizedBox(
                                        width: 90,
                                      ),
                                      Switch(
                                        activeColor: SColors.primary,
                                        value: appThemeState.isDarkModeEnabled,
                                        onChanged: (enabled) {
                                          if (enabled) {
                                            appThemeState.setDarkTheme();
                                          } else {
                                            appThemeState.setLightTheme();
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            SDeviceUtils.getBottomNavigationBarHeight() * 2.2,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: SColors.error,
                            backgroundColor: SColors.error,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            minimumSize: const Size(double.infinity, 20),
                          ),
                          onPressed: () => signOut(context),
                          child: const Text(
                            'Log out',
                            style: TextStyle(color: SColors.light),
                          )),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),
                      Center(
                        child: GestureDetector(
                          onDoubleTap: () => deleteUser(context),
                          child: Text(
                            'Delete Account',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(
                                  fontSizeDelta: 3,
                                  fontSizeFactor: 1.02,
                                  decorationThicknessFactor: 1,
                                  color:
                                      SColors.buttonPrimary.withOpacity(0.65),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
