import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/feature/workspace/repository/workspace_repository.dart';
import 'package:strideon/models/workspace_model.dart';
import 'package:strideon/utils/constants/image_strings.dart';
import 'package:strideon/utils/snackbar/show_snackbar.dart';

final userWorkSpaceProvider = StreamProvider((ref) {
  final workSpaceController = ref.watch(workSpaceControllerProvider.notifier);
  return workSpaceController.getUserWorkSpace();
});

final getWorkSpaceNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(workSpaceControllerProvider.notifier)
      .getWorkSpaceByName(name);
});

final workSpaceControllerProvider =
    StateNotifierProvider<WorkspaceController, bool>((ref) {
  return WorkspaceController(
    workspaceRepository: ref.read(workSpaceProvider),
    ref: ref,
  );
});

final searchWorkSpaceProvider = StreamProvider.family((ref, String query) {
  return ref.watch(workSpaceControllerProvider.notifier).searchWorkSpace(query);
});

class WorkspaceController extends StateNotifier<bool> {
  final WorkspaceRepository _workspaceRepository;
  final Ref _ref;

  WorkspaceController({
    required WorkspaceRepository workspaceRepository,
    required Ref ref,
  })  : _workspaceRepository = workspaceRepository,
        _ref = ref,
        super(false);

  void createWorkSpace(String name, BuildContext context) async {
    try {
      state = true;
      final uid = FirebaseAuth.instance.currentUser!.uid ?? '';
      WorkSpace workSpace = WorkSpace(
        id: name,
        name: name,
        banner: SImages.bannerDefault,
        avatar: SImages.avatarDefault,
        members: [uid],
        mods: [uid],
      );

      await _workspaceRepository.createWorkspace(workSpace);
      state = false;
      Navigator.pop(context);
    } catch (e) {
      state = false;
      showSnackBar(context, 'The Workspace has been already created');
    }
  }

  Stream<List<WorkSpace>> getUserWorkSpace() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _workspaceRepository.getUserWorkSpace(uid);
  }

  void joinWorkSpace(WorkSpace workSpaceName) async {
    final user = FirebaseAuth.instance.currentUser!;

    if (workSpaceName.members.contains(user.uid)) {
      _workspaceRepository.leaveWorkSpace(workSpaceName.name, user.uid);
    } else {
      _workspaceRepository.joinWorkSpace(workSpaceName.name, user.uid);
    }
  }

  Stream<List<WorkSpace>> searchWorkSpace(String query) {
    return _workspaceRepository.searchCommunity(query);
  }

  void addMods(String workSpace, List<String> uid, BuildContext context) async {
    await _workspaceRepository.addMods(workSpace, uid);
    GoRouter.of(context).pop();
  }

  Stream<WorkSpace> getWorkSpaceByName(String name) {
    return _workspaceRepository.getWorkSpaceByName(name);
  }
}
