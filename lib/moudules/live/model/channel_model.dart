class LiveChannelListModel {
    String? address;
    String? xinimg;
    String? number;
    String? title;

    LiveChannelListModel({this.address, this.xinimg, this.number, this.title});

    LiveChannelListModel.fromJson(Map<String, dynamic> json) {
        this.address = json["address"];
        this.xinimg = json["xinimg"];
        this.number = json["Number"];
        this.title = json["title"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["address"] = this.address;
        data["xinimg"] = this.xinimg;
        data["Number"] = this.number;
        data["title"] = this.title;
        return data;
    }
}