import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/size_bean.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({super.key});

  List<SizeBean>? get _sizes {
    final args = Get.arguments;
    if (args is! Map) return null;
    final sizes = args['sizes'];
    if (sizes is! List) return null;
    return sizes.whereType<SizeBean>().toList();
  }

  String? get _measurementsImage {
    final args = Get.arguments;
    if (args is! Map) return null;
    return args['measurementsImage'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    final sizes = _sizes;
    final measurementsImage = _measurementsImage;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'sizeGuide'.tr,
        showDivider: true,
      ),
      body: sizes == null || sizes.isEmpty
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (measurementsImage != null)
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: AppImage.network(
                        measurementsImage,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        viewerImages: [measurementsImage],
                      ),
                    ),
                  if (measurementsImage != null) const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Table(
                        border: TableBorder.all(
                          color: AppColors.border,
                          width: 0.5,
                        ),
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: AppColors.selectedCheck.withValues(
                                alpha: 0.15,
                              ),
                            ),
                            children: [
                              _headerCell('size'.tr),
                              ...sizes.map((s) => _headerCell(s.label)),
                            ],
                          ),
                          ..._buildMeasurementRows(sizes).asMap().entries.map(
                            (entry) {
                              final index = entry.key;
                              final row = entry.value;
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.white
                                      : AppColors.screenBackground,
                                ),
                                children: [
                                  _dataCell(row.label ?? '', bold: true),
                                  ...sizes.map((size) {
                                    final value = row.values[size.id] ?? '-';
                                    return _dataCell(value);
                                  }),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<_MeasurementRow> _buildMeasurementRows(List<SizeBean> sizes) {
    if (sizes.isEmpty) return [];

    final ordered = <int?, String?>{};
    for (final m in sizes.first.measurements ?? []) {
      ordered[m.id] = m.label;
    }

    return ordered.entries.map((entry) {
      final values = <int?, String?>{};
      for (final size in sizes) {
        final match = size.measurements
            ?.where((m) => m.id == entry.key)
            .firstOrNull;
        values[size.id] = match?.value ?? '-';
      }
      return _MeasurementRow(label: entry.value, values: values);
    }).toList();
  }

  Widget _headerCell(String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        text ?? '',
        style: Get.theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _dataCell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        text,
        style: Get.theme.textTheme.bodySmall?.copyWith(
          fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _MeasurementRow {
  const _MeasurementRow({required this.label, required this.values});

  final String? label;
  final Map<int?, String?> values;
}
