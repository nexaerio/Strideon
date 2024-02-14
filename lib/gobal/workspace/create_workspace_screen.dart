import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/button/resuable_button.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

class CreateWorkSpacePage extends ConsumerStatefulWidget {
  const CreateWorkSpacePage({super.key});

  @override
  ConsumerState createState() => _CreateWorkSpacePageState();
}

class _CreateWorkSpacePageState extends ConsumerState<CreateWorkSpacePage> {
  final workSpaceController = TextEditingController();
  final _workSpaceKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    workSpaceController.dispose();
  }

  void createWorkSpace(context) {
    ref
        .read(workSpaceControllerProvider.notifier)
        .createWorkSpace(workSpaceController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(workSpaceControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a WorkSpace',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('WorkSpace name',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: SColors.darkGrey)),
                  const SizedBox(
                    height: SSizes.spaceBtwItems,
                  ),
                  Form(
                    key: _workSpaceKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter WorkSpace';
                        }
                        return null;
                      },
                      controller: workSpaceController,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.all(18),
                        hintText: 's/WorkSpace Name',
                      ),
                      maxLength: 21,
                    ),
                  ),
                  const SizedBox(
                    height: SSizes.spaceBtwItems,
                  ),
                  ReusableButton(
                      text: 'Create workspace',
                      onPressed: () {
                        if (_workSpaceKey.currentState!.validate()) {
                          createWorkSpace(context);
                        }
                      })
                ],
              ),
            ),
    );
  }
}
