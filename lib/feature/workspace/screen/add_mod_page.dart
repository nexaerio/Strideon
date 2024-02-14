import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';

class AddModsPage extends ConsumerStatefulWidget {
  const AddModsPage({required this.name, super.key});

  final String name;

  @override
  ConsumerState createState() => _AddModsPageState();
}

class _AddModsPageState extends ConsumerState<AddModsPage> {
  Set<String> uids = {};
  int ctr = 0;

  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void saveMods() {
    ref.read(workSpaceControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => saveMods(), icon: const Icon(Icons.save))
        ],
      ),
      body: ref.watch(getWorkSpaceNameProvider(widget.name)).when(
          data: (workspace) => ListView.builder(
                itemCount: workspace.members.length,
                itemBuilder: (BuildContext context, int index) {
                  final member = workspace.members[index];

                  return ref.watch(getUserDataProvider(member)).when(
                      data: (user) {
                        if (workspace.mods.contains(member) && ctr == 0) {
                          uids.add(member);
                        }
                        ctr++;

                        return CheckboxListTile(
                            value: uids.contains(user.uid),
                            onChanged: (val) {
                              if (val!) {
                                addUid(user.uid);
                              } else {
                                removeUid(user.uid);
                              }
                            },
                            title: Text(user.name));
                      },
                      error: (error, stackTrace) =>
                          ErrorText(error: error.toString()),
                      loading: () => const Loader());
                },
              ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
