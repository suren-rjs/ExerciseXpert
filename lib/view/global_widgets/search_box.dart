import 'package:exercise_expert/controller/data_controller.dart';
import 'package:exercise_expert/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      init: Get.find<DataController>(),
      builder: (controller) {
        return Container(
          // Add padding around the search bar
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          // Use a Material design search bar
          child: TextField(
            controller: controller.searchController,
            onChanged: (value) => controller.search(),
            cursorColor: appColors.lavenderGrey80,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                color: appColors.lavenderGrey80,
                focusColor: appColors.lavenderGrey80,
                disabledColor: appColors.lavenderGrey80,
                highlightColor: appColors.lavenderGrey80,
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.searchController.clear();
                  controller.clear();
                },
              ),
              prefixIcon: IconButton(
                color: appColors.lavenderGrey80,
                focusColor: appColors.lavenderGrey80,
                disabledColor: appColors.lavenderGrey80,
                highlightColor: appColors.lavenderGrey80,
                icon: Icon(
                  Icons.search,
                  color: appColors.lavenderGrey80,
                ),
                onPressed: () {},
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}
