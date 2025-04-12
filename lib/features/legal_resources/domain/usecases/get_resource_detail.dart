// lib/features/legal_resources/domain/usecases/get_resource_detail.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/legal_resource_entity.dart';
import '../repositories/legal_resources_repository.dart';

class GetResourceDetail {
  final LegalResourcesRepository repository;
  GetResourceDetail(this.repository);

  Future<Either<Failure, LegalResourceEntity>> execute(int id) {
    return repository.getResourceDetail(id);
  }
}
