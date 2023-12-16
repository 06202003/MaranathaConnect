import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/features/data/models/task_model.dart';

class RemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TaskModel>> getTasks() async {
    try {
      // Replace this with the actual path to your Firestore collection
      // For example, if your collection is named 'tasks', use 'tasks'
      CollectionReference tasksCollection = _firestore.collection('tasks');

      // Fetch data from Firestore
      QuerySnapshot<Object?> querySnapshot = await tasksCollection.get();

      // Process the data and convert it into TaskModel objects
      List<TaskModel> tasks = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return TaskModel(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          description: data['description'] ?? '',
          date: data['date'] ?? '',
        );
      }).toList();

      return tasks;
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching tasks from Firestore: $e');
      throw Exception('Failed to fetch tasks from Firestore: $e');
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      CollectionReference tasksCollection = _firestore.collection('tasks');
      await tasksCollection.add({
        'id': task.id,
        'title': task.title,
        'imageUrl': task.imageUrl,
        'description': task.description,
        'date': task.date,
      });
    } catch (e) {
      print('Error adding task to Firestore: $e');
      throw Exception('Failed to add task to Firestore: $e');
    }
  }

  Future<void> updateTask(int taskId, TaskModel updatedTask) async {
    try {
      CollectionReference tasksCollection = _firestore.collection('tasks');
      await tasksCollection.doc(taskId.toString()).update({
        'id': updatedTask.id,
        'title': updatedTask.title,
        'imageUrl': updatedTask.imageUrl,
        'description': updatedTask.description,
        'date': updatedTask.date,
      });
    } catch (e) {
      print('Error updating task in Firestore: $e');
      throw Exception('Failed to update task in Firestore: $e');
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      CollectionReference tasksCollection = _firestore.collection('tasks');
      await tasksCollection.doc(taskId.toString()).delete();
    } catch (e) {
      print('Error deleting task from Firestore: $e');
      throw Exception('Failed to delete task from Firestore: $e');
    }
  }
}
