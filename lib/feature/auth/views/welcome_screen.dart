import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/constants/sizes.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState createState() => _WelcomeScreenState();
}

void signInWithGoogle(WidgetRef ref, BuildContext context) {
  ref.read(authControllerProvider.notifier).signWithGoogle(context);
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(SImages.appLogo),
                    const SizedBox(
                      height: 320,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: SColors.buttonPrimary,
                            minimumSize: const Size(
                                double.infinity, SSizes.buttonHeight)),
                        onPressed: () => signInWithGoogle(ref, context),
                        icon: const ImageIcon(
                          AssetImage(
                            SImages.googleLogo,
                          ),
                          size: 21,
                          color: SColors.light,
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(color: SColors.light),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(
                                double.infinity, SSizes.buttonHeight)),
                        onPressed: () {
                          GoRouter.of(context)
                              .push(RouteConstant.registerScreen.getPath);
                        },
                        child: Text(
                          'Register an Account',
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? SColors.black
                                  : SColors.light),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
