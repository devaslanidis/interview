class FollowersModel {
  String? name, avatar;
  int? followers, publicRepos;

  FollowersModel(
      this.name,
      this.avatar,
);

  FollowersModel.fromJson(Map<String, dynamic> map) {
    name = map['login'];
    avatar =  map['avatar_url'];
  }
}

