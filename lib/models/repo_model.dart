class RepoModel {
  String? name, description;
  int? starCount;

  RepoModel(
      this.name,
      this.description,
      this.starCount,
 );

  RepoModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    description =  map['description'];
    starCount = map['stargazers_count'];
  }
}

