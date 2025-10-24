import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/state_entity.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/geo_repository.dart';
import '../datasources/geo_local_datasource.dart';

class GeoRepositoryImpl implements GeoRepository {
  final GeoLocalDataSource localDataSource;

  GeoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    try {
      final countries = await localDataSource.getCountries();
      return Right(countries.map((model) => model.toDomain()).toList());
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StateEntity>>> getStatesByCountry(
    String countryId,
  ) async {
    try {
      final states = await localDataSource.getStatesByCountry(countryId);
      return Right(states.map((model) => model.toDomain()).toList());
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCitiesByState(
    String stateId,
  ) async {
    try {
      final cities = await localDataSource.getCitiesByState(stateId);
      return Right(cities.map((model) => model.toDomain()).toList());
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
