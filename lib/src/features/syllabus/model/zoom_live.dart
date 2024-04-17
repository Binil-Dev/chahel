

class ZoomLiveModel {
  bool? isLiveNow;
  String? link;
  ZoomLiveModel({
     this.isLiveNow,
     this.link,
  });

  ZoomLiveModel copyWith({
    bool? isLiveNow,
    String? link,
  }) {
    return ZoomLiveModel(
      isLiveNow: isLiveNow ?? this.isLiveNow,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLiveNow': isLiveNow,
      'link': link,
    };
  }

  factory ZoomLiveModel.fromMap(Map<String, dynamic> map) {
    return ZoomLiveModel(
      isLiveNow: map['isLiveNow'] != null ? map['isLiveNow'] as bool : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

}
