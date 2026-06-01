import 'package:flutter/material.dart';
import 'package:reach_skills/core/constants/strings.dart';
import 'package:reach_skills/core/theme/styles.dart';

class GuestSignInInfoBox extends StatefulWidget {
  const GuestSignInInfoBox({super.key, required this.onTapSignIn});

  final VoidCallback onTapSignIn;

  @override
  State<GuestSignInInfoBox> createState() => _GuestSignInInfoBoxState();
}

class _GuestSignInInfoBoxState extends State<GuestSignInInfoBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    return Card(
      elevation: Styles.elevationCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(gradient: Styles.skillCardBackgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                Str.guestInfoTitle,
                style: Styles.textStyle16BlackWeightMedium,
              ),
              trailing: AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                ),
              ),
              onTap: () => setState(() => _isExpanded = !_isExpanded),
            ),

            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState:
                    _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                sizeCurve: Curves.easeInOut,
                firstChild: Container(),
                secondChild: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Styles.paddingMedium,
                    0,
                    Styles.paddingMedium,
                    Styles.paddingMedium,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: defaultTextStyle,
                          children: [
                            const TextSpan(text: Str.guestInfoDescriptionPart1),
                            const TextSpan(
                              text: Str.guestInfoDescriptionGuestAccess,
                              style: Styles.textStyle14BlackWeight600,
                            ),
                            const TextSpan(text: Str.guestInfoDescriptionPart2),
                            const TextSpan(
                              text: Str.devUserName1,
                              style: Styles.textStyle14BlackWeight600,
                            ),
                            const TextSpan(text: Str.guestInfoDescriptionAnd),
                            const TextSpan(
                              text: Str.devUserName2,
                              style: Styles.textStyle14BlackWeight600,
                            ),
                            const TextSpan(text: Str.guestInfoDescriptionPart3),
                          ],
                        ),
                      ),
                      const SizedBox(height: Styles.spacingSmall),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Styles.paddingSmall),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(
                                Styles.borderRadius,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: defaultTextStyle,
                                    children: [
                                      const TextSpan(text: Str.guestEmailLabel),
                                      const TextSpan(
                                        text: Str.guestEmail1,
                                        style: Styles.textStyle14BlackWeight600,
                                      ),
                                      const TextSpan(
                                        text: Str.guestEmailSeparator,
                                      ),
                                      const TextSpan(
                                        text: Str.guestEmail2,
                                        style: Styles.textStyle14BlackWeight600,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: defaultTextStyle,
                                    children: [
                                      const TextSpan(
                                        text: Str.guestPasswordLabel,
                                      ),
                                      const TextSpan(
                                        text: Str.guestPassword,
                                        style: Styles.textStyle14BlackWeight600,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Styles.spacingMedium),

                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: FilledButton(
                              onPressed: widget.onTapSignIn,
                              child: const Text(Str.guestSignInButton),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
