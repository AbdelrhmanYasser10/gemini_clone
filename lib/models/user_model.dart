class UserModel{
  late String userId;
  late String email;
  late String username;
  

  UserModel({
    required this.email,
    required this.username,
    required this.userId ,
    });

  UserModel.fromJson(Map<String,dynamic>json){
    email = json["email"];
    username = json["username"];
    userId = json["userId"];
  }

  Map<String,dynamic> toMap(){
    return {
      "email":email,
      "username":username,
      "userId":userId,
    };
  }


}