import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class HtmlContentScaffold extends StatelessWidget {
  const HtmlContentScaffold({
    super.key,
    required this.title,
    required this.html,
    required this.isLoading,
  });

  final String title;
  final String html;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBackAppBar(
        title: title,
        showDivider: true,
      ),
      body: isLoading
          ? const Center(child: AppProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Html(
                  data: html,
                  style: _htmlStyles,
                ),
              ),
            ),
    );
  }

  static Map<String, Style> get _htmlStyles => {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(14),
          lineHeight: const LineHeight(1.55),
          color: AppColors.textSecondary,
        ),
        'h3': Style(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: FontSize(18),
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        'h4': Style(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: FontSize(16),
          margin: Margins.only(top: 8, bottom: 8),
        ),
        'hr': Style(
          border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 1),
          ),
          margin: Margins.symmetric(vertical: 16),
        ),
        'p': Style(
          margin: Margins.only(bottom: 12),
        ),
        'strong': Style(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        'ul': Style(
          padding: HtmlPaddings.only(left: 8),
          margin: Margins.only(top: 4),
          listStyleType: ListStyleType.disc,
        ),
        'li': Style(
          margin: Margins.only(bottom: 8),
          lineHeight: const LineHeight(1.5),
          color: AppColors.textSecondary,
        ),
      };
}
