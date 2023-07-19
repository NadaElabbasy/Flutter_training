import 'package:flutter/material.dart';
import 'package:flutter_navigation/models/completion_model.dart';
import 'package:flutter_navigation/services/completion_service.dart';
import 'package:flutter_navigation/views/Todo/Todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextPage extends StatefulWidget {
  final String email;

  const NextPage({
    super.key,
    required this.email,
  });

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 90,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/todo.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Todo - list',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: Color(0xff0b9eff)),
        body: BlocProvider(
            create: (context) => TodoCubit(),
            child: BlocConsumer<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TodoSuccess) {
                  return ListView.builder(
                    itemCount: context.watch<TodoCubit>().todo.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            context.watch<TodoCubit>().todo[index].title ??
                                "--",
                            style: const TextStyle(color: Color(0xff009aff))),
                        subtitle: Text(context
                                .watch<TodoCubit>()
                                .todo[index]
                                .completed
                                .toString() ??
                            "--"),
                        trailing: Icon(Icons.add_task),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Error in this screen"),
                  );
                }
              },
              listener: (context, state) {},
            )));
  }
}
/*appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/todo.png',
                height: 50,
                width: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Todo - list',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Color(0xff0b9eff)),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: todo.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todo[index].title ?? "--",
                      style: const TextStyle(color: Color(0xff009aff))),
                  subtitle: Text(todo[index].completed.toString() ?? "--"),
                  trailing: Icon(Icons.add_task),
                );
              },
       
            ),*/
