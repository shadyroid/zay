import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/app/use_cases/locations_use_case.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class MapController extends BaseController {
  static const LatLng _defaultCenter = LatLng(30.0444, 31.2357);

  final LocationsUseCase _locationsUseCase = LocationsUseCase();

  final searchController = TextEditingController();
  final primaryAddress = ''.obs;
  final secondaryAddress = ''.obs;
  final latitude = _defaultCenter.latitude.obs;
  final longitude = _defaultCenter.longitude.obs;
  final placePredictions = <PlacePrediction>[].obs;
  final showSuggestions = false.obs;
  final isResolvingAddress = false.obs;

  GoogleMapController? _mapController;
  Timer? _searchDebounce;
  bool _skipNextCameraIdle = false;

  CameraPosition get initialCameraPosition => CameraPosition(
        target: LatLng(latitude.value, longitude.value),
        zoom: 16,
      );

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    _loadInitialLocation();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    _mapController?.dispose();
    super.onClose();
  }

  Future<void> _loadInitialLocation() async {
    isLoading.value = true;
    try {
      final granted = await _locationsUseCase.requestLocationPermission();
      if (!granted) {
        Get.rawSnackbar(message: 'locationPermissionDenied'.tr);
        await _resolveAddressForCurrentTarget();
        return;
      }

      final position = await _locationsUseCase.requestCurrentPosition();
      if (position == null) {
        Get.rawSnackbar(message: 'locationUnavailable'.tr);
        await _resolveAddressForCurrentTarget();
        return;
      }

      await _moveTo(position.latitude, position.longitude);
    } finally {
      isLoading.value = false;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.moveCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(latitude.value, longitude.value),
        16,
      ),
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
    await _resolveAddressForCurrentTarget();
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () async {
      final query = searchController.text.trim();
      if (query.isEmpty) {
        placePredictions.clear();
        showSuggestions.value = false;
        return;
      }
      final results = await _locationsUseCase.requestPlaceAutocomplete(query);
      placePredictions.assignAll(results);
      showSuggestions.value = results.isNotEmpty;
    });
  }

  Future<void> onPlaceSelected(PlacePrediction prediction) async {
    showSuggestions.value = false;
    placePredictions.clear();
    searchController.text =
        prediction.mainText ?? prediction.description;
    isResolvingAddress.value = true;

    try {
      final details =
          await _locationsUseCase.requestPlaceDetails(prediction.placeId);
      if (details == null) {
        Get.rawSnackbar(message: 'locationUnavailable'.tr);
        return;
      }

      primaryAddress.value = details.address.primary;
      secondaryAddress.value = details.address.secondary;
      await _moveTo(
        details.position.latitude,
        details.position.longitude,
        animate: true,
      );
    } finally {
      isResolvingAddress.value = false;
    }
  }

  Future<void> _moveTo(
    double lat,
    double lng, {
    bool animate = false,
  }) async {
    latitude.value = lat;
    longitude.value = lng;
    _skipNextCameraIdle = true;

    final controller = _mapController;
    if (controller != null) {
      final target = LatLng(lat, lng);
      if (animate) {
        await controller.animateCamera(
          CameraUpdate.newLatLng(target),
        );
      } else {
        await controller.moveCamera(CameraUpdate.newLatLng(target));
      }
    }

    await _resolveAddressForCurrentTarget();
  }

  Future<void> _resolveAddressForCurrentTarget() async {
    isResolvingAddress.value = true;
    try {
      final address = await _locationsUseCase.requestReverseGeocode(
        latitude: latitude.value,
        longitude: longitude.value,
      );
      if (address == null) {
        primaryAddress.value = '';
        secondaryAddress.value = '';
        return;
      }
      primaryAddress.value = address.primary;
      secondaryAddress.value = address.secondary;
    } finally {
      isResolvingAddress.value = false;
    }
  }

  void pickLocation() {
    final address = secondaryAddress.value.isNotEmpty
        ? secondaryAddress.value
        : primaryAddress.value;

    if (address.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    Get.back(
      result: {
        'address': address,
        'lat': latitude.value,
        'lng': longitude.value,
      },
    );
  }

  void goBack() => Get.back();

  void hideSuggestions() {
    showSuggestions.value = false;
    placePredictions.clear();
  }
}
