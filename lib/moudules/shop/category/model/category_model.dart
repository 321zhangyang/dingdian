
class BookCategoryModel {
  int? id;
  String? name;
  int? total;
  String? image;

  BookCategoryModel({this.id, this.name, this.total, this.image});

  BookCategoryModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.total = json["total"];
    this.image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["total"] = this.total;
    data["image"] = this.image;
    return data;
  }
}
