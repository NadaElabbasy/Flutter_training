import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  CollectionReference todolist = FirebaseFirestore.instance.collection('Todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      appBar: AppBar(backgroundColor:  Color(0xff0b9eff),
        title: Text(
                  'Todo - list',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                 centerTitle: true,
                ),
                  
        body: FutureBuilder<QuerySnapshot<Object?>>(
          future: todolist.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData == false && snapshot.data == null) {
              return Text("Document does not exist");
            }
            print(snapshot.connectionState.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    "Task Status: ${snapshot.data!.docs[index]['Task']} ${"-"} ${snapshot.data!.docs[index]['Status']}");
   },
 );
 }
 return Text("Loading");
 },
 ));
  }
}
