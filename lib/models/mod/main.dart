import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_irani/models/shamahmood/boxes.dart';
import 'add_screen.dart';
import 'models/note.dart';

void main()async{

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  noteBox=await Hive.openBox<Note>('noteBox');
 runApp(MaterialApp(home: Main(),));
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(appBar: AppBar(title: Text('Note'),),
       body: ValueListenableBuilder(valueListenable: noteBox.listenable(),
           builder:( context,box,widget){
         return ListView.separated(itemBuilder: (context,index){

           Note note=box.getAt(index)!;

           String tit=note.title;
           String con=note.content;

           return ListTile(onTap: (){
             setState(() {
               Navigator.push(context, MaterialPageRoute(builder: (c) => AddNote(title: tit, content: con,index: index,)));

             });
           },
             trailing: IconButton(onPressed: (){
               box.deleteAt(index);
             }, icon: Icon(Icons.delete)),

             title: Text(note.title),
             subtitle: Text(note.content),
           );

         },
             separatorBuilder: (context,index){
           return SizedBox(height: 10,);
             }, itemCount: noteBox.length);
           }),
         floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return AddNote();
           }));
         }),
       );

  }
}