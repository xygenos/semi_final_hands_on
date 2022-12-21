import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'todo.dart';

class FormPage extends StatefulWidget {

  final Todo todo;
  const FormPage({super.key, required this.todo});

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late bool completed;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    completed = widget.todo.completed;
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Todo editedTodo = Todo(widget.todo.userId, widget.todo.id, title, completed);
      editTodo(editedTodo);
      Navigator.pop(context);
    }
  }

  Future<void> editTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
      body: jsonEncode({
        'title': todo.title,
        'completed': todo.completed,
      }),
    );
    if (response.statusCode == 200) {
      // Todo was successfully edited
    } else {
      throw Exception('Failed to edit todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title:',
                    labelStyle: TextStyle(fontSize: 23),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                initialValue: title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title must not be empty.';
                  }
                  return null;
                },
                onSaved: (value) => title = value!,
              ),
              CheckboxListTile(
                value: completed,
                onChanged: (value) => setState(() => completed = value!),
                title: const Text('Completed'),
              ),
              TextButton(
                onPressed: submitForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
