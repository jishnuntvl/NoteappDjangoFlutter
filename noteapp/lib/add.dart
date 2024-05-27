import 'package:flutter/material.dart';
import 'package:noteapp/data/data.dart';
import 'package:noteapp/data/notemodel/notemodel.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});
  final _titlecontroller=TextEditingController();
  final _contentcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.blue,title: Text("Add Notes"),),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextFormField(
            controller: _titlecontroller,
            decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Title"),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _contentcontroller,
            maxLines: 5, 
            decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Content"),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){saveNote(context);}, child: Text("Save"))
        ],),
      )),
    );
  }
  Future<void>saveNote(context)async{
    final title=_titlecontroller.text;
    final content=_contentcontroller.text;
    final _newNote=Notemodel(
    title:title,
    content: content
    
    );
    final newnote=await Notedb().createNote(_newNote);
    if( newnote!=null){
      print("SAved");
      Navigator.of(context).pop();
    }
    else{
      print("Error while saveing");
    }
  }
}