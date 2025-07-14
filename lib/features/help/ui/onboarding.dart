import 'package:flutter/material.dart';
import 'package:reach_skills/features/help/ui/onboarding_base.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key, required this.endOnboarding});

  final VoidCallback endOnboarding;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      onboardingProgress: screenIndex,
      onboardingBody: switch (screenIndex) {
        0 => buildOnboarding0(),
        1 => buildOnboarding1(),
        2 => buildOnboarding2(),
        3 => buildOnboarding3(),
        4 => buildOnboarding4(),

        _ => buildOnboarding0(),
      },
      onTapNext: () {
        if (screenIndex < 4) {
          setState(() => screenIndex++);
        } else {
          widget.endOnboarding();
        }
      },
    );
  }
}

Widget buildOnboarding0() => Column(
  children: [
    const SizedBox(height: 140.0),
    const Text(Str.onboarding0Title, style: Styles.onboardingTitleTextStyle),
    const SizedBox(height: Styles.spacingMedium),
    const Text(
      Str.onboarding0Description,
      style: Styles.onboardingDescriptionTextStyle,
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 76),
    Container(
      decoration: BoxDecoration(
        color: Styles.skillChipBackgroundColor,
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      width: 180,
      height: 180,
      // Todo replace with app logo
      child: Icon(Icons.explore, size: Styles.appLogoSize),
    ),
    const SizedBox(height: 24),
    const Text(
      Str.appTitle,
      style: Styles.interestDetailsSectionTitleTextStyle,
    ),
    SizedBox(height: 32.0),
  ],
);

Widget buildOnboarding1() => Column(
  children: [
    const Text(Str.onboarding1Title, style: Styles.onboardingTitleTextStyle),
    const SizedBox(height: Styles.spacingMedium),
    const Text(
      Str.onboarding1Description,
      style: Styles.onboardingDescriptionTextStyle,
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 76),

    // Skills
    Container(
      decoration: BoxDecoration(
        color: Styles.skillChipBackgroundColor,
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      width: 48,
      height: 48,
      child: Icon(Icons.work_outline_rounded),
    ),
    const SizedBox(height: 16),
    const Text(Str.skills, style: Styles.textStyle16BlackWeightMedium),
    const Text(
      Str.skillsDefinition,
      style: Styles.textStyle14SubtitleBlue,
      textAlign: TextAlign.center,
    ),

    // Line separator
    const SizedBox(height: 32),
    Container(
      width: 256,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Styles.progressUndoneBackgroundColor,
            width: 1,
          ),
        ),
      ),
    ),
    const SizedBox(height: 32),

    // Wishes
    Container(
      decoration: BoxDecoration(
        color: Styles.wishChipBackgroundColor,
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      width: 48,
      height: 48,
      child: Icon(Icons.wallet_giftcard_rounded),
    ),
    const SizedBox(height: 16),
    const Text(Str.wishes, style: Styles.textStyle16BlackWeightMedium),
    const Text(
      Str.wishesDefinition,
      style: Styles.textStyle14SubtitleBlue,
      textAlign: TextAlign.center,
    ),

    SizedBox(height: 32.0),
  ],
);

Widget buildOnboarding2() => Column(
  children: [
    Container(
      constraints: const BoxConstraints(
        maxWidth: Styles.illustrationMaxWidth,
        maxHeight: Styles.illustrationMaxWidth,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Styles.padding20),
      child: Image(image: AssetImage('assets/images/Skills.jpg')),
    ),
    const SizedBox(height: 20),
    const Text(Str.skills, style: Styles.onboardingTitleTextStyle),
    const SizedBox(height: Styles.spacingMedium),
    const Text(
      Str.skillsReachDefinition,
      style: Styles.onboardingDescriptionTextStyle,
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 32.0),
  ],
);

Widget buildOnboarding3() => Column(
  children: [
    Container(
      constraints: const BoxConstraints(
        maxWidth: Styles.illustrationMaxWidth,
        maxHeight: Styles.illustrationMaxWidth,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Styles.padding20),
      child: Image(image: AssetImage('assets/images/Wishes.jpg')),
    ),
    const SizedBox(height: 20),
    const Text(Str.wishes, style: Styles.onboardingTitleTextStyle),
    const SizedBox(height: Styles.spacingMedium),
    const Text(
      Str.wishesReachDefinition,
      style: Styles.onboardingDescriptionTextStyle,
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 32.0),
  ],
);

Widget buildOnboarding4() => Column(
  children: [
    Container(
      constraints: const BoxConstraints(
        maxWidth: Styles.illustrationMaxWidth,
        maxHeight: Styles.illustrationMaxWidth,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Styles.padding20),
      child: Image(image: AssetImage('assets/images/Skill-for-wish.jpg')),
    ),
    const SizedBox(height: 20),
    const Text(Str.skillForWish, style: Styles.onboardingTitleTextStyle),
    const SizedBox(height: Styles.spacingMedium),
    const Text(
      Str.skillForWishReachDefinition,
      style: Styles.onboardingDescriptionTextStyle,
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 32.0),
  ],
);
