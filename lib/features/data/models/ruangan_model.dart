// data/model/ruangan_model.dart

import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';

class RuanganModel {
  final int id;
  final String nama;
  final String imageUrl;
  final int capacity;
  final DateTime date;
  final DateTime initialOrderTime;
  final DateTime endTimeOrder;

  RuanganModel({
    required this.id,
    required this.nama,
    required this.imageUrl,
    required this.capacity,
    required this.date,
    required this.initialOrderTime,
    required this.endTimeOrder,
  });

  // Define a method to convert RuanganModel to RuanganEntity
  RuanganEntity toEntity() {
    return RuanganEntity(
      id: id,
      nama: nama,
      imageUrl: imageUrl,
      capacity: capacity,
      date: date,
      initialOrderTime: initialOrderTime,
      endTimeOrder: endTimeOrder,
    );
  }
}
