import 'package:flutter/material.dart';
import 'package:interview/models/repo_model.dart';
import 'package:interview/providers/fetch_repos.dart';
import 'package:provider/provider.dart';

class Repos extends StatefulWidget {
  const Repos({Key? key}) : super(key: key);

  @override
  State<Repos> createState() => _Repos();
}

class _Repos extends State<Repos>{
  // initialization reposData which will have the values that the api will return.
  List<RepoModel>reposData = [];
  // initialization sortList with asc and desc value
  List sortList = ['ascending','descending'];
  // initialization selectedValue value.
  String? selectedValue;

  //call repos provider
  callProvider(context) async{
    //call repos function.
    await Provider.of<FetchRepos>(context,listen:false).fetchRepos();
    // call value reposData in repos provider.
    reposData = Provider.of<FetchRepos>(context,listen:false).reposData;

    //update value if changed.
    setState(() {
      reposData;
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
        title: DropdownButtonHideUnderline(
          child:DropdownButton(
            isExpanded: true,
            hint: const FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Sort by stars',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ),
            items: sortList.map((item)=> DropdownMenuItem<String>(
              value: item,
              child: Text(
                item.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black
                ),
              ),
            ),).toList(),
            //changes the value in dropdown with the value of the option.
            value: selectedValue,
            onChanged: (value) {
              //check if the option value changes to asc or desc
              if(value == 'ascending'){
                // sort list by asc
                reposData.sort((a,b)=> a.starCount!.compareTo(b.starCount!));
              }else{
                // sort list by desc
                reposData.sort((a,b)=> b.starCount!.compareTo(a.starCount!));
              }
              //update value if changed.
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: reposData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.only(top:25),
        child: ListView.builder(
          itemCount: reposData.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(
                reposData[index].name!,//fetch repos name.
              ),
              subtitle: Text(
                reposData[index].description ?? '',//fetch description and if is null fetch empty string.
              ),
              trailing: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:'${reposData[index].starCount!}',//fetch star numbers.
                      style: const TextStyle(color: Colors.black),
                    ),
                    const WidgetSpan(
                      child: Icon(Icons.star, size: 16,color: Colors.amber,),
                    ),
                  ],
                ),
              ),

            );
          }),
        ),
      ),
    );
  }
}
