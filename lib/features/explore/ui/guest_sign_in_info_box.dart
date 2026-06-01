import 'package:flutter/material.dart';
import 'package:reach_skills/core/constants/strings.dart';
import 'package:reach_skills/core/theme/styles.dart';

class GuestSignInInfoBox extends StatefulWidget {
  const GuestSignInInfoBox({super.key, required this.onTapSignIn});

  final VoidCallback onTapSignIn;

  @override
  State<GuestSignInInfoBox> createState() => _GuestSignInInfoBoxState();
}

class _GuestSignInInfoBoxState extends State<GuestSignInInfoBox>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final List<InlineSpan> descriptionTextSpans;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    descriptionTextSpans = _buildStyledDescription();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: Styles.paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Styles.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Styles.skillCardGradientEndColor.withValues(
                  alpha: 0.5 * _glowAnimation.value,
                ),
                blurRadius: 12.0 * _glowAnimation.value + 4.0,
                spreadRadius: 1.0 * _glowAnimation.value,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
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
                  turns: _isExpanded ? -0.5 : 0,
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
                            children: descriptionTextSpans,
                          ),
                        ),
                        const SizedBox(height: Styles.spacingSmall),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                Styles.paddingSmall,
                              ),
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
                                        const TextSpan(
                                          text: Str.guestEmailLabel,
                                        ),
                                        const TextSpan(
                                          text: Str.guestEmail1,
                                          style:
                                              Styles.textStyle14BlackWeight600,
                                        ),
                                        const TextSpan(
                                          text: Str.guestEmailSeparator,
                                        ),
                                        const TextSpan(
                                          text: Str.guestEmail2,
                                          style:
                                              Styles.textStyle14BlackWeight600,
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
                                          style:
                                              Styles.textStyle14BlackWeight600,
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
      ),
    );
  }

  List<InlineSpan> _buildStyledDescription() {
    final String fullText = Str.guestInfoDescription;
    final List<String> highlights = [
      Str.guestInfoDescriptionGuestAccess,
      Str.devUserName1,
      Str.devUserName2,
    ];

    final List<InlineSpan> spans = [];
    int lastMatchEnd = 0;

    // Build a regex that matches any of the highlights
    /* Ensure that special characters are treated as literal text,
    * not regex commands.*/
    final String pattern = highlights.map(RegExp.escape).join('|');
    final RegExp regex = RegExp(pattern);

    for (final Match match in regex.allMatches(fullText)) {
      // Add text before the match
      /* If there is text between the end of the previous match and the start of
      * the current match, add it as a normal TextSpan.*/
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(text: fullText.substring(lastMatchEnd, match.start)),
        );
      }
      // Add the matched highlight with bold style
      spans.add(
        TextSpan(text: match.group(0), style: Styles.textStyle14BlackWeight600),
      );
      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(lastMatchEnd)));
    }

    return spans;
  }
}
