class UserCardModel {
  final String? nickName;
  final String? imagePath;
  final String? date;
  final String? description;
  UserCardModel({
    this.description,
    this.nickName,
    this.imagePath,
    this.date,
  });
}

List<UserCardModel> userCardModelList = [];
