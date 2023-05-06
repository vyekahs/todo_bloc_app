import 'package:flutter/material.dart';
import '/models/task.dart';
import '../blocs/bloc_exports.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController discriptonController =
        TextEditingController(text: oldTask.discrption);

    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const Text(
            'edit Task',
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
                    Task editTask = Task(
                      title: titleController.text,
                      id: oldTask.id,
                      date: oldTask.date,
                      isFavorite: oldTask.isFavorite,
                      isDeleted: oldTask.isDeleted,
                      isDone: oldTask.isDone,
                      discrption: discriptonController.text,
                    );
                    context
                        .read<TasksBloc>()
                        .add(EditTask(oldTask: oldTask, newTask: editTask));
                    Navigator.pop(context);
                  },
                  child: const Text('edit')),
            ],
          )
        ],
      ),
    );
  }
}
