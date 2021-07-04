class BookDirectoryModel {
  int? id;
  String? name;
  List<OneList>? list;

  BookDirectoryModel({this.id, this.name, this.list});

  BookDirectoryModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) {
            return OneList.fromJson(e);
          }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    if (this.list != null)
      data["list"] = this.list?.map((e) => e.toJson()).toList();
    return data;
  }
}

class OneList {
  String? name;
  List<TwoList>? list;

  OneList({this.name, this.list});

  OneList.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => TwoList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    if (this.list != null)
      data["list"] = this.list?.map((e) => e.toJson()).toList();
    return data;
  }
}

class TwoList {
  int? id;
  String? name;
  int? hasContent;

  TwoList({this.id, this.name, this.hasContent});

  TwoList.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.hasContent = json["hasContent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["hasContent"] = this.hasContent;
    return data;
  }
}
