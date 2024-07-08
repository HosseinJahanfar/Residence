import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/comment_features/model/comment_model.dart';
import '../../public_features/error/error_exception.dart';
import '../services/comment_repository.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;
  List<Comments>? comments=[];
  CommentBloc(this._commentRepository) : super(CommentInitial()) {
    on<CallShowCommentEvent>(_callShowCommentEvent);
    on<CallAddCommentEvent>(_callAddCommentEvent);
  }

  Future<void> _callShowCommentEvent(
      CallShowCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());

    try {
      comments!.clear();
       CommentModel commentModel =
          await _commentRepository.callShowComment(event.id);
       for (var commentModel in commentModel.comments!) {
         comments?.add(commentModel);
       }

       emit(CommentCompletedState(comments: comments));
    } on DioException catch (e) {
      emit(CommentErrorState(error: ErrorExceptions().fromError(e).toString()));
    }
  }

  Future<void> _callAddCommentEvent(
      CallAddCommentEvent event, Emitter<CommentState> emit) async {
    try {
      Comments addComment= await _commentRepository.addComment(event.comment, event.id);
      comments!.add(addComment);
      emit(CommentCompletedState(comments: comments));
    } on DioException catch (e) {
      emit(AddCommentErrorState(
          error: ErrorExceptions().fromError(e).toString()));
    }
  }
}
