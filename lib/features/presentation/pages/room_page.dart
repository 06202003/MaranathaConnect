import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/data/datasources/ruangan_remote_datasource.dart';
import 'package:flutter_firebase/features/data/repositories/ruangan_repository_impl.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';
import 'package:flutter_firebase/features/domain/usecases/get_potential_ruangan_usecase.dart';
import 'package:flutter_firebase/features/domain/usecases/get_ruangan_usecase.dart';
import 'package:flutter_firebase/features/presentation/widgets/app_navigation.dart';
import 'package:flutter_firebase/features/presentation/widgets/bottom_navigation.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/potential_ruangan.dart';
import 'package:flutter_firebase/features/presentation/widgets/rekomendasi_ruangan.dart';
import 'package:flutter_firebase/features/presentation/widgets/reservasi_ruangan.dart';

class PinjamRuanganPage extends StatefulWidget {
  final NavigationService navigationService;

  PinjamRuanganPage({Key? key, required this.navigationService})
      : super(key: key);

  @override
  _PinjamRuanganPageState createState() => _PinjamRuanganPageState();
}

class _PinjamRuanganPageState extends State<PinjamRuanganPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  late final GetRekomendasiRuanganUsecase getRekomendasiRuanganUsecase;
  late final GetPotensialRuanganUsecase getPotensialRuanganUsecase;

  @override
  void initState() {
    super.initState();
    final ruanganRepository = RuanganRepositoryImpl(
      ruanganDatasource: RuanganDatasource(),
    );
    getRekomendasiRuanganUsecase =
        GetRekomendasiRuanganUsecase(ruanganRepository);
    getPotensialRuanganUsecase = GetPotensialRuanganUsecase(ruanganRepository);
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        // This is the current page, you might not need to navigate anywhere.
        break;
      case 2:
        widget.navigationService.navigateToPage('/chat');
        break;
      case 3:
        widget.navigationService.navigateToPage('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Room Reservation"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: AppNavigation(),
      ),
      body: FutureBuilder<List<RuanganEntity>>(
        future: getRekomendasiRuanganUsecase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recommended rooms available.'));
          } else {
            final recommendedRooms = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rekomendasi Ruangan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                RekomendasiRuanganCarousel(recommendedRooms: recommendedRooms),
                Text(
                  'Ruangan yang sering dipinjam',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                PotensialRuanganList(potentialRooms: recommendedRooms),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationForm(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text('Pinjam Ruangan'),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        navigationService: widget.navigationService,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          navigateToPage(index);
        },
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerMenuItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
