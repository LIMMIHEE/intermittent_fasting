class History {
  int id = 01;
  String startDate = "";
  String endDate = "";
  String fastingRatio = "";
  String memo = "";

  History(
      {this.id = 01,
      this.startDate = "",
      this.endDate = "",
      this.fastingRatio = "",
      this.memo = ""});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    fastingRatio = json['fastingRatio'];
    memo = json['memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['fastingRatio'] = fastingRatio;
    data['memo'] = memo;
    return data;
  }
}
