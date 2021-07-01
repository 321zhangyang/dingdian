
class BookChooseModel {
    String? category;
    String? changeFlag;
    String? more;
    String? moreFlag;
    String? navIcon;
    String? viewType;
    List<Books>? books;

    BookChooseModel({this.category, this.changeFlag, this.more, this.moreFlag, this.navIcon, this.viewType, this.books});

    BookChooseModel.fromJson(Map<String, dynamic> json) {
        this.category = json["Category"];
        this.changeFlag = json["ChangeFlag"];
        this.more = json["More"];
        this.moreFlag = json["MoreFlag"];
        this.navIcon = json["NavIcon"];
        this.viewType = json["ViewType"];
        this.books = json["Books"]==null ? null : (json["Books"] as List).map((e)=>Books.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Category"] = this.category;
        data["ChangeFlag"] = this.changeFlag;
        data["More"] = this.more;
        data["MoreFlag"] = this.moreFlag;
        data["NavIcon"] = this.navIcon;
        data["ViewType"] = this.viewType;
        if(this.books != null)
            data["Books"] = this.books?.map((e)=>e.toJson()).toList();
        return data;
    }
}

class Books {
    int? id;
    String? name;
    dynamic? area;
    String? areaCodde;
    String? author;
    String? img;
    String? hostKey;
    String? desc;
    dynamic? bookStatus;
    dynamic? lastChapterId;
    dynamic? lastChapter;
    String? cName;
    dynamic? hitCount;
    dynamic? collectCount;
    dynamic? commendCount;
    dynamic? updateTimeForChapterContent;
    dynamic? updateTime;
    dynamic? firstChapterId;
    String? score;

    Books({this.id, this.name, this.area, this.areaCodde, this.author, this.img, this.hostKey, this.desc, this.bookStatus, this.lastChapterId, this.lastChapter, this.cName, this.hitCount, this.collectCount, this.commendCount, this.updateTimeForChapterContent, this.updateTime, this.firstChapterId, this.score});

    Books.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.name = json["Name"];
        this.area = json["Area"];
        this.areaCodde = json["AreaCodde"];
        this.author = json["Author"];
        this.img = json["Img"];
        this.hostKey = json["HostKey"];
        this.desc = json["Desc"];
        this.bookStatus = json["BookStatus"];
        this.lastChapterId = json["LastChapterId"];
        this.lastChapter = json["LastChapter"];
        this.cName = json["CName"];
        this.hitCount = json["HitCount"];
        this.collectCount = json["CollectCount"];
        this.commendCount = json["CommendCount"];
        this.updateTimeForChapterContent = json["UpdateTimeForChapterContent"];
        this.updateTime = json["UpdateTime"];
        this.firstChapterId = json["FirstChapterId"];
        this.score = json["Score"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["Name"] = this.name;
        data["Area"] = this.area;
        data["AreaCodde"] = this.areaCodde;
        data["Author"] = this.author;
        data["Img"] = this.img;
        data["HostKey"] = this.hostKey;
        data["Desc"] = this.desc;
        data["BookStatus"] = this.bookStatus;
        data["LastChapterId"] = this.lastChapterId;
        data["LastChapter"] = this.lastChapter;
        data["CName"] = this.cName;
        data["HitCount"] = this.hitCount;
        data["CollectCount"] = this.collectCount;
        data["CommendCount"] = this.commendCount;
        data["UpdateTimeForChapterContent"] = this.updateTimeForChapterContent;
        data["UpdateTime"] = this.updateTime;
        data["FirstChapterId"] = this.firstChapterId;
        data["Score"] = this.score;
        return data;
    }
}