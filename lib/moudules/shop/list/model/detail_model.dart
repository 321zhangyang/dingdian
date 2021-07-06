
class ShopBookListDetailModel {
    int? listId;
    String? userName;
    String? cover;
    bool? isCheck;
    bool? isRecycle;
    String? title;
    bool? forMan;
    String? description;
    String? addTime;
    String? updateTime;
    List<BookList>? bookList;

    ShopBookListDetailModel({this.listId, this.userName, this.cover, this.isCheck, this.isRecycle, this.title, this.forMan, this.description, this.addTime, this.updateTime, this.bookList});

    ShopBookListDetailModel.fromJson(Map<String, dynamic> json) {
        this.listId = json["ListId"];
        this.userName = json["UserName"];
        this.cover = json["Cover"];
        this.isCheck = json["IsCheck"];
        this.isRecycle = json["IsRecycle"];
        this.title = json["Title"];
        this.forMan = json["ForMan"];
        this.description = json["Description"];
        this.addTime = json["AddTime"];
        this.updateTime = json["UpdateTime"];
        this.bookList = json["BookList"]==null ? null : (json["BookList"] as List).map((e)=>BookList.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["ListId"] = this.listId;
        data["UserName"] = this.userName;
        data["Cover"] = this.cover;
        data["IsCheck"] = this.isCheck;
        data["IsRecycle"] = this.isRecycle;
        data["Title"] = this.title;
        data["ForMan"] = this.forMan;
        data["Description"] = this.description;
        data["AddTime"] = this.addTime;
        data["UpdateTime"] = this.updateTime;
        if(this.bookList != null)
            data["BookList"] = this.bookList?.map((e)=>e.toJson()).toList();
        return data;
    }
}

class BookList {
    int? id;
    int? bookId;
    String? bookName;
    String? bookImage;
    String? author;
    String? categoryName;
    double? score;
    String? description;

    BookList({this.id, this.bookId, this.bookName, this.bookImage, this.author, this.categoryName, this.score, this.description});

    BookList.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.bookId = json["BookId"];
        this.bookName = json["BookName"];
        this.bookImage = json["BookImage"];
        this.author = json["Author"];
        this.categoryName = json["CategoryName"];
        this.score = json["Score"];
        this.description = json["Description"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["BookId"] = this.bookId;
        data["BookName"] = this.bookName;
        data["BookImage"] = this.bookImage;
        data["Author"] = this.author;
        data["CategoryName"] = this.categoryName;
        data["Score"] = this.score;
        data["Description"] = this.description;
        return data;
    }
}