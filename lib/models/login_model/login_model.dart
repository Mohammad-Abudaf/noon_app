class LoginModel{
   bool status;
   String massage;
   UserData data;

   LoginModel.jsonData(Map <String, dynamic> json){
      status = json['status'];
      massage = json['massage'];
      data = json['data'] != null? UserData.fromJson(json['data']) : null;
   }
}

class UserData{
   int id;
   String name;
   String email;
   String phone;
   String image;
   int points;
   int credit;
   String token;

   UserData({
      this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.credit,
      this.points,
      this.token,
});
   //namedConstructor
   UserData.fromJson(Map <String, dynamic> json){
      id = json["id"];
      name = json["name"];
      email = json["email"];
      phone = json["phone"];
      image = json["image"];
      credit = json["credit"];
      points = json["points"];
      token = json["token"];
   }
}