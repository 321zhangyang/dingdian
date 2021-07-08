
class BookSearchResultModel {
    String? id;
    String? name;
    String? author;
    String? img;
    String? desc;
    String? bookStatus;
    String? lastChapterId;
    String? lastChapter;
    String? cName;
    String? updateTime;
    String? weekHitCount;
    String? monthHitCount;
    String? hitCount;

    BookSearchResultModel({this.id, this.name, this.author, this.img, this.desc, this.bookStatus, this.lastChapterId, this.lastChapter, this.cName, this.updateTime, this.weekHitCount, this.monthHitCount, this.hitCount});

    BookSearchResultModel.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.name = json["Name"];
        this.author = json["Author"];
        this.img = json["Img"];
        this.desc = json["Desc"];
        this.bookStatus = json["BookStatus"];
        this.lastChapterId = json["LastChapterId"];
        this.lastChapter = json["LastChapter"];
        this.cName = json["CName"];
        this.updateTime = json["UpdateTime"];
        this.weekHitCount = json["weekHitCount"];
        this.monthHitCount = json["monthHitCount"];
        this.hitCount = json["hitCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["Name"] = this.name;
        data["Author"] = this.author;
        data["Img"] = this.img;
        data["Desc"] = this.desc;
        data["BookStatus"] = this.bookStatus;
        data["LastChapterId"] = this.lastChapterId;
        data["LastChapter"] = this.lastChapter;
        data["CName"] = this.cName;
        data["UpdateTime"] = this.updateTime;
        data["weekHitCount"] = this.weekHitCount;
        data["monthHitCount"] = this.monthHitCount;
        data["hitCount"] = this.hitCount;
        return data;
    }
}