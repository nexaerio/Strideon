import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/firebase/firebase_constants.dart';
import 'package:strideon/models/todo_model.dart';
import 'package:strideon/widgets/todo_widgets/card_todo.dart';

class TodoView extends StatefulWidget {
  const TodoView({
    super.key,
    required this.user,
    required this.todoData,
  });

  final User? user;
  final AsyncValue<List<TodoModel>> todoData;

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(FirebaseConstants.todoCollection)
          .where(
            FirebaseConstants.docID,
            isEqualTo: widget.user?.uid,
          )
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Text("No tasks found");
        }

        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ReorderableListView.builder(
              itemCount: widget.todoData.value?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) => CardTodoWidget(
                getIndex: index,
                key: Key('$index'),
              ),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = widget.todoData.value?.removeAt(oldIndex);
                  widget.todoData.value?.insert(newIndex, item!);
                });
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
