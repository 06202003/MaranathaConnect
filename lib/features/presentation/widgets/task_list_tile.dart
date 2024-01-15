// task_list_tile.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';

class TaskListTile extends StatelessWidget {
  final TaskEntity task;

  TaskListTile(this.task);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dismissible(
        key: Key(task.id ?? ''), // Use a unique key for each Dismissible
        background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _showUpdateDialog(context, task);
          } else if (direction == DismissDirection.startToEnd) {
            _confirmDelete(context, task);
          }
        },
        child: Container(
            color: Color.fromARGB(255, 235, 247, 255), // Set background color here
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(task.imageUrl),
            ),
            title: Text(task.title),
            subtitle: Text(
              task.date ?? 'No date available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              _showDescriptionModal(context, task);
            },
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, TaskEntity task) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();
    DateTime _selectedDate = DateTime.now();

    // Set initial values in the text fields
    titleController.text = task.title ?? '';
    descriptionController.text = task.description ?? '';
    imageUrlController.text = task.imageUrl ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: SingleChildScrollView(
            child: IntrinsicWidth(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: imageUrlController,
                    decoration: InputDecoration(labelText: 'Image URL'),
                  ),
                  Row(
                    children: [
                      Text("Tanggal Pelaksanaan"),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            _selectedDate = pickedDate;
                          }
                        },
                      ),
                      Text(
                        "${_selectedDate.toLocal().day}/${_selectedDate.toLocal().month}/${_selectedDate.toLocal().year}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _updateTask(
                  context,
                  task,
                  titleController.text,
                  descriptionController.text,
                  imageUrlController.text,
                  "${_selectedDate.toLocal().day}/${_selectedDate.toLocal().month}/${_selectedDate.toLocal().year}",
                );
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, TaskEntity task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteTask(context, task);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(BuildContext context, TaskEntity task) {
    try {
      if (task.id != null && task.id.isNotEmpty) {
        CollectionReference tasksCollection =
            FirebaseFirestore.instance.collection('tasks');
        DocumentReference documentReference = tasksCollection.doc(task.id);
        documentReference.delete().then((_) {
          print('Task deleted with ID: ${task.id}');
        }).catchError((error) {
          print('Error deleting task: $error');
        });
      } else {
        print('Error deleting task: Invalid task ID');
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  void _showDescriptionModal(BuildContext context, TaskEntity task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(task.title ?? "No Title available"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: NetworkImage(task.imageUrl ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      task.title ?? 'No title available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20, // Adjust the font size as needed
                        fontWeight: FontWeight
                            .bold, // You can adjust the font weight as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    task.description ?? 'No description available',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _updateTask(
    BuildContext context,
    TaskEntity task,
    String title,
    String description,
    String imageUrl,
    String date,
  ) {
    try {
      if (task.id != null && task.id.isNotEmpty) {
        CollectionReference tasksCollection =
            FirebaseFirestore.instance.collection('tasks');
        DocumentReference documentReference = tasksCollection.doc(task.id);
        documentReference.update({
          'title': title,
          'description': description,
          'imageUrl': imageUrl,
          'date': date,
        }).then((_) {
          print('Task updated with ID: ${task.id}');
        }).catchError((error) {
          print('Error updating task: $error');
        });
      } else {
        print('Error updating task: Invalid task ID');
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  void _performDelete(BuildContext context, TaskEntity task) {
    try {
      CollectionReference tasksCollection =
          FirebaseFirestore.instance.collection('tasks');
      DocumentReference documentReference = tasksCollection.doc(task.id);
      documentReference.delete().then((_) {
        print('Task deleted with ID: ${task.id}');
      }).catchError((error) {
        print('Error deleting task: $error');
      });
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
