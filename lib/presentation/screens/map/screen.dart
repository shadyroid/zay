import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/map/controller.dart';
import 'package:hedma/presentation/screens/map/widgets/map_location_bottom_card.dart';
import 'package:hedma/presentation/screens/map/widgets/map_place_suggestions.dart';
import 'package:hedma/presentation/screens/map/widgets/map_search_bar.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';
class MapScreen extends GetView<MapController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'selectLocation'.tr,
          style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              initialCameraPosition: controller.initialCameraPosition,
              onMapCreated: controller.onMapCreated,
              onCameraMove: controller.onCameraMove,
              onCameraIdle: controller.onCameraIdle,
              onTap: (_) => controller.hideSuggestions(),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 36),
                child: _MapCenterPin(),
              ),
            ),
            if (controller.isLoading.value)
              const ColoredBox(
                color: Color(0x33FFFFFF),
                child: Center(
                  child: AppProgressIndicator(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MapSearchBar(
                      controller: controller.searchController,
                      onSubmitted: () {},
                      onTap: () {},
                    ),
                    if (controller.showSuggestions.value &&
                        controller.locations.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      MapPlaceSuggestions(
                        locations: controller.locations,
                        onSelect: controller.onLocationSelected,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(
                () => MapLocationBottomCard(
                  address: controller.address.value,
                  isLoading: controller.isResolvingAddress.value,
                  onPickLocation: controller.pickLocation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapCenterPin extends StatelessWidget {
  const _MapCenterPin();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.location_on,
      size: 48,
      color: Colors.red.shade700,
      shadows: const [
        Shadow(
          color: Color(0x40000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
