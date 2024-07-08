part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoadingState extends CommentState {}

final class CommentCompletedState extends CommentState {
  final List<Comments>? comments;

  CommentCompletedState({required this.comments});
}

final class CommentErrorState extends CommentState {
  final String error;

  CommentErrorState({required this.error});
}

/// add comment

final class AddCommentLoadingState extends CommentState {}

final class AddCommentCompletedState extends CommentState {
  final String msgSuccess;

  AddCommentCompletedState({required this.msgSuccess});
}

final class AddCommentErrorState extends CommentState {
  final String error;

  AddCommentErrorState({required this.error});
}