class PostModel {
  String? sId;
  String? content;
  List<String>? images;
  int? likeCount;
  int? commentLength;
  bool? isLiked;
  String? createdAt;
  Author? author;

  PostModel(
      {this.sId,
      this.content,
      this.images,
      this.likeCount,
      this.commentLength,
      this.isLiked,
      this.createdAt,
      this.author});

  PostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    images = json['images'].cast<String>();
    likeCount = json['likeCount'];
    commentLength = json['commentLength'];
    isLiked = json['isLiked'];
    createdAt = json['createdAt'];
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['images'] = images;
    data['likeCount'] = likeCount;
    data['commentLength'] = commentLength;
    data['isLiked'] = isLiked;
    data['createdAt'] = createdAt;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}

class Author {
  String? sId;
  String? name;
  String? avatar;

  Author({this.sId, this.name, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
