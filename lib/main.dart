import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.teal],
          ),
        ),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoListItem(
              todoItem: todos[index],
              onCompleted: () {
                setState(() {
                  todos[index].isCompleted = !todos[index].isCompleted;
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController todoController = TextEditingController();

        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: todoController,
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos.add(TodoItem(text: todoController.text));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class TodoItem {
  String text;
  bool isCompleted;

  TodoItem({required this.text, this.isCompleted = false});
}

class TodoListItem extends StatelessWidget {
  final TodoItem todoItem;
  final VoidCallback onCompleted;

  TodoListItem({required this.todoItem, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          todoItem.text,
          style: TextStyle(
            decoration: todoItem.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            todoItem.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: todoItem.isCompleted ? Colors.green : null,
          ),
          onPressed: onCompleted,
        ),
      ),
    );
  }
}
