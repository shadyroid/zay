import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/map/controller.dart';
import 'package:hedma/presentation/screens/map/widgets/map_location_bottom_card.dart';
import 'package:hedma/presentation/screens/map/widgets/map_place_suggestions.dart';
import 'package:hedma/presentation/screens/map/widgets/map_search_bar.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        _MapIconButton(
                          icon: AppIcons.back,
                          onTap: controller.goBack,
                        ),
                        const Spacer(),
                        _MapIconButton(
                          icon: AppIcons.notifications,
                          onTap: () {},
                          showBadge: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    MapSearchBar(
                      controller: controller.searchController,
                      onSubmitted: () {},
                      onTap: () {},
                    ),
                    if (controller.showSuggestions.value &&
                        controller.placePredictions.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      MapPlaceSuggestions(
                        predictions: controller.placePredictions,
                        onSelect: controller.onPlaceSelected,
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
                  primaryAddress: controller.primaryAddress.value,
                  secondaryAddress: controller.secondaryAddress.value,
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

class _MapIconButton extends StatelessWidget {
  const _MapIconButton({
    required this.icon,
    required this.onTap,
    this.showBadge = false,
  });

  final String icon;
  final VoidCallback onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(icon, width: 22, height: 22),
              if (showBadge)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
