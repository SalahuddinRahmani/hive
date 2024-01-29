import 'package:flutter/material.dart';
import 'package:hive_irani/models/shamahmood/boxes.dart';
import 'package:hive_irani/models/shamahmood/models/note.dart';
import 'main.dart';

void main(){
 runApp(MaterialApp(home: AddNote(),));
}

class AddNote extends StatefulWidget {

  const AddNote({Key?key,this.title,this.content,this.index}):super (key: key);
  final String? title;
  final String? content;
  final int? index;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {


  final title=TextEditingController();
  final content=TextEditingController();
  @override
  Widget build(BuildContext context) {

    if(widget.title!=null||widget.content!=null){
      title.text=widget.title!;
      content.text=widget.content!;
    }

    return
       Scaffold(body: Column(
         children: [
           TextField(
             controller: title,
             decoration: InputDecoration(
               border: OutlineInputBorder(),
               labelText: 'title'
             ),
           ),
           SizedBox(height: 10,),
           TextField(
             controller: content,
             decoration: InputDecoration(
               border: OutlineInputBorder(),
               labelText: 'title'
             ),
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,

             children: [
               MaterialButton(color: Colors.blue,child: Text('Save'),onPressed: ()async{

                 final newNote=Note(title: title.text, content: content.text);

                 if(widget.title!=null||widget.content!=null){
                   noteBox.putAt(widget.index!, newNote);
                 }else{
                   noteBox.add(newNote);
                 }
                 // Navigator.pop(context);
               }),
               MaterialButton(color: Colors.blue,child: Text('cancle'),onPressed: (){}),
             ],
           )
         ],
       ),

         floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return Main();
           }));
         }),
       );

  }
}