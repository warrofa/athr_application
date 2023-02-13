class UserCertModel {
  String? userId;
  String? userImage;
  String? userLink;
  String? userPhone;
  String? userName;

  UserCertModel({
    this.userImage,
    this.userLink,
    this.userId,
    this.userPhone,
    this.userName,
  });

  Map<String, dynamic> todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['user_id'] = userId;
    mapping['user_image'] = userImage;
    mapping['user_link'] = userLink;
    mapping['user_phone'] = userPhone;
    mapping['user_name'] = userName;

    return mapping;
  }

  factory UserCertModel.fromJson(Map<String, dynamic> map) {
    return UserCertModel(
      userId:
      map['user_id'] == null ? '' : map['user_id'],
      userPhone:
      map['user_phone'] == null ? '' : map['user_phone'],

      userName:
      map['user_name'] == null ? '' : map['user_name'],
      userImage:
      map['user_image'] == null ? '' : map['user_image'],
      userLink:
    map['user_link'] == null ? '' : map['user_link'],
    );
  }





}



