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
                    width: 150,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
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
            : Text('No potential rooms available.'),
      ),
    );
  }
}
