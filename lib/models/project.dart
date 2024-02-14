import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strideon/models/board_model.dart';
import 'package:strideon/services/kanban/config.dart';

class Project {
  final String _projectId;
  final String _projectName;
  final String _projectOwner;
  final List _projectMembers;
  final List<Board> _projectBoards;
  final String _projectJoinCode;
  final Timestamp _projectCreatedDate;
  final String _projectWorkSpace;
  final String _projectColor;

  Project(
    this._projectId,
    this._projectName,
    this._projectOwner,
    this._projectMembers,
    this._projectBoards,
    this._projectJoinCode,
    this._projectCreatedDate,
    this._projectWorkSpace,
    this._projectColor,
  );

  Project.fromJson(Map<String, dynamic> json)
      : _projectId = json[KanQ.projectId],
        _projectName = json[KanQ.projectName],
        _projectOwner = json[KanQ.projectOwner],
        _projectMembers = json[KanQ.projectMembers],
        _projectBoards = json[KanQ.projectBoards],
        _projectJoinCode = json[KanQ.projectJoinCode],
        _projectWorkSpace = json[KanQ.projectWorkSpace],
        _projectColor = json[KanQ.projectColor],
        _projectCreatedDate = json[KanQ.projectCreatedDate];

  Map<String, dynamic> toJson() => {
        KanQ.projectId: _projectId,
        KanQ.projectName: _projectName,
        KanQ.projectOwner: _projectOwner,
        KanQ.projectMembers: _projectMembers,
        KanQ.projectBoards: _projectBoards,
        KanQ.projectJoinCode: _projectJoinCode,
        KanQ.projectColor: _projectColor,
        KanQ.projectWorkSpace: _projectWorkSpace,
        KanQ.projectCreatedDate: _projectCreatedDate,
      };

  Timestamp get projectCreatedDate => _projectCreatedDate;

  String get projectJoinCode => _projectJoinCode;

  List<Board> get projectBoards => _projectBoards;

  List get projectMembers => _projectMembers;

  String get projectOwner => _projectOwner;

  String get projectName => _projectName;

  String get projectId => _projectId;

  String get projectWorkSpace => _projectWorkSpace;

  String get projectColor => _projectColor;
}
