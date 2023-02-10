import 'package:flutter/material.dart';
import 'package:interview/pages/search.dart';
import 'package:interview/providers/fetch_userData.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  // initialization userData which will have the values that the api will return.
  List<UserModel>userData = [];

  //call userData provider
  callProvider(context) async{
    //call user provider function.
    await Provider.of<FetchUserData>(context,listen:false).fetchUserData();
    // call value userData provider.
    userData = Provider.of<FetchUserData>(context,listen:false).userData;

    //update value if changed.
    setState(() {
      userData;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: ElevatedButton.icon(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Search()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          icon: const Icon(Icons.search),  //icon data for elevated button
          label: const Text("Search"), //label text
        )
      ),
      backgroundColor: Colors.white,
      //check if userData list is empty
      body: userData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userData[0].avatar!),//fetch user avatar url.
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        userData[0].name!,// fetch user name.
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Location: ${userData[0].location ?? ''}' ,// fetch user company
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Bio: ${userData[0].bio ?? ''}' ,// fetch user company
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                            children: [
                              Text(
                                '${userData[0].followers}',// fetch user total followers number.
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
                          ),
                          Expanded(
                            child: Column(
                            children: [
                              Text(
                                '${userData[0].publicRepos!}',// fetch user public repos total numbers.
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                'Repositories',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
