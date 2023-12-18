// ignore_for_file: camel_case_types, non_constant_identifier_names

class Homemodel{
  bool? status;
   homeDataModel? data;
   Homemodel.fromjson(Map<String,dynamic> json)
   {
    status =json['status'];
    data = homeDataModel.fromjson(json['data']);

   }
}

class homeDataModel {
List<BannersModel> banners=[];
List<ProductsModel> products=[];
homeDataModel.fromjson(Map<String,dynamic> json)
{
  json['banners'].forEach((element) {
    banners.add(BannersModel.fromjson(element));
  });
  json['products'].forEach((element) {
    products.add(ProductsModel.fromjson(element));
  });
}
}
class BannersModel{
int ?id;
String ? image;
BannersModel.fromjson(Map<String,dynamic> json)
{
  id=json['id'];
  image=json['image']??'';
}
}
class ProductsModel{
late int  id;
dynamic price;
dynamic old_price;
dynamic discount;
String ? image;
String? name;
bool ? in_favorites;
bool ? in_cart;
ProductsModel.fromjson(Map<String,dynamic>json)
{
  id=json['id'];
  price=json['price'];
  old_price=json['old_price'];
  discount=json['discount'];
  image=json['image'];
  name=json['name'];
  in_favorites=json['in_favorites'];
  in_cart=json['in_cart'];
}
}
