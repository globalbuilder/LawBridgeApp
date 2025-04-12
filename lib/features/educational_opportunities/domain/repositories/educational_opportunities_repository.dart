import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/opportunity_entity.dart';
import '../entities/favorite_opportunity_entity.dart';

abstract class EducationalOpportunitiesRepository {

  Future<Either<Failure, List<OpportunityEntity>>> getOpportunities({String? search});

  Future<Either<Failure, OpportunityEntity>> getOpportunityDetail(int id);

  Future<Either<Failure, List<FavoriteOpportunityEntity>>> getFavoriteOpportunities();

  Future<Either<Failure, void>> addFavoriteOpportunity(int opportunityId);

  Future<Either<Failure, void>> removeFavoriteOpportunity(int opportunityId);
}
