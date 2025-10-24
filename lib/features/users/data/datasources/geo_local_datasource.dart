import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/country_model.dart';
import '../models/state_model.dart';
import '../models/city_model.dart';

abstract class GeoLocalDataSource {
  Future<List<CountryModel>> getCountries();
  Future<List<StateModel>> getStatesByCountry(String countryId);
  Future<List<CityModel>> getCitiesByState(String stateId);
}

class GeoLocalDataSourceImpl implements GeoLocalDataSource {
  List<Map<String, dynamic>>? _cachedData;

  Future<List<Map<String, dynamic>>> _loadGeoData() async {
    if (_cachedData != null) return _cachedData!;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/geo_data.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedData = jsonList.cast<Map<String, dynamic>>();
      return _cachedData!;
    } catch (e) {
      throw Exception('Error loading geo data: $e');
    }
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    final data = await _loadGeoData();
    return data.map((country) => CountryModel.fromJson(country)).toList();
  }

  @override
  Future<List<StateModel>> getStatesByCountry(String countryId) async {
    final data = await _loadGeoData();
    final country = data.firstWhere(
      (country) => country['iso2'] == countryId,
      orElse: () => throw Exception('Country not found'),
    );

    final states = country['states'] as List<dynamic>? ?? [];
    return states
        .map((state) => StateModel.fromJson(state, countryId))
        .toList();
  }

  @override
  Future<List<CityModel>> getCitiesByState(String stateId) async {
    final data = await _loadGeoData();

    for (final country in data) {
      final states = country['states'] as List<dynamic>? ?? [];
      for (final state in states) {
        final stateModel = StateModel.fromJson(state, country['iso2']);
        if (stateModel.id == stateId) {
          final cities = state['cities'] as List<dynamic>? ?? [];
          return cities
              .map((city) => CityModel.fromJson(city, stateId))
              .toList();
        }
      }
    }

    throw Exception('State not found');
  }
}
