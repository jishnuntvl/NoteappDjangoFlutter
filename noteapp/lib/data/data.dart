import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/data/notemodel/notemodel.dart';
import 'package:noteapp/data/url.dart';

abstract class ApiCalls{
  Future<Notemodel?>createNote(Notemodel value);
  Future<Notemodel?>updateNote(Notemodel value);
  Future<void>deleteNote(int id);
  Future<List<Notemodel>?>getAllNotes();
}

class Notedb extends ApiCalls{
  //==single ton
  Notedb._internal();
  static Notedb instance = Notedb._internal();
  Notedb factory(){
    return instance;
  }

  //==end sigle ton

  final dio=Dio();
  final url=Url();

  ValueNotifier<List<Notemodel>> noteListNoti=ValueNotifier([]);

  Notedb(){
    dio.options=BaseOptions(
      baseUrl: url.baseurl,
      responseType: ResponseType.plain
    );
  }

  @override
  Future<Notemodel?> createNote(Notemodel value) async{
    final _result= await dio.post(url.addNote,data: value.toJson());
    final _resultasjson=jsonDecode(_result.data);
    return Notemodel.fromJson(_resultasjson as Map<String,dynamic>);
  }

  @override
  Future<void> deleteNote(int id) async{
    final _result=await dio.delete(url.baseurl+url.deleteNote.replaceFirst("{pk}", "$id"));
    print(_result);
    return _result.data;
    
  }


  @override
  Future<List<Notemodel>?> getAllNotes() async{
    final _result=await dio.get(url.baseurl+url.getAllNote);
    print(_result);
    if (_result.data==null){
      noteListNoti.value.clear();
      return [];
    }
    else{
      print("object#############");
      List resultasjson=jsonDecode(_result.data);
      print(resultasjson);
      noteListNoti.value.clear();
      noteListNoti.value.addAll(resultasjson.map((post) => Notemodel.fromJson(post)).toList());
      print(noteListNoti.value);
      return resultasjson.map((post) => Notemodel.fromJson(post)).toList();
    }
  }

  @override
  Future<Notemodel> updateNote(Notemodel value) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
  
}
  