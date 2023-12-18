// data/datasource/ruangan_datasource.dart
import 'package:flutter_firebase/features/data/models/ruangan_model.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';

class RuanganDatasource {
  Future<List<RuanganModel>> getRuanganData() async {
    // Example implementation with dummy data
    return [
      RuanganModel(
        id: 1,
        nama: 'Ruangan A',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1185629278763761715/IMG_2052.JPG?ex=65904e4f&is=657dd94f&hm=28cad6b9e82ee3e4feca6c0668718f36eddb5bedb94d456ec34c97f24f40db28&',
        capacity: 50,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 8)),
        endTimeOrder: DateTime.now().add(Duration(hours: 18)),
      ),
      RuanganModel(
        id: 2,
        nama: 'Ruangan B',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1185629278763761715/IMG_2052.JPG?ex=65904e4f&is=657dd94f&hm=28cad6b9e82ee3e4feca6c0668718f36eddb5bedb94d456ec34c97f24f40db28&',
        capacity: 30,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 9)),
        endTimeOrder: DateTime.now().add(Duration(hours: 17)),
      ),
      RuanganModel(
        id: 3,
        nama: 'Ruangan C',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1185629278763761715/IMG_2052.JPG?ex=65904e4f&is=657dd94f&hm=28cad6b9e82ee3e4feca6c0668718f36eddb5bedb94d456ec34c97f24f40db28&',
        capacity: 20,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 10)),
        endTimeOrder: DateTime.now().add(Duration(hours: 16)),
      ),
    ];
  }

  Future<List<RuanganEntity>> getRekomendasiRuanganData() async {
    // Replace this with your actual implementation for recommended rooms
    // For now, let's return the first two rooms as recommended
    final ruanganData = await getRuanganData();
    return ruanganData.sublist(0, 3).map((model) => model.toEntity()).toList();
  }

  Future<List<RuanganEntity>> getPotensialRuanganData() async {
    // Replace this with your actual implementation for potential rooms
    // For now, let's return the last room as potential
    final ruanganData = await getRuanganData();
    return ruanganData.sublist(2).map((model) => model.toEntity()).toList();
  }
}
