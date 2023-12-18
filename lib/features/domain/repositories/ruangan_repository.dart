// features/domain/repositories/ruangan_repository.dart

import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';

abstract class RuanganRepository {
  Future<List<RuanganEntity>> getRekomendasiRuanganData();
  Future<List<RuanganEntity>> getPotensialRuanganData();
  // Add other methods as needed
}
