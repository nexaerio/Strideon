import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/models/create_board_model.dart';
import 'package:strideon/services/stride_board/repository/stride_repository.dart';

final userBoardProvider = StreamProvider((ref) {
  final workSpaceController = ref.watch(createBoardProvider.notifier);
  return workSpaceController.getUserSBoard();
});

final createBoardProvider =
    StateNotifierProvider<StrideController, bool>((ref) {
  return StrideController(strideRepository: ref.watch(boardProvider));
});

final getStrideBoardNameProvider = StreamProvider.family((ref, String name) {
  return ref.watch(createBoardProvider.notifier).getStrideByName(name);
});



class StrideController extends StateNotifier<bool> {
  final StrideRepository _strideRepository;

  StrideController({required StrideRepository strideRepository})
      : _strideRepository = strideRepository,
        super(false);

  void createBoard(String name, BuildContext context, String boardColor,
      String workSpace) async {
    state = true;
    final uid = FirebaseAuth.instance.currentUser!.uid ?? '';
    CreateBoard createBoard = CreateBoard(
      boardName: name,
      boardColor: boardColor,
      workSpace: workSpace,
      id: uid,
    );

    try {
      await _strideRepository.createBoard(createBoard);
      state = false;
      GoRouter.of(context).pushNamed(RouteConstant.strideBoardPage.name,
          pathParameters: {'name': name});
    } catch (e) {
      state = false;

      print("Error creating board: $e");
    }
  }

  Stream<List<CreateBoard>> getUserSBoard() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _strideRepository.getUserBoard(uid);
  }

  Stream<CreateBoard> getStrideByName(String name) {
    return _strideRepository.getStrideByName(name);
  }

  void deleteStrideBoard() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _strideRepository.deleteStrideBoard(uid);
  }
}
