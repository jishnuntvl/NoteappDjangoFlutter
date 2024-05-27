import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/data/url.dart';

class Listnote1 extends StatefulWidget {
  const Listnote1({super.key});

  @override
  State<Listnote1> createState() => _Listnote1State();
}

class _Listnote1State extends State<Listnote1> {

  var jsonList;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      getdata();
    });
  }

  void getdata()async{
    try{
      final url=Url();
      var response=await Dio().get(url.baseurl+url.getAllNote);
      if (response.statusCode==200) {
        setState(() {
          jsonList =response.data as List;
        });
      }else{
        print(response.statusCode);
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx,index){
          return ListTile(
            title: Text(jsonList[index]["title"]),
            subtitle: Text(jsonList[index]["content"]),
            trailing:IconButton(onPressed: (){
              deletenote(jsonList[index]["id"].toString());
            }, 
            icon: Icon(Icons.delete,color: Colors.red,)),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Text(jsonList[index]["id"].toString()),
            ),
          );
        }, 
        separatorBuilder: ((context, index) => Divider()), 
        itemCount: jsonList==null?0:jsonList.length);
  }
  void deletenote(String id)async{
    final note=await Dio().delete("http://192.168.174.176:8000/api/item/$id/delete/");
    print(note);
  }
}