import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  List<Exercise> _allWorkouts = [];
  List<Exercise> filteredWorkouts = [];

  Exercise? exercise;

  List<String> get targets =>
      filteredWorkouts.map((e) => e.target).toSet().toList();

  List<String> get bodyParts =>
      filteredWorkouts.map((e) => e.bodyPart).toSet().toList();

  List<String> get equipments =>
      filteredWorkouts.map((e) => e.equipment).toSet().toList();

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    startLoading();
    _allWorkouts = await apiService.getAllExercises();
    filteredWorkouts = _allWorkouts;
    stopLoading();
  }

  search() async {
    startLoading();
    String value = searchController.text.toLowerCase();
    filteredWorkouts = _allWorkouts
        .where((element) =>
            element.name.contains(value) ||
            element.target.contains(value) ||
            element.bodyPart.contains(value))
        .toList();
    stopLoading();
  }

  clear() async {
    startLoading();
    searchController.clear();
    filteredWorkouts = _allWorkouts;
    stopLoading();
  }

  Future<void> getExerciseById(String exerciseId) async {
    startLoading();
    exercise = await apiService.getExerciseById(exerciseId);
    stopLoading();
  }
}
