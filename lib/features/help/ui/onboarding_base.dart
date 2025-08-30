import 'package:flutter/material.dart';
import 'package:reach_skills/features/help/ui/onboarding_progress_chip.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';

class OnboardingBase extends StatelessWidget {
  const OnboardingBase({
    super.key,
    required this.onboardingProgress,
    required this.onboardingBody,
    required this.onTapNext,
  });

  final int onboardingProgress;
  final Widget onboardingBody;
  final VoidCallback onTapNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Styles.paddingMedium,
        right: Styles.paddingMedium,
        bottom: Styles.padding12,
      ),
      child: Column(
        children: [
          if (onboardingProgress > 0) SizedBox(height: 32.0),
          if (onboardingProgress > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Styles.spacing12,
              children: List.generate(4, (index) {
                return onboardingProgressChip(
                  _getProgressChipColor(index, onboardingProgress),
                );
              }),
            ),
          if (onboardingProgress > 0) SizedBox(height: 20),

          Expanded(child: SingleChildScrollView(child: onboardingBody)),

          FilledButton(
            onPressed: onTapNext,
            style: Theme.of(context).filledButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all(
                _getButtonBackground(onboardingProgress),
              ),
              minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, Styles.buttonHeight),
              ),
            ),
            child: Text(
              _getButtonText(onboardingProgress),
              style: Styles.rsFilledButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressChipColor(int progressIndex, int onboardingProgress) {
    return (progressIndex + 1) == onboardingProgress
        ? Styles.buttonPaleBackgroundColor
        : Styles.progressUndoneBackgroundColor;
  }

  String _getButtonText(int onboardingProgress) {
    switch (onboardingProgress) {
      case 0:
        return Str.getStarted;
      case 1:
      case 2:
      case 3:
        return Str.next;
      case 4:
        return Str.letsGo;
      default:
        return Str.next;
    }
  }

  Color _getButtonBackground(int onboardingProgress) {
    switch (onboardingProgress) {
      case 0:
        return Styles.buttonFullBackgroundColor;
      case 1:
      case 2:
      case 3:
        return Styles.buttonPaleBackgroundColor;
      case 4:
        return Styles.buttonFullBackgroundColor;
      default:
        return Styles.buttonFullBackgroundColor;
    }
  }
}
