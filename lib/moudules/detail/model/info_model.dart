
class BookDetailInfoModel {
    int? id;
    String? name;
    String? img;
    String? author;
    String? desc;
    int? cId;
    String? cName;
    String? lastTime;
    int? firstChapterId;
    String? lastChapter;
    int? lastChapterId;
    String? bookStatus;
    List<SameUserBooks>? sameUserBooks;
    List<SameCategoryBooks>? sameCategoryBooks;
    BookVote? bookVote;
    String? upUser;
    String? declare;

    BookDetailInfoModel({this.id, this.name, this.img, this.author, this.desc, this.cId, this.cName, this.lastTime, this.firstChapterId, this.lastChapter, this.lastChapterId, this.bookStatus, this.sameUserBooks, this.sameCategoryBooks, this.bookVote, this.upUser, this.declare});

    BookDetailInfoModel.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.name = json["Name"];
        this.img = json["Img"];
        this.author = json["Author"];
        this.desc = json["Desc"];
        this.cId = json["CId"];
        this.cName = json["CName"];
        this.lastTime = json["LastTime"];
        this.firstChapterId = json["FirstChapterId"];
        this.lastChapter = json["LastChapter"];
        this.lastChapterId = json["LastChapterId"];
        this.bookStatus = json["BookStatus"];
        this.sameUserBooks = json["SameUserBooks"]==null ? null : (json["SameUserBooks"] as List).map((e)=>SameUserBooks.fromJson(e)).toList();
        this.sameCategoryBooks = json["SameCategoryBooks"]==null ? null : (json["SameCategoryBooks"] as List).map((e)=>SameCategoryBooks.fromJson(e)).toList();
        this.bookVote = json["BookVote"] == null ? null : BookVote.fromJson(json["BookVote"]);
        this.upUser = json["UpUser"];
        this.declare = json["Declare"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["Name"] = this.name;
        data["Img"] = this.img;
        data["Author"] = this.author;
        data["Desc"] = this.desc;
        data["CId"] = this.cId;
        data["CName"] = this.cName;
        data["LastTime"] = this.lastTime;
        data["FirstChapterId"] = this.firstChapterId;
        data["LastChapter"] = this.lastChapter;
        data["LastChapterId"] = this.lastChapterId;
        data["BookStatus"] = this.bookStatus;
        if(this.sameUserBooks != null)
            data["SameUserBooks"] = this.sameUserBooks?.map((e)=>e.toJson()).toList();
        if(this.sameCategoryBooks != null)
            data["SameCategoryBooks"] = this.sameCategoryBooks?.map((e)=>e.toJson()).toList();
        if(this.bookVote != null)
            data["BookVote"] = this.bookVote?.toJson();
        data["UpUser"] = this.upUser;
        data["Declare"] = this.declare;
        return data;
    }
}

class BookVote {
    int? bookId;
    int? totalScore;
    int? voterCount;
    double? score;

    BookVote({this.bookId, this.totalScore, this.voterCount, this.score});

    BookVote.fromJson(Map<String, dynamic> json) {
        this.bookId = json["BookId"];
        this.totalScore = json["TotalScore"];
        this.voterCount = json["VoterCount"];
        this.score = json["Score"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["BookId"] = this.bookId;
        data["TotalScore"] = this.totalScore;
        data["VoterCount"] = this.voterCount;
        data["Score"] = this.score;
        return data;
    }
}

class SameCategoryBooks {
    int? id;
    String? name;
    String? img;
    double? score;

    SameCategoryBooks({this.id, this.name, this.img, this.score});

    SameCategoryBooks.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.name = json["Name"];
        this.img = json["Img"];
        this.score = json["Score"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["Name"] = this.name;
        data["Img"] = this.img;
        data["Score"] = this.score;
        return data;
    }
}

class SameUserBooks {
    int? id;
    String? name;
    String? author;
    String? img;
    int? lastChapterId;
    String? lastChapter;
    double? score;

    SameUserBooks({this.id, this.name, this.author, this.img, this.lastChapterId, this.lastChapter, this.score});

    SameUserBooks.fromJson(Map<String, dynamic> json) {
        this.id = json["Id"];
        this.name = json["Name"];
        this.author = json["Author"];
        this.img = json["Img"];
        this.lastChapterId = json["LastChapterId"];
        this.lastChapter = json["LastChapter"];
        this.score = json["Score"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["Id"] = this.id;
        data["Name"] = this.name;
        data["Author"] = this.author;
        data["Img"] = this.img;
        data["LastChapterId"] = this.lastChapterId;
        data["LastChapter"] = this.lastChapter;
        data["Score"] = this.score;
        return data;
    }
}