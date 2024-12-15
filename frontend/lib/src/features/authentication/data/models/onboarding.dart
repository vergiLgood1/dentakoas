class OnBoardngReqParam {
  final String image;
  final String title;
  final String subTitle;

  OnBoardngReqParam({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
    };
  }
}
