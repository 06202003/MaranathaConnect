// domain/entities/ruangan_entity.dart
import 'package:flutter_firebase/features/data/models/ruangan_model.dart';

class RuanganEntity {
  final int id;
  final String nama;
  final String imageUrl;
  final int capacity;
  final DateTime date;
  final DateTime initialOrderTime;
  final DateTime endTimeOrder;

  DateTime reservationDate;
  DateTime reservationStartTime;
  DateTime reservationEndTime;

  RuanganEntity({
    required this.id,
    required this.nama,
    required this.imageUrl,
    required this.capacity,
    required this.date,
    required this.initialOrderTime,
    required this.endTimeOrder,
  })  : reservationDate = DateTime.now(),
        reservationStartTime = DateTime.now(),
        reservationEndTime = DateTime.now().add(Duration(hours: 2));

  // Konversi dari model ke entity
  factory RuanganEntity.fromModel(RuanganModel model) {
    return RuanganEntity(
      id: model.id,
      nama: model.nama,
      imageUrl: model.imageUrl,
      capacity: model.capacity,
      date: model.date,
      initialOrderTime: model.initialOrderTime,
      endTimeOrder: model.endTimeOrder,
    );
  }
}
