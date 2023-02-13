class UserModel{
  String? userName;
  String? phoneNumber;
  String? image;
  String? email;
  String? userID;
  UserModel({this.email,this.userID,this.userName,this.image,this.phoneNumber});

  // NamedConstructor => I will used it when i get Data from fireStore and save it on this model
  UserModel.fromJson(Map<String,dynamic> json){
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    email = json['email'];
    userID = json['uid'];
  }

  // TOJson  => I will used it when i want to  send data to cloud firestore ( Fields )
  Map<String,dynamic> toJson(){
    return {
      'userName' : userName,
      'phoneNumber' : phoneNumber,
      'image' : image,
      'email' : email,
      'uid' : userID,
    };
  }
}