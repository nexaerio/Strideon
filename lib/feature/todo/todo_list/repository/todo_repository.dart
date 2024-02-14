import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/provider.dart';

import 'package:strideon/models/todo_model.dart';

final todoRepository = StateProvider<TodoRepository>((ref) {
  return TodoRepository();
});

class TodoRepository extends ChangeNotifier {
  final todoCollection = FirebaseFirestore.instance.collection('todoList');

  //CREATE
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //UPDATE

  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  //DELETE

  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }

  void updateRadioValue(String? docID, String category, WidgetRef ref) {
    final getRadioValue = ref.read(radioProvider).toString();

    todoCollection.doc(docID).update({
      'category': getRadioValue,
    }).then((_) {
      switch (getRadioValue) {
        case '1':
          todoCollection.doc(docID).update({'category': 'Learning'});
          break;
        case '2':
          todoCollection.doc(docID).update({'category': 'Working'});
          break;
        case '3':
          todoCollection.doc(docID).update({'category': 'General'});
          break;
        default:
          break;
      }
    }).catchError((error) {
      print('Error updating document: $error');
    });
  }


  void updateDateTime(String? docID, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);

    todoCollection.doc(docID).update({
      'dateTask': dateProv,
      'timeTask': timeProv,
    }).toString();
  }

  void updateTodo(String? docID, TextEditingController titleController,
      TextEditingController descriptionController) {
    todoCollection.doc(docID).update({
      'titleTask': titleController.text.trim(),
      'description': descriptionController.text.trim(),
    }).toString();
  }

  void isDoneFilter() {
    final doc = FirebaseFirestore.instance
        .collection("todoList")
        .where("isDone" == true);

    print(doc);
  }
}
