import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String timeTask;
  final String dateTask;
  final bool isDone;

  TodoModel({
    this.docID,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.timeTask,
    required this.dateTask,
    required this.isDone,
  });

  TodoModel copyWith({
    String? docID,
    String? titleTask,
    String? description,
    String? category,
    String? timeTask,
    String? dateTask,
    bool? isDone,
  }) {
    return TodoModel(
      docID: docID ?? this.docID,
      titleTask: titleTask ?? this.titleTask,
      description: description ?? this.description,
      category: category ?? this.category,
      timeTask: timeTask ?? this.timeTask,
      dateTask: dateTask ?? this.dateTask,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docID': docID,
      'titleTask': titleTask,
      'description': description,
      'category': category,
      'timeTask': timeTask,
      'dateTask': dateTask,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      timeTask: map['timeTask'] as String,
      dateTask: map['dateTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    var firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
    return TodoModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      description: doc['description'],
      category: doc['category'],
      timeTask: doc['timeTask'],
      dateTask: doc['dateTask'],
      isDone: doc['isDone'],
    );
  }
}
