// organizational_tasks_widget.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';
import 'package:flutter_firebase/features/domain/usecases/get_tasks_usecase.dart';
import 'package:flutter_firebase/features/domain/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_firebase/features/presentation/widgets/error_retry.dart';
import 'package:flutter_firebase/features/presentation/widgets/task_list_tile.dart';

final getTasksUsecaseProvider = FutureProvider<List<TaskEntity>>((ref) async {
  final taskRepository = ref.read(taskRepositoryProvider);
  final usecase = GetTasksUsecase(taskRepository: taskRepository);

  try {
    return await usecase.execute();
  } catch (e) {
    print('Error fetching tasks: $e');
    throw Exception('Failed to fetch tasks: $e');
  }
});

class OrganizationalTasksWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsyncValue = ref.watch(getTasksUsecaseProvider);

    return tasksAsyncValue.when(
      data: (List<TaskEntity> taskEntities) {
        if (taskEntities.isEmpty) {
          return Center(
            child: Text('No tasks available'),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(getTasksUsecaseProvider);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int index = 0; index < taskEntities.length; index++)
                  Column(
                    children: [
                      TaskListTile(taskEntities[index]),
                      if (index < taskEntities.length - 1) Divider(),
                    ],
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddDialog(context, ref);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Text('Tambah Program Kerja'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return ErrorRetryWidget(
          error: error,
          onRetry: () {
            ref.refresh(getTasksUsecaseProvider);
          },
        );
      },
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();
    DateTime _selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: SingleChildScrollView(
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
                        if (pickedDate != null && pickedDate != _selectedDate) {
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _addTask(
                  context,
                  ref,
                  titleController.text,
                  descriptionController.text,
                  imageUrlController.text,
                  "${_selectedDate.toLocal().day}/${_selectedDate.toLocal().month}/${_selectedDate.toLocal().year}",
                );
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addTask(
    BuildContext context,
    WidgetRef ref,
    String title,
    String description,
    String imageUrl,
    String date,
  ) {
    try {
      // Get a reference to the Firestore collection
      CollectionReference tasksCollection =
          FirebaseFirestore.instance.collection('tasks');

      // Add a new document with a generated ID
      tasksCollection.add({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'date': date,
      }).then((DocumentReference document) {
        print('Task added with ID: ${document.id}');
        ref.refresh(getTasksUsecaseProvider);
      }).catchError((error) {
        print('Error adding task: $error');
        // Handle error
      });

      // Optionally, you can refresh the task list or perform other actions after adding a new task.
      ref.refresh(getTasksUsecaseProvider);
    } catch (e) {
      print('Error adding task: $e');
      // Handle the error as needed
    }
  }
}
