import 'package:flutter/material.dart';
import 'package:interview/providers/search_user.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // initialization search text controller.
  final TextEditingController _searchText = TextEditingController();
  // initialization userData which will have the values that the api will return.
  List<UserModel>userData = [];
  // initialization message value.
  String? message;

  //Starts the search by request the api.
  searchUser(context, String userName) async{
    //call search provider function.
    await Provider.of<SearchUser>(context,listen:false).searchUser(userName);
    // call value userData and message in search provider.
    userData = Provider.of<SearchUser>(context,listen:false).userData;
    message =  Provider.of<SearchUser>(context,listen:false).message;

    //update value if changed.
    setState(() {
      message;
      userData;
    });
  }


  @override
  void dispose() {
    //clear search text controller.
    _searchText.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
            color: Colors.black
        ),
        title: const Text(
          'Search',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value){
                // delete userData list after clear search field or
                // the message value has 'not found' which gets it from the api.
                if(value.isEmpty || message == 'Not Found'){
                  //update value if changed.
                  setState(() {
                    userData.clear();
                    // change message value.
                    message ='Search Users';
                  });
                }else{
                  //update value if changed.
                  setState(() {
                    // change message value if typing.
                    message ='Start Searching...';
                  });
                }
              },
              cursorColor: Colors.black,
              controller: _searchText,
              decoration: InputDecoration(
                  disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black
                      ),
                  ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search,color: Colors.black,),
                  onPressed: () async{
                      await searchUser(context,_searchText.text);
                  },
                )
              ),
            )
          ),
            // check if userData list is empty.
            userData.isEmpty
            ? Padding(
              padding: const EdgeInsets.all(100),
                child: Center(
                  child: Text(
                    message ?? 'Search Users',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25
                    ),
                  ),
                ),
            )
            : userData[0].name == null || userData[0].avatar == null
            ?  Padding(
              padding: const EdgeInsets.all(100),
              child: Center(
                child: Text(
                  message ?? 'something went wrong, try again!',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25
                  ),
                ),
              ),
            )
            :Padding(
            padding: const EdgeInsets.only(top:25),
            child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    NetworkImage(userData[0].avatar!),//fetch user avatar url.
                  ),
                  title: Text(
                    userData[0].name!,//fetch user name.
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
