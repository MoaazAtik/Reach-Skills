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
    required this.interest,
    this.onTapReach,
    this.onTapSave,
    this.startEditing = false,
  });

  final bool startEditing;

  final InterestModel? interest;
  final void Function()? onTapReach;

  /// Don't pass a lambda when coming from Explore screen
  /// and pass when coming from Profile screen
  final void Function(InterestModel interest)? onTapSave;

  @override
  State<InterestDetails> createState() => _InterestDetailsState();
}

class _InterestDetailsState extends State<InterestDetails> {
  late bool isEditing;

  final _formKey = GlobalKey<FormState>(debugLabel: '_InterestBodyState');
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late InterestType? _selectedInterestType;
  late String _tags;

  @override
  void initState() {
    super.initState();
    isEditing = widget.startEditing;
    _selectedInterestType = widget.interest?.interestType ?? InterestType.skill;
    _tags = widget.interest?.tags ?? '';
    _titleController = TextEditingController(text: widget.interest?.title);
    _descriptionController = TextEditingController(
      text: widget.interest?.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Styles.paddingMedium),
      // Todo wrap this Column with a Form to validate title and empty tags
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
                      _titleController.text.isNotEmpty
                          ? _titleController.text
                          : Str.interestTitle,
                      style: Styles.interestDetailsTitleTextStyle,
                    ),
                  if (isEditing)
                    Form(
                      key: _formKey,
                      /* Utilized a 'Container' to fix TextFormField's
                         'Assertion failed: constraints.maxWidth < double.infinity' */
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.4,
                        ),
                        child: TextFormField(
                          decoration: Styles.rsInputDecoration(
                            label: Str.interestTitle,
                            hint: Str.interestTitleHint,
                            fillColor: Styles.getChipColor(
                              _selectedInterestType!,
                            ),
                          ),
                          controller: _titleController,
                          validator: textValidator,
                        ),
                      ),
                    ),
                  Text(
                    '${Str.by} ${widget.interest?.userName}',
                    style: Styles.interestDetailsUserTextStyle,
                  ),
                ],
              ),

              if (widget.onTapSave != null) // ie, can edit
                IconButton(
                  onPressed: () {
                    if (isEditing) {
                      if (!_formKey.currentState!.validate()) return;
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
              _descriptionController.text.isNotEmpty
                  ? _descriptionController.text
                  : '',
              style: Styles.interestDetailsDescriptionTextStyle,
            ),
          if (isEditing)
            TextFormField(
              decoration: Styles.rsInputDecoration(
                label: Str.interestDescription,
                hint: Str.interestDescriptionHint,
                withConstrains: true,
                maxWidthRatio: 0.6,
                context: context,
                fillColor: Styles.getChipColor(_selectedInterestType!),
              ),
              minLines: 1,
              maxLines: 3,
              controller: _descriptionController,
            ),

          SizedBox(height: 24),
          Text(Str.type, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: 16),
          if (!isEditing)
            RsChip(
              chipColor: Styles.getChipColor(_selectedInterestType!),
              children: [
                Text(
                  _selectedInterestType!.asTitle,
                  style: Styles.interestChipTextStyle,
                ),
              ],
            ),
          if (isEditing)
            Row(
              children: [
                RsChip(
                  paddingLeft: Styles.paddingSmall,
                  onTap: () => _setInterestType(InterestType.skill),
                  children: [
                    Radio(
                      value: InterestType.skill,
                      groupValue: _selectedInterestType,
                      onChanged: _setInterestType,
                    ),
                    Text(Str.skill, style: Styles.interestChipTextStyle),
                  ],
                ),
                SizedBox(width: Styles.spacing12),
                RsChip(
                  paddingLeft: Styles.paddingSmall,
                  chipColor: Styles.wishChipBackgroundColor,
                  onTap: () => _setInterestType(InterestType.wish),
                  children: [
                    Radio(
                      value: InterestType.wish,
                      groupValue: _selectedInterestType,
                      onChanged: _setInterestType,
                    ),
                    Text(Str.wish, style: Styles.interestChipTextStyle),
                  ],
                ),
              ],
            ),

          SizedBox(height: 24),
          Text(Str.tags, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: Styles.spacingMedium),
          Wrap(
            spacing: Styles.spacing12,
            runSpacing: Styles.spacing12,
            children: _buildTagsChips(tags: _tags),
          ),

          SizedBox(height: 56),
          // if Not owner Or Is editing
          if ((widget.onTapSave == null) || isEditing)
            FilledButton(
              onPressed: () {
                if (isEditing) {
                  if (widget.onTapSave != null) {
                    if (!_formKey.currentState!.validate()) return;
                    widget.onTapSave!(_assembleInterest());
                    setState(() => isEditing = !isEditing);
                  } else {
                    throw Exception(
                      '${Str.excMessageNullOnTapSave} ${Str.excMessageInterestDetails}',
                    );
                  }
                } else if (widget.onTapReach != null) {
                  widget.onTapReach!();
                } else {
                  throw Exception(
                    '${Str.excMessageNullOnTapSave} ${Str.excMessageNullOnTapReach} ${Str.excMessageMin1} ${Str.excMessageInterestDetails}',
                  );
                }
              },
              child: Text(
                isEditing ? Str.save : Str.reach,
                style: Styles.rsFilledButtonTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTagsChips({required String tags}) {
    /* This '[]' fixes 'tagsList.length = 1' caused by 'tags.split'
     when tags are empty. */

    final List<String> tagsList =
        tags.isNotEmpty ? tags.split(Str.splitWithSeparator) : [];

    final List<Widget> chips = List.generate(tagsList.length, (index) {
      return RsChip(
        chipColor: Styles.getChipColor(_selectedInterestType!),
        onLongPress: !isEditing ? null : () => _removeTag(tagsList, index),
        children: [Text(tagsList[index], style: Styles.interestChipTextStyle)],
      );
    });

    final TextEditingController tagsController = TextEditingController();

    if (!isEditing) return chips;

    chips.insert(
      chips.length,
      RsChip(
        onTap: () => _addTag(tagsController.text.trim(), tagsList.length),
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        chipColor: Styles.getChipColor(_selectedInterestType!),
        children: [
          if (chips.length < 5)
            TextField(
              controller: tagsController,
              decoration: Styles.rsInputDecoration(
                hint: Str.interestTagsHint,
                withConstrains: true,
                context: context,
              ),
              onSubmitted: (value) => _addTag(value.trim(), tagsList.length),
            ),
          Icon(Icons.add_rounded, size: 20),
        ],
      ),
    );

    return chips;
  }

  void _addTag(String? tag, int previousTagsListLength) {
    if (previousTagsListLength >= 5) {
      showSnackBarMessage(context, Str.validatorMax5Tags);
      return;
    }
    if (tag == null || tag.isEmpty) {
      showSnackBarMessage(context, Str.required);
      return;
    }

    setState(
      () =>
          _tags.isNotEmpty
              ? _tags += '${Str.splitWithSeparator}$tag'
              : _tags += tag,
    );
  }

  void _removeTag(List<String> tagsList, int index) {
    tagsList.removeAt(index);
    setState(() => _tags = tagsList.join(Str.splitWithSeparator));
  }

  InterestModel _assembleInterest() {
    if (_selectedInterestType == InterestType.skill) {
      return SkillModel(
        id: widget.interest!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        tags: _tags,
        userId: widget.interest!.userId,
        userName: widget.interest!.userName,
      );
    } else {
      return WishModel(
        id: widget.interest!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        tags: _tags,
        userId: widget.interest!.userId,
        userName: widget.interest!.userName,
      );
    }
  }

  void _setInterestType(InterestType? value) {
    setState(() => _selectedInterestType = value);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
