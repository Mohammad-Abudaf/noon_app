class CategoriesModel {
  bool status;
  DataModel data;
  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}
class DataModel{
  int page;
  List<Data2Model> data = [];
  DataModel.fromJson(Map<String, dynamic> json){
    page = json['current_page'];
    json['data'].forEach((element){
      data.add(Data2Model.fromJson(element));
    });
  }
}
class Data2Model{
  int id;
  String name;
  String image;
  Data2Model.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}