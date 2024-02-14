import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/utils/snackbar/show_snackbar.dart';

final TextEditingController nameController = TextEditingController();

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

void signUpWithEmail(WidgetRef ref) {
  ref
      .watch(authControllerProvider.notifier)
      .signUpWithEmail(emailController.text, passwordController.text);
}

void signInWithGoogle(WidgetRef ref, BuildContext context) {
  ref.read(authControllerProvider.notifier).signWithGoogle(context);
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _registerKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )),
                      const SizedBox(
                        height: SSizes.spaceBtwSections,
                      ),
                      Form(
                          key: _registerKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  contentPadding: EdgeInsets.all(18),
                                  errorStyle: TextStyle(fontSize: 12),
                                ),
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter some text";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: SSizes.spaceBtwInputFields,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: 'admin@gmail.com',
                                    contentPadding: EdgeInsets.all(18),
                                    errorStyle: TextStyle(fontSize: 12)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter some text";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: SSizes.spaceBtwInputFields,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: _passwordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter some text";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.all(18),
                                  suffixIcon: IconButton(
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _passwordVisible = !_passwordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: SSizes.spaceBtwSections,
                      ),
                      ReusableButton(
                          text: 'Sign up',
                          onPressed: () {
                            if (_registerKey.currentState!.validate()) {
                              signUpWithEmail(ref);
                              // showSnackBar(
                              //     context, 'Please check your email to verify');
                            }
                          }),
                      const SizedBox(
                        height: SSizes.spaceBtwSections,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                              child: Divider(
                            thickness: 2.5,
                          )),
                          const SizedBox(
                            width: SSizes.spaceBtwItems,
                          ),
                          Text(
                            'Or sign in with',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(fontSizeDelta: 3),
                          ),
                          const SizedBox(
                            width: SSizes.spaceBtwItems,
                          ),
                          const Expanded(
                              child: Divider(
                            thickness: 2.5,
                          )),
                        ],
                      ),
                      const SizedBox(height: SSizes.spaceBtwItems),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 60,
                            height: 50,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    SImages.googleLogo,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                                color: SColors.white,
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  SColors.grey,
                                ]),
                                shape: BoxShape.rectangle),
                            child: GestureDetector(
                              onTap: () => signInWithGoogle(ref, context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            SDeviceUtils.getBottomNavigationBarHeight() * 3.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                    fontSizeDelta: 3.5,
                                    color: SColors.dark.withOpacity(0.9)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteConstant.loginPage.name);
                              emailController.clear();
                              passwordController.clear();
                              nameController.clear();
                            },
                            child: Text(
                              ' Sign in ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(color: SColors.primary),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
