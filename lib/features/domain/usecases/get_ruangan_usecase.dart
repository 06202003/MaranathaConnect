// domain/usecases/get_rekomendasi_ruangan_usecase.dart

import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/ruangan_repository.dart';

class GetRekomendasiRuanganUsecase {
  final RuanganRepository repository;

  GetRekomendasiRuanganUsecase(this.repository);

  Future<List<RuanganEntity>> execute() async {
    return await repository.getRekomendasiRuanganData();
  }
}
