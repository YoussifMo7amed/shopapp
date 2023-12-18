

// ignore_for_file: non_constant_identifier_names

class Categoriesmodel {
  bool? Status;
  CategoriesDatamodel? data;
  Categoriesmodel.fromjson(Map<String, dynamic> json) {
    Status = json['status'];
    data = CategoriesDatamodel.fromjson(json['data']);
  }
}

class CategoriesDatamodel {
  int? current_page;
  List<Datamodel> data = [];
  CategoriesDatamodel.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(Datamodel.fromjson(element));
    });
  }
}

class Datamodel {
  int? id;
  String? name;
  String? image;
  Datamodel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
