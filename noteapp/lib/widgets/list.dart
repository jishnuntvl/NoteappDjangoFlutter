import 'package:flutter/material.dart';
import 'package:noteapp/data/data.dart';
import 'package:noteapp/data/notemodel/notemodel.dart';

class Listnote extends StatelessWidget {
  Listnote({super.key});



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp)async {
      await Notedb.instance.getAllNotes();
      
    });

    return ValueListenableBuilder(valueListenable: Notedb.instance.noteListNoti,
    builder: (context,List<Notemodel> newnote,_){
      return ListView.separated(
        itemBuilder: (ctx,index){
          final _note=Notedb.instance.noteListNoti.value[index];
          return ListTile(
            title: Text(_note.title!),
            subtitle: Text(_note.content!),
            trailing:Icon(Icons.delete,color: Colors.red,),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Text(_note.id.toString()),
            ),
          );
        }, 
        separatorBuilder: ((context, index) => Divider()), 
        itemCount: newnote.length);
    },);
  }
}