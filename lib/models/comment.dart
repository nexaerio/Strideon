import 'package:strideon/models/user_model.dart';

class Comment {
  late UserModel from;
  late DateTime publishDate;
  late String text;

  Comment(from, publishDate, text);
}
