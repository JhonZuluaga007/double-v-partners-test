import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/country_entity.dart';
import '../entities/state_entity.dart';
import '../entities/city_entity.dart';

abstract class GeoRepository {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
  Future<Either<Failure, List<StateEntity>>> getStatesByCountry(
    String countryId,
  );
  Future<Either<Failure, List<CityEntity>>> getCitiesByState(String stateId);
}
