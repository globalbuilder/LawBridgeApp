import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/opportunity_entity.dart';
import '../repositories/educational_opportunities_repository.dart';

class GetOpportunityDetail {
  final EducationalOpportunitiesRepository repository;

  GetOpportunityDetail(this.repository);

  Future<Either<Failure, OpportunityEntity>> execute(int id) {
    return repository.getOpportunityDetail(id);
  }
}
