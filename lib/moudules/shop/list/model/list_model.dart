class ShopBookListModel {
  int? listId;
  String? userName;
  bool? forMan;
  String? cover;
  String? title;
  String? description;
  int? bookCount;
  String? commendImage;
  int? collectionCount;
  int? commendCount;
  bool? isCheck;
  String? addTime;
  String? updateTime;

  ShopBookListModel(
      {this.listId,
      this.userName,
      this.forMan,
      this.cover,
      this.title,
      this.description,
      this.bookCount,
      this.commendImage,
      this.collectionCount,
      this.commendCount,
      this.isCheck,
      this.addTime,
      this.updateTime});

  ShopBookListModel.fromJson(Map<String, dynamic> json) {
    this.listId = json["ListId"];
    this.userName = json["UserName"];
    this.forMan = json["ForMan"];
    this.cover = json["Cover"];
    this.title = json["Title"];
    this.description = json["Description"];
    this.bookCount = json["BookCount"];
    this.commendImage = json["CommendImage"];
    this.collectionCount = json["CollectionCount"];
    this.commendCount = json["CommendCount"];
    this.isCheck = json["IsCheck"];
    this.addTime = json["AddTime"];
    this.updateTime = json["UpdateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ListId"] = this.listId;
    data["UserName"] = this.userName;
    data["ForMan"] = this.forMan;
    data["Cover"] = this.cover;
    data["Title"] = this.title;
    data["Description"] = this.description;
    data["BookCount"] = this.bookCount;
    data["CommendImage"] = this.commendImage;
    data["CollectionCount"] = this.collectionCount;
    data["CommendCount"] = this.commendCount;
    data["IsCheck"] = this.isCheck;
    data["AddTime"] = this.addTime;
    data["UpdateTime"] = this.updateTime;
    return data;
  }
}
