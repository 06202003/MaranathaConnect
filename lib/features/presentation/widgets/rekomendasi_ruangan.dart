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
            ? Container(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedRooms.length,
                  itemBuilder: (context, index) {
                    RuanganEntity room = recommendedRooms[index];
                    return Container(
                      width: 275,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              room.imageUrl,
                              height: 150,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            room.nama,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Capacity: ${room.capacity}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Center(child: Text('No recommended rooms available.')),
      ),
    );
  }
}
