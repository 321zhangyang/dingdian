class LiveRoomListModel {
    String? address;
    String? img;
    String? title;

    LiveRoomListModel({this.address, this.img, this.title});

    LiveRoomListModel.fromJson(Map<String, dynamic> json) {
        this.address = json["address"];
        this.img = json["img"];
        this.title = json["title"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["address"] = this.address;
        data["img"] = this.img;
        data["title"] = this.title;
        return data;
    }
}