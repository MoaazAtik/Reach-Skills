import 'interest_model.dart';

class TempNavHistory {
  List<InterestModel?>? _interestsHistory;
  List<Map<String, dynamic>>? _chatPropertiesPackHistory;

  void pushInterestsHistory(InterestModel? interest) {
    _interestsHistory ??= [];
    _interestsHistory!.add(interest);
  }

  InterestModel? popInterestsHistory() {
    if (_interestsHistory == null || _interestsHistory!.isEmpty) {
      return null;
    }
    return _interestsHistory!.removeLast();
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
