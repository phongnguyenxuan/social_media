class PostModel {
  String? sId;
  String? content;
  List<String>? images;
  int? likeCount;
  int? commentLength;
  bool? isLiked;
  String? createdAt;
  Author? author;
  String? folderId;

  PostModel(
      {this.sId,
      this.content,
      this.images,
      this.likeCount,
      this.commentLength,
      this.isLiked,
      this.createdAt,
      this.folderId,
      this.author});

  PostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    images = json['images'].cast<String>();
    likeCount = json['likeCount'];
    commentLength = json['commentLength'];
    isLiked = json['isLiked'];
    createdAt = json['createdAt'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    folderId = json['folderId'];
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
    data['folderId'] = folderId;
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
  String? nickName;

  Author({this.sId, this.name, this.avatar, this.nickName});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    avatar = json['avatar'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['avatar'] = avatar;
    data['nickName'] = nickName;
    return data;
  }
}
