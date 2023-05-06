import 'package:flutter/material.dart';
import 'package:todo_bloc_app/screens/edit_task_screen.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu(
      {super.key,
      required this.cancelOrDeleteCallback,
      required this.likeOrdislikeCallback,
      required this.editTaskCallback,
      required this.restoreTaskCallback,
      required this.task});
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrdislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: ((context) => (task.isDeleted! == false
          ? pendingPopup(task, cancelOrDeleteCallback)
          : recyclePopup(task, cancelOrDeleteCallback))),
    );
  }

  List<PopupMenuEntry> pendingPopup(
      Task task, VoidCallback cancelOrDeleteCallback) {
    return [
      PopupMenuItem(
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            editTaskCallback();
          });
        },
        child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.edit),
            label: const Text('edit')),
      ),
      PopupMenuItem(
        onTap: likeOrdislikeCallback,
        child: TextButton.icon(
            onPressed: null,
            icon: task.isFavorite!
                ? const Icon(Icons.bookmark_remove)
                : const Icon(Icons.bookmark_add_outlined),
            label: task.isFavorite!
                ? const Text('remove from \nfavorite')
                : const Text('add to \nfavorite')),
      ),
      PopupMenuItem(
        onTap: cancelOrDeleteCallback,
        child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.delete),
            label: const Text('delete')),
      ),
    ];
  }

  List<PopupMenuEntry> recyclePopup(
      Task task, VoidCallback cancelOrDeleteCallback) {
    return [
      PopupMenuItem(
        child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.restore_from_trash),
            label: const Text('restore')),
        onTap: restoreTaskCallback,
      ),
      PopupMenuItem(
        onTap: cancelOrDeleteCallback,
        child: TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.delete_forever),
            label: const Text('delete forever')),
      ),
    ];
  }
}
