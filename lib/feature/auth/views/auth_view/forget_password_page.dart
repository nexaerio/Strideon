import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/utils/constants/sizes.dart';

void forgetPassword(WidgetRef ref) {
  ref.read(authControllerProvider.notifier).forgetPassword();
}

final TextEditingController forgetPasswordController = TextEditingController();

class ForgetPasswordPage extends ConsumerStatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  ConsumerState<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends ConsumerState<ForgetPasswordPage> {
  final _forgetPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Center(
                  child: Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineLarge,
              )),
              const SizedBox(
                height: SSizes.spaceBtwSections,
              ),
              Form(
                key: _forgetPasswordKey,
                child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'admin@gmail.com',
                        contentPadding: EdgeInsets.all(18)),
                    controller: forgetPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
              ),
              const SizedBox(
                height: SSizes.spaceBtwSections,
              ),
              ReusableButton(
                  text: 'Forget Password',
                  onPressed: () {
                    if (_forgetPasswordKey.currentState!.validate()) {
                      forgetPassword(ref);
                    }
                  }),
              TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: Text(
                    'Go Back',
                    style: Theme.of(context).textTheme.labelMedium,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
