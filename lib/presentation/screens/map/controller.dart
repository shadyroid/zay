import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zay/app/use_cases/locations_use_case.dart';
import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/presentation/base/base_controller.dart';

class MapController extends BaseController with WidgetsBindingObserver {
  static const LatLng _defaultCenter = LatLng(30.0444, 31.2357);

  final LocationsUseCase _locationsUseCase = LocationsUseCase();

  final searchController = TextEditingController();
  final address = ''.obs;
  final latitude = _defaultCenter.latitude.obs;
  final longitude = _defaultCenter.longitude.obs;
  final locations = <LocationBean>[].obs;
  final showSuggestions = false.obs;
  final isResolvingAddress = false.obs;
  final locationSettingsMessage = RxnString();
  List<dynamic>? _addressComponents;

  GoogleMapController? _mapController;
  Timer? _searchDebounce;
  bool _skipNextCameraIdle = false;
  bool _resumeLocationRequest = false;

  CameraPosition get initialCameraPosition =>
      CameraPosition(target: LatLng(latitude.value, longitude.value), zoom: 16);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    searchController.addListener(_onSearchChanged);
    requestCurrentLocation();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchDebounce?.cancel();
    searchController.dispose();
    _mapController?.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !_resumeLocationRequest) return;
    _resumeLocationRequest = false;
    requestCurrentLocation();
  }

  Future<void> requestCurrentLocation() async {
    isLoading.value = true;
    try {
      final response = await _locationsUseCase.requestCurrentLocation();
      if (response.message == 'locationUnavailable' ||
          response.message == 'locationPermissionDenied') {
        locationSettingsMessage.value = response.message;
        await requestLocation();
        return;
      }

      if (!isSuccess(response)) {
        locationSettingsMessage.value = null;
        if (response.message != null) {
          Get.rawSnackbar(message: response.message!.tr);
        }
        await requestLocation();
        return;
      }

      final location = response.data;
      if (location == null) {
        locationSettingsMessage.value = 'locationUnavailable';
        await requestLocation();
        return;
      }

      locationSettingsMessage.value = null;
      await _applyLocation(location, animate: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openDeviceSettings() async {
    _resumeLocationRequest = true;
    if (locationSettingsMessage.value == 'locationPermissionDenied') {
      await Geolocator.openAppSettings();
      return;
    }

    final opened = await _openSettingsForUnavailableLocation();
    if (!opened) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<bool> _openSettingsForUnavailableLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Geolocator.openLocationSettings();
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return Geolocator.openAppSettings();
    }

    return false;
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
      if (!isSuccess(response) || response.data?.address == null) {
        address.value = '';
        _addressComponents = null;
        return;
      }
      address.value = response.data!.address!;
      _addressComponents = response.data!.addressComponents;
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
    searchController.text = location.address??"";
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
    address.value = location.address ?? "";
    latitude.value = location.lat ?? 0.0;
    longitude.value = location.lng ?? 0.0;
    _addressComponents = location.addressComponents;
    _skipNextCameraIdle = true;

    final controller = _mapController;
    if (controller != null) {
      final target = LatLng(location.lat??0.0, location.lng??0.0);
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
        lat: latitude.value,
        lng: longitude.value,
        addressComponents: _addressComponents,
      ),
    );
  }

  

  void hideSuggestions() {
    showSuggestions.value = false;
    locations.clear();
  }
}
