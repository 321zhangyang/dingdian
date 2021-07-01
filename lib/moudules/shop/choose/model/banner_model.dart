class BookBannerModel {
    String? type;
    String? param;
    String? imgurl;

    BookBannerModel({this.type, this.param, this.imgurl});

    BookBannerModel.fromJson(Map<String, dynamic> json) {
        this.type = json["type"];
        this.param = json["param"];
        this.imgurl = json["imgurl"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["type"] = this.type;
        data["param"] = this.param;
        data["imgurl"] = this.imgurl;
        return data;
    }
}