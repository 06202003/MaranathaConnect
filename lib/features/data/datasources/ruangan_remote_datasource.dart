// data/datasource/ruangan_datasource.dart
import 'package:flutter_firebase/features/data/models/ruangan_model.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';
import 'dart:math';

class RuanganDatasource {
  Future<List<RuanganModel>> getRuanganData() async {
    // Example implementation with dummy data
    return [
      RuanganModel(
        id: 1,
        nama: 'Internet 2',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1196633168279781436/Lab-Internet-2-150x150.png?ex=65b8567b&is=65a5e17b&hm=ada10de651012a74ac093b40cc43367bf71a7367360f23b19524e29bf21679c1&',
        capacity: 50,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 8)),
        endTimeOrder: DateTime.now().add(Duration(hours: 18)),
      ),
      RuanganModel(
        id: 2,
        nama: 'Internet 1',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 30,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 9)),
        endTimeOrder: DateTime.now().add(Duration(hours: 17)),
      ),
      RuanganModel(
        id: 3,
        nama: 'Theatre GAP',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1185629278763761715/IMG_2052.JPG?ex=65904e4f&is=657dd94f&hm=28cad6b9e82ee3e4feca6c0668718f36eddb5bedb94d456ec34c97f24f40db28&',
        capacity: 150,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 10)),
        endTimeOrder: DateTime.now().add(Duration(hours: 16)),
      ),
      RuanganModel(
        id: 4,
        nama: 'Auditorium',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1196635872548892813/beranda_fasilitas-2.png?ex=65b85900&is=65a5e400&hm=e8af1045eba3cb7d64989166efb72e43b5fde709a34ee73ee031ad3e26b4220a&',
        capacity: 1500,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 12)),
        endTimeOrder: DateTime.now().add(Duration(hours: 20)),
      ),
      RuanganModel(
        id: 5,
        nama: 'Advance Programming 1',
        imageUrl:
            'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 40,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 11)),
        endTimeOrder: DateTime.now().add(Duration(hours: 15)),
      ),
      RuanganModel(
        id: 6,
        nama: 'Advance Programming 2',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 35,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 10)),
        endTimeOrder: DateTime.now().add(Duration(hours: 16)),
      ),
      RuanganModel(
        id: 7,
        nama: 'Advance Programming 3',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 45,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 9)),
        endTimeOrder: DateTime.now().add(Duration(hours: 17)),
      ),
      RuanganModel(
        id: 8,
        nama: 'Advance Programming 4',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 30,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 8)),
        endTimeOrder: DateTime.now().add(Duration(hours: 18)),
      ),
      RuanganModel(
        id: 9,
        nama: 'Programming 1',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 25,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 13)),
        endTimeOrder: DateTime.now().add(Duration(hours: 19)),
      ),
      RuanganModel(
        id: 10,
        nama: 'Programming 2',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 20,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 14)),
        endTimeOrder: DateTime.now().add(Duration(hours: 20)),
      ),
      RuanganModel(
        id: 11,
        nama: 'Network',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 30,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 12)),
        endTimeOrder: DateTime.now().add(Duration(hours: 18)),
      ),
      RuanganModel(
        id: 12,
        nama: 'Enterprise 1',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 35,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 11)),
        endTimeOrder: DateTime.now().add(Duration(hours: 17)),
      ),
      RuanganModel(
        id: 13,
        nama: 'Enterprise 2',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 25,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 10)),
        endTimeOrder: DateTime.now().add(Duration(hours: 16)),
      ),
      RuanganModel(
        id: 14,
        nama: 'Multimedia',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 40,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 9)),
        endTimeOrder: DateTime.now().add(Duration(hours: 15)),
      ),
      RuanganModel(
        id: 15,
        nama: 'Database',
        imageUrl: 'https://cdn.discordapp.com/attachments/973824336655958018/1196633168019718144/MG_8029_30_31-300x200.png?ex=65b8567b&is=65a5e17b&hm=75f6319a31d1f9654f67a46e97914510d1777e2c24a3a94f76f8a93df18132e5&',
        capacity: 20,
        date: DateTime.now(),
        initialOrderTime: DateTime.now().add(Duration(hours: 8)),
        endTimeOrder: DateTime.now().add(Duration(hours: 14)),
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
