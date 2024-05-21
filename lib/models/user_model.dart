// ignore_for_file: unnecessary_getters_setters

class UserModel {
  String? _id;
  String? _name;
  bool? _status;
  String? _description;
  String? _email;
  String? _phone;
  bool? _emailVerification;
  List<String>? _follower;
  List<String>? _following;
  String? _avatar;
  String? _coverPhoto;
  String? _createdAt;

  UserModel(
      {String? id,
      String? name,
      bool? status,
      String? description,
      String? email,
      String? phone,
      bool? emailVerification,
      List<String>? follower,
      List<String>? following,
      String? avatar,
      String? coverPhoto,
      String? createdAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (status != null) {
      _status = status;
    }
    if (description != null) {
      _description = description;
    }
    if (email != null) {
      _email = email;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (emailVerification != null) {
      _emailVerification = emailVerification;
    }
    if (follower != null) {
      _follower = follower;
    }
    if (following != null) {
      _following = following;
    }
    if (avatar != null) {
      _avatar = avatar;
    }
    if (coverPhoto != null) {
      _coverPhoto = coverPhoto;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  bool? get emailVerification => _emailVerification;
  set emailVerification(bool? emailVerification) =>
      _emailVerification = emailVerification;
  List<String>? get follower => _follower;
  set follower(List<String>? follower) => _follower = follower;
  List<String>? get following => _following;
  set following(List<String>? following) => _following = following;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;
  String? get coverPhoto => _coverPhoto;
  set coverPhoto(String? coverPhoto) => _coverPhoto = coverPhoto;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _description = json['description'];
    _email = json['email'];
    _phone = json['phone'];
    _emailVerification = json['emailVerification'];
    _follower = json['follower'].cast<String>();
    _following = json['following'].cast<String>();
    _avatar = json['avatar'];
    _coverPhoto = json['coverPhoto'];
    _createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['status'] = _status;
    data['description'] = _description;
    data['email'] = _email;
    data['phone'] = _phone;
    data['emailVerification'] = _emailVerification;
    data['follower'] = _follower;
    data['following'] = _following;
    data['avatar'] = _avatar;
    data['coverPhoto'] = _coverPhoto;
    data['createdAt'] = _createdAt;
    return data;
  }
}
