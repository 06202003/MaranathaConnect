// domain/usecases/get_potensial_ruangan_usecase.dart

import 'package:flutter_firebase/features/domain/entities/ruangan_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/ruangan_repository.dart';

class GetPotensialRuanganUsecase {
  final RuanganRepository repository;

  GetPotensialRuanganUsecase(this.repository);

  Future<List<RuanganEntity>> execute() async {
    return await repository.getPotensialRuanganData();
  }
}
