class Favorite{
  bool status;
  String message;
  Data data;
  Favorite.fromJson(Map<String, dynamic> json){
    data = json['data'];
  }

}
class Data {
  int id;
  Product product;
  Data.fromJson(Map <String, dynamic> json){
    product = json['data'];
  }
}
class Product{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  Product.fromJson(Map <String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    image = json['image'];
  }
}