part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class CallShowCommentEvent extends CommentEvent {
  final String id;

  CallShowCommentEvent({required this.id});
}

class CallAddCommentEvent extends CommentEvent {
  final int id;
  final String comment;

  CallAddCommentEvent({required this.id, required this.comment});
}
