import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/favorite_opportunity_entity.dart';
import '../repositories/educational_opportunities_repository.dart';

class GetFavoriteOpportunities {
  final EducationalOpportunitiesRepository repository;

  GetFavoriteOpportunities(this.repository);

  Future<Either<Failure, List<FavoriteOpportunityEntity>>> execute() {
    return repository.getFavoriteOpportunities();
  }
}
