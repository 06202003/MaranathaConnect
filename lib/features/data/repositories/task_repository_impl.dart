// data/repositories/task_repository_impl.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/task_repository.dart';
import 'package:flutter_firebase/features/data/datasources/task_remote_datasource.dart';
import 'package:flutter_firebase/features/data/models/task_model.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSource();
});

final taskRepositoryImplProvider = Provider<TaskRepositoryImpl>((ref) {
  return TaskRepositoryImpl(
    remoteDataSource: ref.read(remoteDataSourceProvider),
  );
});

class TaskRepositoryImpl implements TaskRepository {
  final RemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TaskEntity>> getTasks() async {
    final List<TaskModel> taskModels = await remoteDataSource.getTasks();
    return taskModels
        .map(
          (model) => TaskEntity(
            id: model.id,
            title: model.title,
            imageUrl: model.imageUrl,
            description: model.description,
            date: model.date,
          ),
        )
        .toList();
  }
}
