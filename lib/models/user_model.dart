class UserModel {
   String? name, avatar, location, bio;
   int? followers, publicRepos;

   UserModel(
     this.name,
     this.avatar,
     this.followers,
     this.location,
     this.bio,
     this.publicRepos,
  );

UserModel.fromJson(Map<String, dynamic> map) {
      name = map['name'];
      avatar =  map['avatar_url'];
      followers =  map['followers'];
      location = map['location'];
      bio = map['bio'];
      publicRepos = map['public_repos'];
  }
}
