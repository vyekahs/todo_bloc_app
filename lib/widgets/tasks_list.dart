import 'package:flutter/material.dart';
import 'package:todo_bloc_app/models/task.dart';

import 'task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map((task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: ListTile(
                      title: SelectableText.rich(TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Text\n ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: task.title),
                          const TextSpan(
                            text: '\n\nDiscription\n ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: task.discrption),
                        ],
                      )),
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
//  Expanded(
//             child: ListView.builder(
//                 itemCount: tasksList.length,
//                 itemBuilder: (context, index) {
//                   Task task = tasksList[index];
//                   return TaskTile(task: task);
//                 },)
//                 ),