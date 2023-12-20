import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';

class PotensialRuanganList extends StatelessWidget {
  final List<RuanganEntity> potentialRooms;

  PotensialRuanganList({required this.potentialRooms});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200,
        child: potentialRooms.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: potentialRooms.length,
                itemBuilder: (context, index) {
                  RuanganEntity room = potentialRooms[index];
                  return Container(
                    width: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            room.imageUrl,
                            height: 150,
                            width: 150,
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
              )
            : Text('No potential rooms available.'),
      ),
    );
  }
}
