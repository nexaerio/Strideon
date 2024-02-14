// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreateBoard {
  final String boardName;
  final String workSpace;
  final String boardColor;
  final String id;

  CreateBoard({
    required this.boardName,
    required this.workSpace,
    required this.boardColor,
    required this.id,
  });

  CreateBoard copyWith({
    String? boardName,
    String? workSpace,
    String? boardColor,
    String? id,
  }) {
    return CreateBoard(
      boardName: boardName ?? this.boardName,
      workSpace: workSpace ?? this.workSpace,
      boardColor: boardColor ?? this.boardColor,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boardName': boardName,
      'workSpace': workSpace,
      'boardColor': boardColor,
      'id': id,
    };
  }

  factory CreateBoard.fromMap(Map<String, dynamic> map) {
    return CreateBoard(
      boardName: map['boardName'] ?? '',
      workSpace: map['workSpace'] ?? '',
      boardColor: map['boardColor'] ?? '',
      id: map['id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CreateBoard(boardName: $boardName, workSpace: $workSpace, boardColor: $boardColor, id: $id)';
  }

  @override
  bool operator ==(covariant CreateBoard other) {
    if (identical(this, other)) return true;

    return other.boardName == boardName &&
        other.workSpace == workSpace &&
        other.boardColor == boardColor &&
        other.id == id;
  }

  @override
  int get hashCode {
    return boardName.hashCode ^
        workSpace.hashCode ^
        boardColor.hashCode ^
        id.hashCode;
  }
}
