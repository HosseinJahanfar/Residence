class CommentModel {
  CommentModel({
    this.totalComments,
    this.comments,
    this.addNewComment,
  });

  int? totalComments;
  List<Comments>? comments;
  bool? addNewComment;

  CommentModel.fromJson(dynamic json) {
    totalComments = json['total_comments'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    addNewComment = json['add_new_comment'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_comments'] = totalComments;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    map['add_new_comment'] = addNewComment;
    return map;
  }
}

class Comments {
  Comments({
    this.fullname,
    this.comment,
    this.timeSinceCreated,
  });

  Comments.fromJson(dynamic json) {
    fullname = json['fullname'];
    comment = json['comment'];
    timeSinceCreated = json['time_since_created'];
  }

  String? fullname;
  String? comment;
  String? timeSinceCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = fullname;
    map['comment'] = comment;
    map['time_since_created'] = timeSinceCreated;
    return map;
  }
}
