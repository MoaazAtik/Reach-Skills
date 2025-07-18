import 'package:flutter/material.dart';
import 'package:reach_skills/core/constants/strings.dart';
import 'package:reach_skills/core/theme/styles.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/data/interest_model.dart';
import 'package:reach_skills/features/common/widgets/rs_chip.dart';

import '../data/skill_model.dart';
import '../data/wish_model.dart';

class InterestDetails extends StatefulWidget {
  const InterestDetails({
    super.key,
    required this.isOwner,
    required this.interest,
    this.onTapReach,
    this.onTapSave,
  });

  final bool isOwner;

  // Todo replace Str.mock... with interest...
  final InterestModel? interest;
  final void Function()? onTapReach;
  // final void Function()? onTapSave;
  final void Function(InterestModel interest)? onTapSave;


  @override
  State<InterestDetails> createState() => _InterestDetailsState();
}

class _InterestDetailsState extends State<InterestDetails> {
  bool isEditing = false;

  final _formKey = GlobalKey<FormState>(debugLabel: '_ProfileBodyState');
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.interest?.title);
    _descriptionController = TextEditingController(
      text: widget.interest?.description,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Styles.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // Todo fix row Render flex overflow on large screen
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isEditing)
                    Text(
                      Str.mockInterestTitle,
                      style: Styles.interestDetailsTitleTextStyle,
                    ),
                  if (isEditing)
                    // Todo change background of this and all TextFormField's
                    TextFormField(
                      decoration: Styles.rsInputDecoration(
                        label: Str.interestTitle,
                        hint: Str.interestTitleHint,
                      ),
                      validator: textValidator,
                    ),
                  // SizedBox(height: 8),
                  Text(
                    '${Str.by} ${Str.mockUserName}',
                    // '${Str.by} ${widget.interest?.userName}',
                    style: Styles.interestDetailsUserTextStyle,
                  ),
                ],
              ),
              // Todo uncomment
              // if (widget.isOwner)
              IconButton(
                onPressed: () {
                  if (isEditing) {
                    widget.onTapSave!(_assembleInterest());
                  }
                  setState(() => isEditing = !isEditing);
                },
                icon: Icon(Icons.edit_outlined),
              ),
            ],
          ),
          SizedBox(height: 24),
          if (!isEditing)
            Text(
              Str.mockInterestDescription,
              // widget.interest!.description,
              style: Styles.interestDetailsDescriptionTextStyle,
            ),
          if (isEditing)
            TextFormField(
              decoration: Styles.rsInputDecoration(
                label: Str.interestDescription,
                hint: Str.interestDescriptionHint,
              ),
              // validator: textValidator,
            ),
          SizedBox(height: 24),
          Text(Str.type, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: 16),
          // Todo implement
          RsChip(
            children: [Text(Str.skill, style: Styles.interestChipTextStyle)],
          ),
          SizedBox(height: 24),
          // Todo implement
          Text(Str.tags, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: 16),
          // Todo implement
          Wrap(
            spacing: Styles.spacing12,
            runSpacing: Styles.spacing12,
            children: List.generate(Str.mockTags.length, (index) {
              return RsChip(
                children: [
                  Text(
                    Str.mockTags[index],
                    style: Styles.interestChipTextStyle,
                  ),
                ],
              );
            }),
          ),

          SizedBox(height: 56),
          // Todo implement
          // if (!isOwner || isEditing)
          FilledButton(
            onPressed: () {
              if (widget.isOwner) {
                if (widget.onTapSave != null) {
                  widget.onTapSave!(_assembleInterest());
                } else {
                  throw Exception(
                    'onTapSave is not provided to InterestDetails widget',
                  );
                }
              } else if (widget.onTapReach != null) {
                widget.onTapReach!();
              } else {
                throw Exception(
                  'onTapReach or onTapSave must be provided to InterestDetails widget',
                );
              }
            },
            child: Text(
              widget.isOwner ? Str.reach : Str.save,
              style: Styles.rsFilledButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  InterestModel _assembleInterest() {
    if (widget.interest!.interestType == InterestType.skill) {
      return SkillModel(
        id: widget.interest!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        // Todo implement
        tags: 'Str.mockTags',
        userId: widget.interest!.userId,
        userName: widget.interest!.userName,
      );
    } else {
      return WishModel(
        id: widget.interest!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        // Todo implement
        tags: 'Str.mockTags',
        userId: widget.interest!.userId,
        userName: widget.interest!.userName,
      );
    }
  }
}
