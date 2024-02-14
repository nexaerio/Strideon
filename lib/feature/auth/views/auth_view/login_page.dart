import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

void signInWithEmail(WidgetRef ref) {
  ref
      .read(authControllerProvider.notifier)
      .signInWithEmail(_emailController.text, _passwordController.text);
}

void signInWithGoogle(WidgetRef ref, BuildContext context) {
  ref.read(authControllerProvider.notifier).signWithGoogle(context);
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
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
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )),
                      const SizedBox(
                        height: SSizes.spaceBtwSections,
                      ),
                      Form(
                          key: _loginKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'admin@gmail.com',
                                      contentPadding: EdgeInsets.all(18)),
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: SSizes.spaceBtwInputFields,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.all(18),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisible = !passwordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: SSizes.spaceBtwItems,
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(RouteConstant.forgetPasswordPage.name);
                        },
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Forgot Password ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(
                                      fontSizeDelta: 3,
                                      fontWeightDelta: 10,
                                      color: SColors.primary.withOpacity(0.95)),
                            )),
                      ),
                      const SizedBox(
                        height: SSizes.spaceBtwSections,
                      ),
                      ReusableButton(
                          text: 'Sign up',
                          onPressed: () {
                            if (_loginKey.currentState!.validate()) {
                              signInWithEmail(ref);
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
                            'Or sign up with',
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
                            SDeviceUtils.getBottomNavigationBarHeight() * 4.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
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
                                  .goNamed(RouteConstant.registerScreen.name);
                              _emailController.clear();
                              _passwordController.clear();
                            },
                            child: Text(
                              ' Sign Up ',
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
