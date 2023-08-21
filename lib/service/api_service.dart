import 'dart:convert';
import 'dart:developer';

import 'package:exercise_expert/model/error.dart';
import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/service/secure_storage.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:http/http.dart' as http;

_ApiService apiService = _ApiService.instance;

class _ApiService {
  _ApiService._();

  static final _ApiService instance = _ApiService._();
  static const int cacheDurationInHours = 2;

  final String _defaultApiKey =
      '1ea06f8614msha5bef9fb1be0e48p13d376jsn86030025662e';

  get _baseUri => 'https://exercisedb.p.rapidapi.com';

  Future<String> get _getApiKey async {
    String apiKey = await secureStorage.get("customApiKey");
    return ["none", ""].contains(apiKey) ? _defaultApiKey : apiKey;
  }

  Future<bool> _isValidCacheData(String cacheKey) async {
    final cachedTimestamp = await secureStorage.get(cacheKey);

    if (cachedTimestamp.isNotEmpty) {
      final currentTime = DateTime.now();
      final cachedTime = DateTime.parse(cachedTimestamp);
      return currentTime.difference(cachedTime).inHours <= cacheDurationInHours;
    }
    return false;
  }

  Future<List<Exercise>> getAllExercises() async {
    try {
      final cachedExercises = await secureStorage.get('cachedExercises');

      if (await _isValidCacheData('cachedExercisesTimestamp')) {
        return Exercise.parseExercises(json.decode(cachedExercises));
      }

      final uri = '$_baseUri/exercises';
      final defaultHeaders = {
        'X-RapidAPI-Key': await _getApiKey,
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
      };
      final response = await http.get(Uri.parse(uri), headers: defaultHeaders);
      if (response.statusCode == 200) {
        final exercisesJson = response.body;
        await secureStorage.add('cachedExercises', exercisesJson);
        await secureStorage.add(
            'cachedExercisesTimestamp', DateTime.now().toIso8601String());

        return Exercise.parseExercises(json.decode(exercisesJson));
      }
      throw response.body;
    } catch (e) {
      CustomError error = CustomError.fromRawJson(e.toString());
      utils.alertUser(error.message);
      if (error.message == "You are not subscribed to this API.") {
        await secureStorage.delete("flash");
        await secureStorage.delete("customApiKey");
      }
      log('Exception : $e');
    }
    return [];
  }

  Future<Exercise?> getExerciseById(String exerciseId) async {
    Exercise? exercise;
    try {
      final cachedExercise =
          await secureStorage.get('cachedExercise_$exerciseId');

      if (await _isValidCacheData('cachedExerciseTimestamp_$exerciseId')) {
        return Exercise.fromRawJson(cachedExercise);
      }

      final uri = '$_baseUri/exercises/exercise/$exerciseId';
      final defaultHeaders = {
        'X-RapidAPI-Key': await _getApiKey,
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
      };
      final response = await http.get(Uri.parse(uri), headers: defaultHeaders);

      if (response.statusCode == 200) {
        final exerciseJson = response.body;
        await secureStorage.add('cachedExercise_$exerciseId', exerciseJson);
        await secureStorage.add('cachedExerciseTimestamp_$exerciseId',
            DateTime.now().toIso8601String());
        return Exercise.fromRawJson(exerciseJson);
      }
      throw response.body;
    } catch (e) {
      CustomError error = CustomError.fromRawJson(e.toString());
      utils.alertUser(error.message);
      if (error.message == "You are not subscribed to this API.") {
        await secureStorage.delete("flash");
        await secureStorage.delete("customApiKey");
      }
      log('Exception : $e');
    }
    return exercise;
  }
}
