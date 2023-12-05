import 'package:flutter_firebase/features/data/models/task_model.dart';

class RemoteDataSource {
  Future<List<TaskModel>> getTasks() async {
    // Simulate fetching tasks from a remote source
    await Future.delayed(Duration(seconds: 2));
    return [
      TaskModel(
          title: 'Natal IT',
          imageUrl: 'https://picsum.photos/id/237/200/300',
          description: 'lorem ipsum',
          date: '25 Desember 2023'),
      TaskModel(
        title: 'POR IT',
        imageUrl: 'https://picsum.photos/id/237/200/300',
        description:
            'Pekan Olah Raga IT merupakan acara rutin dari SEMAFIT yang menjadi ajang kompetisi di bidang non akademik',
        date: '4 Desember 2023',
      ),
    ];
  }
}
