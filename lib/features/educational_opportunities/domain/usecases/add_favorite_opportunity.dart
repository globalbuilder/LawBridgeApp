import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/educational_opportunities_repository.dart';

class AddFavoriteOpportunity {
  final EducationalOpportunitiesRepository repository;

  AddFavoriteOpportunity(this.repository);

  Future<Either<Failure, void>> execute(int opportunityId) {
    return repository.addFavoriteOpportunity(opportunityId);
  }
}
