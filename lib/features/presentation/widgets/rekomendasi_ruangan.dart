import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';

class RekomendasiRuanganCarousel extends StatelessWidget {
  final List<RuanganEntity> recommendedRooms;

  RekomendasiRuanganCarousel({required this.recommendedRooms});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 200,
        child: recommendedRooms.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedRooms.length,
                itemBuilder: (context, index) {
                  RuanganEntity room = recommendedRooms[index];
                  return Container(
                    width: 150,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(room.nama, style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Image.network(
                          room.imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
              )
            : Text('No recommended rooms available.'),
      ),
    );
  }
}
