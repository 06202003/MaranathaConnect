// features/data/repositories/ruangan_repository_impl.dart

import 'package:flutter_firebase/features/data/datasources/ruangan_remote_datasource.dart';
import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/ruangan_repository.dart';

class RuanganRepositoryImpl implements RuanganRepository {
  final RuanganDatasource ruanganDatasource;

  RuanganRepositoryImpl({required this.ruanganDatasource});

  @override
  Future<List<RuanganEntity>> getRekomendasiRuanganData() async {
    return ruanganDatasource.getRekomendasiRuanganData();
  }

  @override
  Future<List<RuanganEntity>> getPotensialRuanganData() async {
    return ruanganDatasource.getPotensialRuanganData();
  }
  // Implement other methods
}
