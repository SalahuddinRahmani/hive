import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_irani/models/box.dart';
import 'package:hive_irani/models/person.dart';



import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 Hive.registerAdapter(PersonAdapter());
  personBox = await Hive.openBox('personBox');

 runApp( MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  TextEditingController c1=TextEditingController();
  TextEditingController c2=TextEditingController();
  TextEditingController c3=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            
            TextField(
              controller: c1,
              decoration: InputDecoration(hintText: 'name',border: OutlineInputBorder()),),

            TextField(
              controller: c2,
              decoration: InputDecoration(hintText: 'Lname',border: OutlineInputBorder()),),

            TextField(
              controller: c3,
              decoration: InputDecoration(hintText: 'age',border: OutlineInputBorder()),),
            
            
            ElevatedButton(onPressed: ()async{

              final person = Person(name: c1.text, lastName: c2.text, age: int.parse(c3.text));
             await personBox.add(person);

            }, child: Text("Save")),

            ElevatedButton(onPressed: (){

              personBox.keys.forEach((element) {
                Person? p = personBox.get(element);
                print(p?.name);
                print(p?.lastName);
                print(p?.age);
                print("-----------------------/n");
              });

            }, child: Text("Get"))
          ],
        ),

      )

    );

  }
}