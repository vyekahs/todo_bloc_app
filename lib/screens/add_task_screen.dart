import 'package:flutter/material.dart';
import 'package:todo_bloc_app/models/task.dart';
import 'package:todo_bloc_app/services/guid_gen.dart';
import '../blocs/bloc_exports.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController discriptonController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const Text(
            'add Task',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: TextField(
              autofocus: true,
              controller: discriptonController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text('discription'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('canel')),
              ElevatedButton(
                  onPressed: () {
                    Task task = Task(
                      title: titleController.text,
                      id: GUIDGen.generate(),
                      date: DateTime.now().toString(),
                      discrption: discriptonController.text,
                    );
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          )
        ],
      ),
    );
  }
}
