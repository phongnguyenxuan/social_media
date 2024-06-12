class UserModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? coverImage;
  String? description;
  List<String>? follower;
  List<String>? following;
  bool? isNewAccount;
  bool? emailVerify;
  String? createdAt;
  String? updatedAt;
  String? refreshToken;
  String? nickName;

  UserModel(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.coverImage,
      this.description,
      this.follower,
      this.following,
      this.isNewAccount,
      this.emailVerify,
      this.createdAt,
      this.updatedAt,
      this.refreshToken,
      this.nickName});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    description = json['description'];
    follower = json['follower'].cast<String>();
    following = json['following'].cast<String>();
    isNewAccount = json['isNewAccount'];
    emailVerify = json['emailVerify'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    refreshToken = json['refreshToken'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['coverImage'] = coverImage;
    data['description'] = description;
    data['follower'] = follower;
    data['following'] = following;
    data['isNewAccount'] = isNewAccount;
    data['emailVerify'] = emailVerify;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['refreshToken'] = refreshToken;
    data['nickName'] = nickName;
    return data;
  }
}
