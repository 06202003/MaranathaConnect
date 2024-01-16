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
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this line to import the URL launcher package

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

  List<RuanganEntity> reservedRooms = []; // List to store reserved rooms

  @override
  void initState() {
    super.initState();
    final ruanganRepository = RuanganRepositoryImpl(
      ruanganDatasource: RuanganDatasource(),
    );
    getRekomendasiRuanganUsecase =
        GetRekomendasiRuanganUsecase(ruanganRepository);
    getPotensialRuanganUsecase = GetPotensialRuanganUsecase(ruanganRepository);

    // Fetch and set the initial reserved rooms data
    fetchReservedRooms();
  }

  Future<void> fetchReservedRooms() async {
    final ruanganData = await RuanganDatasource().getRuanganData();
    // Select Ruangan A and Ruangan C from the list
    final reservedRoomNames = ['Internet 2', 'Theatre GAP'];
    reservedRooms = ruanganData
        .where((ruangan) => reservedRoomNames.contains(ruangan.nama))
        .map((model) => model.toEntity())
        .toList();

    setState(() {});
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
        widget.navigationService.navigateToPage('/doc');
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
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () {
        //       _scaffoldKey.currentState!.openEndDrawer();
        //     },
        //   ),
        // ],
      ),
      // endDrawer: Drawer(
      //   child: AppNavigation(),
      // ),
      body: FutureBuilder<List<RuanganEntity>>(
        future: getPotensialRuanganUsecase.execute(),
        builder: (context, potentialSnapshot) {
          return FutureBuilder<List<RuanganEntity>>(
            future: getRekomendasiRuanganUsecase.execute(),
            builder: (context, recommendedSnapshot) {
              if (potentialSnapshot.connectionState ==
                      ConnectionState.waiting ||
                  recommendedSnapshot.connectionState ==
                      ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (potentialSnapshot.hasError ||
                  recommendedSnapshot.hasError) {
                return Center(
                    child: Text(
                        'Error: ${potentialSnapshot.error ?? recommendedSnapshot.error}'));
              } else {
                final potentialRooms = potentialSnapshot.data!;
                final recommendedRooms = recommendedSnapshot.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Rekomendasi Ruangan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RekomendasiRuanganCarousel(
                        recommendedRooms: recommendedRooms),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Ruangan yang sering dipinjam',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PotensialRuanganList(potentialRooms: potentialRooms),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Open the reservation form and wait for result
                          final reservedRoom = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationForm(),
                            ),
                          );

                          // If the user submitted the form, add the reserved room to the list
                          if (reservedRoom != null) {
                            setState(() {
                              reservedRooms.add(reservedRoom);
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(16)),
                        ),
                        child: Text(
                          'Pinjam Ruangan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Display the list of reserved rooms if there are any
                    if (reservedRooms.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: reservedRooms.length,
                          itemBuilder: (context, index) {
                            final ruangan = reservedRooms[index];
                            // Format the date and time
                            final formattedDate = DateFormat('dd-MM-yyyy HH:mm')
                                .format(ruangan.reservationDate);
                            final formattedStartTime = DateFormat('HH:mm')
                                .format(ruangan.reservationStartTime);
                            final formattedEndTime = DateFormat('HH:mm')
                                .format(ruangan.reservationEndTime);

                            return ListTile(
                              title:
                                  Text('Ruangan yang Dipesan: ${ruangan.nama}'),
                              // You can customize the display of reserved rooms as needed
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tanggal Reservasi: $formattedDate'),
                                  Text(
                                      'Waktu Reservasi: $formattedStartTime - $formattedEndTime'),
                                  // Add any additional details you want to display
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    else
                      // Show a message if there are no reserved rooms
                      Text('Belum ada ruangan yang dipinjam'),
                  ],
                );
              }
            },
          );
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
