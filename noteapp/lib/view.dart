import 'package:flutter/material.dart';
import 'package:noteapp/add.dart';

import 'package:noteapp/widgets/list1.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.blue,title: Text("Home"),),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(10),
        child: Listnote1(),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}