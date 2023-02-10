import 'package:flutter/material.dart';
import 'package:interview/models/followers_model.dart';
import 'package:interview/providers/fetch_followers.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/fetch_userData.dart';

class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  State<Followers> createState() => _Followers();
}

class _Followers extends State<Followers>{
  // initialization followersData which will have the values that the api will return.
  List<FollowersModel>followersData = [];
  List<UserModel>userData = [];

  //call followers provider
  callProvider(context) async{
    //call followers provider function.
    await Provider.of<FetchFollowers>(context,listen:false).fetchFollowers();
    // call value followersData provider.
    followersData = Provider.of<FetchFollowers>(context,listen:false).followersData;
    // call value user provider.
    userData = Provider.of<FetchUserData>(context,listen:false).userData;

    //update value if changed.
    setState(() {
      userData;
      followersData;
    });
  }

  @override
  void initState() {
    callProvider(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //check if followers list is empty
      body: userData.isNotEmpty || followersData.isNotEmpty
      ?Column(
        children: [
           userData[0].followers == null
          ? followersWidget(0)
              : followersWidget(userData[0].followers!),
          Expanded(
            child:followersData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.only(top:25),
                  child: ListView.builder(
                      itemCount: followersData.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(followersData[index].avatar!),// fetch followers avatar url.
                          ),
                          title: Text(
                            followersData[index].name!,// fetch followers name.
                          ),
                        );
                      }),
                    ),
                ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator(),),
    );
  }
}

Widget followersWidget (int followers){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Text(
          '$followers',// fetch user total followers number.
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        const Text(
          'Followers',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
