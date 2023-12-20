import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/task_repository.dart';

final getTasksUsecaseProvider = FutureProvider<List<TaskEntity>>((ref) async {
  try {
    final taskRepository = ref.read(
        taskRepositoryProvider); // Make sure this is your actual repository provider
    final usecase = GetTasksUsecase(taskRepository: taskRepository);
    return await usecase.execute();
  } catch (e) {
    print('Error fetching tasks: $e');
    throw Exception('Failed to fetch tasks: $e');
  }
});

class GetTasksUsecase {
  final TaskRepository taskRepository;

  GetTasksUsecase({required this.taskRepository});

  Future<List<TaskEntity>> execute() async {
    try {
      final List<TaskEntity> taskEntities = await taskRepository.getTasks();
      return taskEntities;
    } catch (e) {
      print('Error fetching tasks: $e');
      throw Exception('Failed to fetch tasks: $e');
    }
  }
}
