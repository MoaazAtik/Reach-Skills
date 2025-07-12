import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';

class HelpBody extends StatelessWidget {
  const HelpBody({super.key, required this.onTapOnboardingGuide});

  final VoidCallback onTapOnboardingGuide;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Styles.paddingMedium),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Str.contactUs,
                    style: Styles.interestDetailsSectionTitleTextStyle,
                  ),
                  const SizedBox(height: Styles.spacingSmall),
                  const Text(
                    Str.supportEmail,
                    style: Styles.supportEmailTextStyle,
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {},
              style: Theme.of(context).filledButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(
                  const Size(300.0, Styles.buttonHeight),
                ),
              ),
              child: const Text(
                Str.onboardingGuide,
                style: Styles.rsFilledButtonTextStyle,
              ),
            ),
            const SizedBox(height: 64),
            const Text(
              Str.poweredBy,
              style: Styles.interestDetailsUserTextStyle,
            ),
            const Text(Str.whiteWings, style: Styles.developerTextStyle),
          ],
        ),
      ),
    );
  }
}
