import 'interest_model.dart';

class TempNavHistory {
  List<InterestModel?>? get interestsHistory => _interestsHistory;
  List<InterestModel?>? _interestsHistory;

  List<Map<String, dynamic>>? get chatPropertiesPackHistory =>
      _chatPropertiesPackHistory;
  List<Map<String, dynamic>>? _chatPropertiesPackHistory;

  void updateInterestsHistory(InterestModel? interest) {
    _interestsHistory ??= [];
    if (_interestsHistory!.isEmpty) {
      _interestsHistory!.add(interest);
      return;
    }
    if (_interestsHistory!.last == interest) {
      _interestsHistory!.removeLast();
    } else {
      _interestsHistory!.add(interest);
    }
  }

  void pushChatPropertiesPackHistory(Map<String, dynamic> chatPropertiesPack) {
    _chatPropertiesPackHistory ??= [];
    _chatPropertiesPackHistory!.add(chatPropertiesPack);
  }

  Map<String, dynamic>? popChatPropertiesPackHistory() {
    if (_chatPropertiesPackHistory == null ||
        _chatPropertiesPackHistory!.isEmpty) {
      return null;
    }
    return _chatPropertiesPackHistory!.removeLast();
  }
}
