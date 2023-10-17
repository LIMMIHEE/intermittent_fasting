class FastingTime {
  bool isFasting = true;
  DateTime? startTime;
  String fastingRatio = '16:4';
  int targetTime = const Duration(hours: 16).inSeconds;

  FastingTime(
      {this.isFasting = true,
      this.startTime,
      this.fastingRatio = '16:4',
      this.targetTime = 0});

  FastingTime copyWith({
    bool? isFasting,
    DateTime? startTime,
    String? fastingRatio,
    int? targetTime,
  }) {
    return FastingTime(
      isFasting: isFasting ?? this.isFasting,
      startTime: startTime ?? this.startTime,
      fastingRatio: fastingRatio ?? this.fastingRatio,
      targetTime: targetTime ?? this.targetTime,
    );
  }

  FastingTime.fromJson(Map<String, dynamic> json) {
    isFasting = json['isFasting'];
    if (json['startTime'] != 'null') {
      startTime = DateTime.parse(json['startTime']);
    }
    fastingRatio = json['fastingRatio'];
    targetTime = json['targetTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFasting'] = isFasting;
    data['startTime'] = startTime.toString();
    data['fastingRatio'] = fastingRatio;
    data['targetTime'] = targetTime;
    return data;
  }
}
