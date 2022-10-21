import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:to_do_app/utils/constants.dart';
import '../../data_source/local/curd.dart';

import '../../model/note_model.dart';
import 'body_view.dart';

class NewTaskeScreen extends StatefulWidget {
  const NewTaskeScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskeScreen> createState() => _NewTaskeScreenState();
}

class _NewTaskeScreenState extends State<NewTaskeScreen> {
  @override
  void initState() {
    viewNotes();   
    super.initState();
  }
  var updateKey = GlobalKey<FormState>();
  TextEditingController?  UpdateController;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Note>>(
        future:viewNotes(),
        builder:(Context,snapshot)
      {if(snapshot.hasData){
        var MYnote=snapshot.data!;
        return ListView.builder(
        itemCount: MYnote.length,
        itemBuilder:(context,index)=>Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), 
          children: [
            SlidableAction(label: 'Delete',
          icon: Icons.delete,
          backgroundColor: Colors.redAccent,
          onPressed: ((context) {setState(() {
            deleteNote(MYnote[index].noteId);
          });}))],),
          startActionPane: ActionPane(motion: StretchMotion(),
          children: [
            SlidableAction(
              label: 'Edit task',
              backgroundColor: Colors.green,
              icon: Icons.edit,
              onPressed:((context) {setState(() {
            editNote(MYnote[index],context);
          });}))
          ]),
          child: BodyView(MYnote: MYnote , index : index),
        ) ,
        );
      }else if(snapshot.hasError){
        return Text(snapshot.error!.toString(),style: const TextStyle(color: Colors.red),);
      }else{
        return const Center(child: CircularProgressIndicator(color: Colors.pink ),);
      }
      }
       ,)
       ,
    );
  }

  Future<List<Note>> viewNotes() {
    return CURD.curd.viewNotesFromDB();
  }

  void deleteNote(int? noteId) {
    CURD.curd.DeleteNote(noteId).then((row){
      if(row !=0){
        _ShowSuccessMassage("Deleted Success",context);
      }else{
        _ShowErrorMassage('Error on Delete',Context);
      }
    });
  }

  void _ShowSuccessMassage(String massage,Context) {
        ScaffoldMessenger.of(Context).showSnackBar(SnackBar(content: Text(massage)));

  }

  void _ShowErrorMassage(String massageError,Context) {
            ScaffoldMessenger.of(Context).showSnackBar(SnackBar(content: Text(massageError)));

  }

  editNote(Note mYnote,context) {
    UpdateController=TextEditingController(text: mYnote.noteTitle);
    showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        actions: [
      TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Cancel')),
      TextButton(onPressed: (){
        if(updateKey.currentState!.validate()){
         mYnote.noteTitle=UpdateController!.value.text;
          UpdateNote(mYnote);
          setState(() {
            
          });
          Navigator.of(context).pop();
        }else{}
      }, child: Text('update')),
    ],title: Text("update Task"),
    content:Form(key: updateKey,child:TextFormField(
      decoration: InputDecoration(labelText: 'task'),
      validator: (value)=>value!.isEmpty?'must be not empty':null,
      controller: UpdateController,
    ) ,) ,));
  }

  void UpdateNote(Note mYnote) {
    CURD.curd.UpDateNote(mYnote).then((row) {
      if(row !=0){
        _ShowSuccessMassage("update Success",context);
        setState(() { 
        });
      }else{
        _ShowErrorMassage('Error on update',Context);
      }
    });
  }
}

