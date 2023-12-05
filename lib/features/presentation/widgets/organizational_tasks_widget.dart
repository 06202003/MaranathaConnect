// organizational_tasks_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/repositories/task_repository.dart';
import 'package:flutter_firebase/features/presentation/widgets/error_retry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';
import 'package:flutter_firebase/features/domain/usecases/get_tasks_usecase.dart';
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
}
