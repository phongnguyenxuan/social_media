// ignore_for_file: unnecessary_getters_setters

class UserModel {
  String? _sId;
  String? _name;
  String? _email;
  String? _phone;
  String? _avatar;
  String? _coverImage;
  String? _description;
  List<String>? _follower;
  List<String>? _following;
  bool? _isNewAccount;
  bool? _emailVerify;
  String? _createdAt;

  UserModel(
      {String? sId,
      String? name,
      String? email,
      String? phone,
      String? avatar,
      String? coverImage,
      String? description,
      List<String>? follower,
      List<String>? following,
      bool? isNewAccount,
      bool? emailVerify,
      String? createdAt}) {
    if (sId != null) {
      _sId = sId;
    }
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (avatar != null) {
      _avatar = avatar;
    }
    if (coverImage != null) {
      _coverImage = coverImage;
    }
    if (description != null) {
      _description = description;
    }
    if (follower != null) {
      _follower = follower;
    }
    if (following != null) {
      _following = following;
    }
    if (isNewAccount != null) {
      _isNewAccount = isNewAccount;
    }
    if (emailVerify != null) {
      _emailVerify = emailVerify;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;
  String? get coverImage => _coverImage;
  set coverImage(String? coverImage) => _coverImage = coverImage;
  String? get description => _description;
  set description(String? description) => _description = description;
  List<String>? get follower => _follower;
  set follower(List<String>? follower) => _follower = follower;
  List<String>? get following => _following;
  set following(List<String>? following) => _following = following;
  bool? get isNewAccount => _isNewAccount;
  set isNewAccount(bool? isNewAccount) => _isNewAccount = isNewAccount;
  bool? get emailVerify => _emailVerify;
  set emailVerify(bool? emailVerify) => _emailVerify = emailVerify;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  UserModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _avatar = json['avatar'];
    _coverImage = json['coverImage'];
    _description = json['description'];
    _follower = json['follower'].cast<String>();
    _following = json['following'].cast<String>();
    _isNewAccount = json['isNewAccount'];
    _emailVerify = json['emailVerify'];
    _createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['email'] = _email;
    data['phone'] = _phone;
    data['avatar'] = _avatar;
    data['coverImage'] = _coverImage;
    data['description'] = _description;
    data['follower'] = _follower;
    data['following'] = _following;
    data['isNewAccount'] = _isNewAccount;
    data['emailVerify'] = _emailVerify;
    data['createdAt'] = _createdAt;
    return data;
  }
}
