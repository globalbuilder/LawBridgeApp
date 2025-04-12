import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/opportunity_entity.dart';
import '../repositories/educational_opportunities_repository.dart';

class GetOpportunities {
  final EducationalOpportunitiesRepository repository;

  GetOpportunities(this.repository);

  /// If [search] is provided, the repository might append it as a query param.
  Future<Either<Failure, List<OpportunityEntity>>> execute({String? search}) {
    return repository.getOpportunities(search: search);
  }
}
