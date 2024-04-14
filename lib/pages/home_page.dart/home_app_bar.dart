import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_background.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

final _kAutoSizeGroup = AutoSizeGroup();

class HomeAppBar extends ConsumerWidget {
  static const verticalPadding = 6.0;

  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final between = ref.watch(exchangeBetweenProvider);
    final _ = ref.watch(ratesProvider);

    void onCurrencyTap(Currency currency) {
      Onboarding.guard(
        () => SelectCurrencyRoute(currencyCode: currency.code).go(context),
        event: const OpenSelectCurrencyPageEvent(),
      );
    }

    bool showCustomRateBadge(Currency currency) {
      if (currency.isTime || between.from.isTime) {
        return false;
      }
      return ref.read(rateProvider(between.from, currency)).source.isCustom;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.tableTheme.borderColor,
              width: 1,
            ),
          ),
        ),
        child: ExchangeTableBackgroundWrapper(
          columnsCount: ref.watch(exchangeBetweenProvider).length,
          child: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: verticalPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ColumnHeader(
                          currency: between.from,
                          useShortName: true,
                          showCustomRateBadge: false,
                          alignment: ColumnAlignment.right,
                          onTap: () => onCurrencyTap(between.from),
                        ),
                      ),
                      Expanded(
                        child: _ColumnHeader(
                          currency: between.to1,
                          useShortName: false,
                          showCustomRateBadge: showCustomRateBadge(between.to1),
                          alignment:
                              between.isThree ? ColumnAlignment.center : ColumnAlignment.left,
                          onTap: () => onCurrencyTap(between.to1),
                        ),
                      ),
                      if (between.isThree)
                        Expanded(
                          child: _ColumnHeader(
                            currency: between.to2!,
                            useShortName: false,
                            showCustomRateBadge: showCustomRateBadge(between.to2!),
                            alignment: ColumnAlignment.left,
                            onTap: () => onCurrencyTap(between.to2!),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onLongPress: () => const DebugRoute().push<void>(context),
                  child: IconButton(
                    onPressed: () => Onboarding.guard(() => const SettingsRoute().go(context)),
                    padding: const EdgeInsets.all(verticalPadding),
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(AppIcons.settings),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  const _ColumnHeader({
    required this.currency,
    required this.showCustomRateBadge,
    required this.useShortName,
    required this.alignment,
    required this.onTap,
  });

  final Currency currency;
  final bool useShortName;
  final bool showCustomRateBadge;
  final ColumnAlignment alignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final alignment = switch (this.alignment) {
      ColumnAlignment.left => Alignment.centerLeft,
      ColumnAlignment.center => Alignment.center,
      ColumnAlignment.right => Alignment.centerRight,
    };

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kValuePadding),
        child: Align(
          alignment: alignment,
          child: CustomRateBadge(
            show: showCustomRateBadge,
            child: AutoSizeText(
              useShortName ? currency.displayCodeShort(context) : currency.displayCode(context),
              group: _kAutoSizeGroup,
              maxLines: 1,
            ).textStyle(
              context.textTheme.titleLarge?.copyWith(height: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRateBadge extends StatelessWidget {
  const CustomRateBadge({
    super.key,
    required this.show,
    required this.child,
  });

  final bool show;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const double badgeSize = 8;

    Widget buildBadge() {
      return Positioned(
        top: 0,
        right: 0,
        child: Transform.translate(
          offset: const Offset(badgeSize + 2, 0),
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: context.theme.customRateColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        if (show) buildBadge(),
        child,
      ],
    );
  }
}
