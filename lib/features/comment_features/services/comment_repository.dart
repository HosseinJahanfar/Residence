import 'package:dio/dio.dart';
import 'package:residence/features/comment_features/model/comment_model.dart';
import 'package:residence/features/comment_features/services/comment_api_services.dart';

class CommentRepository {
  final CommentAPiServices _commentAPiServices = CommentAPiServices();

  Future<CommentModel> callShowComment(String id) async {
    final Response response = await _commentAPiServices.callShowComment(id);
    final CommentModel commentModel = CommentModel.fromJson(response.data);
    return commentModel;
  }

  Future<Comments> addComment(String comment, int id) async {
    Response response= await _commentAPiServices.addComment(comment, id);
    Comments addComment =Comments.fromJson(response.data);
    return addComment;
  }
}
