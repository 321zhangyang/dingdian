class BookChooseListModel {
  List<BookList>? bookList;
  int? page;
  bool? hasNext;

  BookChooseListModel({this.bookList, this.page, this.hasNext});

  BookChooseListModel.fromJson(Map<String, dynamic> json) {
    this.bookList = json["BookList"] == null
        ? null
        : (json["BookList"] as List).map((e) => BookList.fromJson(e)).toList();
    this.page = json["Page"];
    this.hasNext = json["HasNext"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookList != null)
      data["BookList"] = this.bookList?.map((e) => e.toJson()).toList();
    data["Page"] = this.page;
    data["HasNext"] = this.hasNext;
    return data;
  }
}

class BookList {
  int? id;
  String? name;
  String? author;
  String? img;
  String? desc;
  String? cName;
  double? score;

  BookList(
      {this.id,
      this.name,
      this.author,
      this.img,
      this.desc,
      this.cName,
      this.score});

  BookList.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
    this.name = json["Name"];
    this.author = json["Author"];
    this.img = json["Img"];
    this.desc = json["Desc"];
    this.cName = json["CName"];
    this.score = json["Score"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Id"] = this.id;
    data["Name"] = this.name;
    data["Author"] = this.author;
    data["Img"] = this.img;
    data["Desc"] = this.desc;
    data["CName"] = this.cName;
    data["Score"] = this.score;
    return data;
  }
}
