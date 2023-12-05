// task_list_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';

class TaskListTile extends StatelessWidget {
  final TaskEntity task;

  TaskListTile(this.task);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(task.imageUrl),
      ),
      title: Text(task.title),
      subtitle: Text(
        task.date ?? 'No date available',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        _showDescriptionModal(context, task.title ?? "No Title available",
            task.description ?? 'No description available');
      },
    );
  }

  // Function to show the description modal
  void _showDescriptionModal(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
