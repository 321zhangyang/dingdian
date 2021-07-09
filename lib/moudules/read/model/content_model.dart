
class BookChapterContentModel {
    int? id;
    String? name;
    int? cid;
    String? cname;
    int? pid;
    int? nid;
    String? content;
    int? hasContent;

    BookChapterContentModel({this.id, this.name, this.cid, this.cname, this.pid, this.nid, this.content, this.hasContent});

    BookChapterContentModel.fromJson(Map<String, dynamic> json) {
        this.id = json["id"];
        this.name = json["name"];
        this.cid = json["cid"];
        this.cname = json["cname"];
        this.pid = json["pid"];
        this.nid = json["nid"];
        this.content = json["content"];
        this.hasContent = json["hasContent"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["id"] = this.id;
        data["name"] = this.name;
        data["cid"] = this.cid;
        data["cname"] = this.cname;
        data["pid"] = this.pid;
        data["nid"] = this.nid;
        data["content"] = this.content;
        data["hasContent"] = this.hasContent;
        return data;
    }
}