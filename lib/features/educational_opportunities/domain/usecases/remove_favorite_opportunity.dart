import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/educational_opportunities_repository.dart';

class RemoveFavoriteOpportunity {
  final EducationalOpportunitiesRepository repository;

  RemoveFavoriteOpportunity(this.repository);

  Future<Either<Failure, void>> execute(int opportunityId) {
    return repository.removeFavoriteOpportunity(opportunityId);
  }
}
