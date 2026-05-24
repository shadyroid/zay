import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/app/use_cases/locations_use_case.dart';
import 'package:hedma/domain/models/beans/location_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class MapController extends BaseController {
  static const LatLng _defaultCenter = LatLng(30.0444, 31.2357);

  final LocationsUseCase _locationsUseCase = LocationsUseCase();

  final searchController = TextEditingController();
  final address = ''.obs;
  final latitude = _defaultCenter.latitude.obs;
  final longitude = _defaultCenter.longitude.obs;
  final locations = <LocationBean>[].obs;
  final showSuggestions = false.obs;
  final isResolvingAddress = false.obs;

  GoogleMapController? _mapController;
  Timer? _searchDebounce;
  bool _skipNextCameraIdle = false;

  CameraPosition get initialCameraPosition =>
      CameraPosition(target: LatLng(latitude.value, longitude.value), zoom: 16);

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    requestCurrentLocation();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    _mapController?.dispose();
    super.onClose();
  }

  Future<void> requestCurrentLocation() async {
    isLoading.value = true;
    try {
      final response = await _locationsUseCase.requestCurrentLocation();
      if (!isSuccess(response)) {
        if (response.message != null) {
          Get.rawSnackbar(message: response.message!.tr);
        }
        await requestLocation();
        return;
      }

      final location = response.data;
      if (location == null) {
        Get.rawSnackbar(message: 'locationUnavailable'.tr);
        await requestLocation();
        return;
      }

      await _applyLocation(location, animate: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestLocations(String input) async {
    isResolvingAddress.value = true;
    try {
      final response = await _locationsUseCase.requestLocations(input);
      if (!isSuccess(response)) return;
      locations.assignAll(response.data ?? []);
      showSuggestions.value = locations.isNotEmpty;
    } finally {
      isResolvingAddress.value = false;
    }
  }

  Future<void> requestLocation() async {
    isResolvingAddress.value = true;
    try {
      final response = await _locationsUseCase.requestLocation(
        LatLng(latitude.value, longitude.value),
      );
      if (!isSuccess(response) || response.data == null) {
        address.value = '';
        return;
      }
      address.value = response.data!.address;
    } finally {
      isResolvingAddress.value = false;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.moveCamera(
      CameraUpdate.newLatLngZoom(LatLng(latitude.value, longitude.value), 16),
    );
  }

  void onCameraMove(CameraPosition position) {
    latitude.value = position.target.latitude;
    longitude.value = position.target.longitude;
  }

  Future<void> onCameraIdle() async {
    if (_skipNextCameraIdle) {
      _skipNextCameraIdle = false;
      return;
    }
    await requestLocation();
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () async {
      final query = searchController.text.trim();
      if (query.isEmpty) {
        locations.clear();
        showSuggestions.value = false;
        return;
      }
      requestLocations(query);
    });
  }

  Future<void> onLocationSelected(int index) async {
    if (index < 0 || index >= locations.length) return;

    final location = locations[index];
    showSuggestions.value = false;
    locations.clear();
    searchController.text = location.address;
    isResolvingAddress.value = true;

    try {
      await _applyLocation(location, animate: true);
    } finally {
      isResolvingAddress.value = false;
    }
  }

  Future<void> _applyLocation(
    LocationBean location, {
    bool animate = false,
  }) async {
    address.value = location.address;
    latitude.value = location.latitude;
    longitude.value = location.longitude;
    _skipNextCameraIdle = true;

    final controller = _mapController;
    if (controller != null) {
      final target = LatLng(location.latitude, location.longitude);
      if (animate) {
        await controller.animateCamera(CameraUpdate.newLatLng(target));
      } else {
        await controller.moveCamera(CameraUpdate.newLatLng(target));
      }
    }
  }



  void pickLocation() {
    if (address.value.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    Get.back(
      result: LocationBean(
        address: address.value,
        latitude: latitude.value,
        longitude: longitude.value,
      ),
    );
  }

  void goBack() => Get.back();

  void hideSuggestions() {
    showSuggestions.value = false;
    locations.clear();
  }
}
