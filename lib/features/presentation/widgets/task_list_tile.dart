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
        _showDescriptionModal(
            context,
            task.title ?? "No Title available",
            task.description ?? 'No description available',
            task.imageUrl ?? "No Image available");
      },
    );
  }

  // Function to show the description modal
  void _showDescriptionModal(
      BuildContext context, String title, String description, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.7, // Set modal width (adjust as needed)
            child: Column(
              children: [
                // Add an image with rounded corners and 16:9 aspect ratio
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        10), // Add some space between the image and description
                Text(description),
              ],
            ),
          ),
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
