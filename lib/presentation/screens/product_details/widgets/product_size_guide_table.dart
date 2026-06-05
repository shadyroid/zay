import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_size_bean.dart';
class ProductSizeGuideTable extends StatelessWidget {
  const ProductSizeGuideTable({super.key, required this.sizes});

  final List<ProductSizeBean>? sizes;

  @override
  Widget build(BuildContext context) {
    if (sizes==null||sizes!.isEmpty) return const SizedBox.shrink();

    final measurementRows = _buildMeasurementRows(sizes!);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'sizeGuide'.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Table(
                border: TableBorder.all(color: AppColors.border, width: 0.5),
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: AppColors.selectedCheck.withValues(alpha: 0.15),
                    ),
                    children: [
                      _headerCell(context, 'size'.tr),
                      ...sizes!.map((s) => _headerCell(context, s.label)),
                    ],
                  ),
                  ...measurementRows.map((row) {
                    return TableRow(
                      decoration: BoxDecoration(
                        color: measurementRows.indexOf(row).isEven
                            ? Colors.white
                            : AppColors.screenBackground,
                      ),
                      children: [
                        _dataCell(context, row.label??"", bold: true),
                        ...sizes!.map((size) {
                          final value = row.values[size.id] ?? '-';
                          return _dataCell(context, value);
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_MeasurementRow> _buildMeasurementRows(List<ProductSizeBean> sizes) {
    if (sizes.isEmpty) return [];

    final ordered = <int?, String?>{};
    for (final m in sizes.first.measurements) {
      ordered[m.id] = m.label;
    }

    return ordered.entries.map((entry) {
      final values = <int?, String?>{};
      for (final size in sizes) {
        final match = size.measurements
            .where((m) => m.id == entry.key)
            .firstOrNull;
        values[size.id] = match?.value ?? '-';
      }
      return _MeasurementRow(label: entry.value, values: values);
    }).toList();
  }

  Widget _headerCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _dataCell(BuildContext context, String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
