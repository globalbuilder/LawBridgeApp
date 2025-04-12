// lib/features/legal_resources/domain/usecases/get_resources.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/legal_resource_entity.dart';
import '../repositories/legal_resources_repository.dart';

class GetResources {
  final LegalResourcesRepository repository;
  GetResources(this.repository);

  Future<Either<Failure, List<LegalResourceEntity>>> execute({String? search}) {
    return repository.getResources(search: search);
  }
}
