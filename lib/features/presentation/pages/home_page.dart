import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/repositories/task_repository.dart';
import 'package:flutter_firebase/features/presentation/widgets/organizational_tasks_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_firebase/features/domain/entities/task_entity.dart';
import 'package:flutter_firebase/features/domain/usecases/get_tasks_usecase.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/bottom_navigation.dart';

final getTasksUsecaseProvider = FutureProvider<List<TaskEntity>>((ref) async {
  final taskRepository = ref.read(taskRepositoryProvider);
  try {
    final usecase = GetTasksUsecase(taskRepository: taskRepository);
    return await usecase.execute();
  } catch (e) {
    print('Error fetching tasks: $e');
    throw Exception('Failed to fetch tasks: $e');
  }
});

class HomePage extends ConsumerWidget {
  void _navigateToPage(BuildContext context, int index) {
    // Handle navigation here if needed
    switch (index) {
      case 0:
        navigationService.navigateToPage('/home');
        break;
      case 1:
        navigationService.navigateToPage('/room');
        break;
      case 2:
        navigationService.navigateToPage('/chat');
        break;
      case 3:
        navigationService.navigateToPage('/profile');
        break;
    }
  }

  final NavigationService navigationService;

  HomePage({Key? key, required this.navigationService}) : super(key: key);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome Home!"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white, // Set the background color to white
            child: Center(
              child: Text(
                "Program Kerja SEMAFIT 2023/2024",
                style: TextStyle(
                  color: Colors.black, // Set the text color
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          CarouselSlider(
            items: [
              // Replace the containers with images wrapped in a ClipRRect for rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('assets/1.png', height: 150),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('assets/2.png', height: 150),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('assets/3.png', height: 150),
              ),
            ],
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(height: 16.0),
          // Add the OrganizationalTasksWidget below the carousel
          OrganizationalTasksWidget(),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        navigationService: navigationService,
        currentIndex: 0,
        onTap: (index) {
          _navigateToPage(context, index);
        },
      ),
    );
  }
}
