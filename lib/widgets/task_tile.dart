import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc_app/screens/edit_task_screen.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;
  void _removeOrDeleteTask(BuildContext context) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    print(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: false,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(oldTask: task),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: task.isFavorite == true
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline)),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      task.title,
                      style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null),
                    ),
                    Text(
                      DateFormat('y-MM-dd hh:mm:ss')
                          .format(DateTime.parse(task.date))
                          .toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    )
                  ]),
            ),
          ]),
        ),
        Row(children: [
          Checkbox(
            value: task.isDone,
            onChanged: task.isDeleted == false
                ? (value) {
                    context.read<TasksBloc>().add(UpdateTask(task: task));
                  }
                : null,
          ),
          PopupMenu(
            task: task,
            likeOrdislikeCallback: () => context
                .read<TasksBloc>()
                .add(MarkFavoriteOrUnFavoriteTask(task: task)),
            cancelOrDeleteCallback: () => _removeOrDeleteTask(context),
            restoreTaskCallback: () =>
                context.read<TasksBloc>().add(RestoreTask(task: task)),
            editTaskCallback: () {
              // Navigator.of(context).pop();
              _editTask(context);
            },
          ),
        ]),
      ],
    );
  }
}




// ListTile(
//       title: Text(
//         overflow: TextOverflow.ellipsis,
//         task.title,
//         style: TextStyle(
//             decoration: task.isDone! ? TextDecoration.lineThrough : null),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false
//             ? (value) {
//                 context.read<TasksBloc>().add(UpdateTask(task: task));
//               }
//             : null,
//       ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     );