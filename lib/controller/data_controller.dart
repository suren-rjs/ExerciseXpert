import 'dart:developer';

import 'package:exercise_expert/model/exercises.dart';
import 'package:exercise_expert/service/api_service.dart';
import 'package:exercise_expert/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  bool isLoading = true;
  bool isEstablishedConnection = true;
  final TextEditingController searchController = TextEditingController();
  List<Exercise> _allWorkouts = [];
  List<Exercise> filteredWorkouts = [];

  final int _visiblePages = 3;

  int _currentPage = 1;

  int _numOfPages = 0;

  int get numOfPages => _numOfPages;

  int get currentPage => _currentPage;

  int get visiblePages => _visiblePages;

  Future<void> setPage(int value) async {
    startLoading();
    _currentPage = value;
    List<Exercise> searchFilteredList = await search();
    filteredWorkouts.clear();
    _numOfPages = searchFilteredList.length ~/ 10;
    try {
      int minElementNumber = ((_currentPage - 1) * 10);
      int maxElementNumber = (_currentPage * 10);
      for (int index = minElementNumber; index < maxElementNumber; index++) {
        filteredWorkouts.add(searchFilteredList[index]);
      }
    } catch (e) {
      log("Exception : " + e.toString());
    }
    stopLoading();
  }

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
    await updateExercises().then((value) => setPage(_currentPage));
    updateConnection();
  }

  Future updateExercises() async {
    startLoading();
    _allWorkouts = await apiService.getAllExercises();
    stopLoading();
  }

  updateConnection() async {
    isEstablishedConnection = await utils.checkInternetConnectivity();
    update();
    await Future.delayed(const Duration(minutes: 1));
    updateConnection();
  }

  Future<List<Exercise>> search() async {
    String value = searchController.text.toLowerCase();
    return _allWorkouts
        .where((element) =>
            element.name.contains(value) ||
            element.target.contains(value) ||
            element.bodyPart.contains(value))
        .toList();
  }

  clear() async {
    startLoading();
    searchController.clear();
    setPage(_currentPage);
    stopLoading();
  }

  Future<void> getExerciseById(String exerciseId) async {
    startLoading();
    exercise = await apiService.getExerciseById(exerciseId);
    stopLoading();
  }
}
