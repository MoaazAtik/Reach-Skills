abstract class Str {
  static const appTitle = 'Reach Skills';
  static const homeScreenTitle = 'ReachSkills - Home';
  static const profileScreenTitle = 'Profile';
  static const exploreScreenTitle = 'Interests';
  static const exploreScreenLabel = 'Explore';
  static const chatScreenTitle = 'Chats';
  static const messagesScreenTitle = 'Reach';
  static const authScreenTitle = 'Authentication';
  static const helpScreenTitle = 'Help';
  static const unknownScreenMessage = 'Unknown Screen';
  static const screenNotFoundMessage = '404\nScreen Not Found';
  static const _separator = ';;;';

  /// The 'space' after the separator is Very Important
  static const splitWithSeparator = '$_separator ';

  /// Routes start

  static const exploreScreenRouteName = 'explore';
  static const exploreScreenRoutePath = '/';
  static const chatScreenRouteName = 'chat';
  static const chatScreenRoutePath = '/chat';
  static const messagesScreenRouteName = 'messages';

  /* When used as subroute of a StatefulShellBranch,
  '/:id' is equivalent to ':id' */
  static const messagesScreenRoutePath = '/:id';
  static const messagesScreenRouteFullPath = '/chat/:id';
  static const profileScreenRouteName = 'profile';
  static const profileScreenRoutePath = '/profile';

  // static const interestScreenRouteName = 'interest';
  static const detailsExploreScreenRouteName = 'detailsExplore';
  static const detailsProfileScreenRouteName = 'detailsProfile';

  // static const interestScreenRoutePath = '/interest';
  // static const detailsScreenRoutePath = '/:id';
  // static const detailsScreenRouteFullPath = '/details/:id';
  static const detailsExploreScreenRouteFullPath =
      '${exploreScreenRoutePath}details/:id';
  static const detailsProfileScreenRouteFullPath =
      '$profileScreenRoutePath/details/:id';
  static const detailsScreenRoutePath = '/details/:id';
  static const authScreenRouteName = 'auth';
  static const authScreenRoutePath = '/auth';
  static const helpScreenRouteName = 'help';
  static const helpScreenRoutePath = '/help';
  static const onboardingScreenRouteName = 'onboarding';
  static const onboardingScreenRoutePath = '/onboarding';

  static const messagesScreenParamChatId = 'id'; // only for deep linking
  static const messagesScreenParamCurrentSenderId = 'currentSenderId';
  static const messagesScreenParamCurrentSenderName = 'currentSenderName';
  static const messagesScreenParamCurrentReceiverId = 'currentReceiverId';
  static const messagesScreenParamCurrentReceiverName = 'currentReceiverName';
  static const detailsScreenParamId = 'id'; // only for deep linking
  static const detailsScreenParamInterest = 'interest';
  static const detailsScreenParamFromPath = 'fromPath';
  static const detailsScreenParamStartEditing = 'startEditing';

  /// Routes end

  /// Model fields start

  /// Profile model fields
  static const String PROFILE_COLLECTION_NAME = 'profiles';
  static const String PROFILE_FIELD_UID = 'uid';
  static const String PROFILE_FIELD_NAME = 'name';
  static const String PROFILE_FIELD_EMAIL = 'email';
  static const String PROFILE_FIELD_BIO = 'bio';
  static const String PROFILE_FIELD_INTERESTS = 'interests';
  static const String PROFILE_FIELD_LAST_EDITED_TIME = 'lastEditedTime';

  /// Chat model fields
  static const String CHAT_COLLECTION_NAME = 'chats';
  static const String CHAT_FIELD_ID = 'id';
  static const String CHAT_FIELD_PERSON1_ID = 'person1Id';
  static const String CHAT_FIELD_PERSON1_NAME = 'person1Name';
  static const String CHAT_FIELD_PERSON2_ID = 'person2Id';
  static const String CHAT_FIELD_PERSON2_NAME = 'person2Name';
  static const String CHAT_FIELD_CREATED_AT = 'createdAt';
  static const String CHAT_FIELD_UPDATED_AT = 'updatedAt';

  /// Message model fields
  static const String MESSAGE_COLLECTION_NAME = 'messages';
  static const String MESSAGE_FIELD_ID = 'id';
  static const String MESSAGE_FIELD_CHAT_ID = 'chatId';
  static const String MESSAGE_FIELD_SENDER_ID = 'senderId';
  static const String MESSAGE_FIELD_SENDER_NAME = 'senderName';
  static const String MESSAGE_FIELD_RECEIVER_ID = 'receiverId';
  static const String MESSAGE_FIELD_RECEIVER_NAME = 'receiverName';
  static const String MESSAGE_FIELD_CREATED_AT = 'createdAt';
  static const String MESSAGE_FIELD_UPDATED_AT = 'updatedAt';
  static const String MESSAGE_FIELD_CONTENT = 'content';

  /// Interest (Skill / Wish) model fields
  static const String INTEREST_COLLECTION_NAME = 'interests';
  static const String INTEREST_FIELD_INTEREST_TYPE = 'interestType';
  static const String INTEREST_FIELD_ID = 'id';
  static const String INTEREST_FIELD_TITLE = 'title';
  static const String INTEREST_FIELD_DESCRIPTION = 'description';
  static const String INTEREST_FIELD_TAGS = 'tags';
  static const String INTEREST_FIELD_USER_ID = 'userId';
  static const String INTEREST_FIELD_USER_NAME = 'userName';

  /// Old model fields (Deprecated)
  // static const String PROFILE_FIELD_SKILLS = 'skills';
  // static const String PROFILE_FIELD_WISHES = 'wishes';

  /// Model fields end

  /// Localizable strings start

  static const error = 'Error';

  static const filterAll = 'All';

  static const searchHint = 'Search interests...';
  static const pleaseSignIn = 'Please sign in.';
  static const cannotReachYourself = 'Trying to reach yourself?';
  static const serverErrorMessage =
      'Server error.\nPlease contact our support team or try again later.';

  static const noUserInfoMessage = 'No user info available.';
  static const noChatsMessage = 'No chats available.';
  static const noMessagesMessage = 'No messages available.';
  static const noSkillsFound = 'No skills found';

  static const createdBy = 'Created by';
  static const updatedAt = 'Updated at';
  static const to = 'To';

  static const signIn = 'Sign in';
  static const signOut = 'Sign out';
  static const editProfile = 'Edit Profile';
  static const help = 'Help';
  static const loggedIn = 'Logged in';

  static const notLoggedIn = 'Not logged in';
  static const explore = 'Explore';
  static const interests = 'interests';
  static const reach = 'Reach';
  static const save = 'Save';
  static const interestTitle = 'Interest Title';
  static const interestTitleHint = 'eg, Graphic Design or Painting...';
  static const interestDescription = 'Description';
  static const interestDescriptionHint =
      'A short description of the interest...';
  static const interestTags = 'Tags';
  static const interestTagsHint = 'eg, Guitar, Music, Art, Programming...';
  static const send = 'SEND';
  static const messageHint = 'Leave a message';
  static const emptyMessageError = 'Enter your message to continue';

  static const account = 'Account';
  static const name = 'Name';
  static const required = 'Required';
  static const validatorMax5Tags = 'Reached Maximum of 5 tags';
  static const bio = 'Bio';
  static const nameHint = 'Enter your name...';
  static const bioHint = 'A short bio about yourself...';
  static const skillsInputDescription = 'Skills (comma-separated)';
  static const wishesInputDescription = 'Wishes (comma-separated)';
  static const email = 'Email';
  static const lastUpdated = 'Last updated';
  static const today = 'Today';
  static const yesterday = 'Yesterday';
  static const daysAgo = 'days ago';
  static const errorFetchingEmail = 'Could not fetch email';

  static const saveProfile = 'Save Profile';
  static const fillRequiredFields = 'Please fill in all required fields.';
  static const unknownErrorSignAgain =
      'Unknown Error. Try signing out and signing in again.';
  static const noChanges = 'No changes to save';
  static const profileSaved = 'Profile Saved';
  static const errorSavingProfile = 'Could not save profile';

  static const skill = 'Skill';
  static const wish = 'Wish';

  static const by = 'by';
  static const type = 'Type';
  static const tags = 'Tags';

  static const contactUs = 'Contact Us';
  static const supportEmail = 'info.thewhitewings@gmail.com';
  static const onboardingGuide = 'Onboarding Guide';
  static const poweredBy = 'Powered by';
  static const whiteWings = 'White Wings';

  static const onboarding0Title = 'Connect, Share, Grow';
  static const onboarding0Description =
      'Reach Skills is a vibrant community where you can exchange skills, pursue your aspirations, and connect with like-minded individuals.';

  static const onboarding1Title = 'What are Interests?';
  static const onboarding1Description =
      'Interests are the core of Reach Skills. They represent what you can offer (Skills) and what you\'re looking for (Wishes).';
  static const skills = 'Skills';
  static const skillsDefinition = 'What you can offer to others';
  static const wishes = 'Wishes';
  static const wishesDefinition = 'What you want to learn or receive help with';
  static const skillsReachDefinition =
      'Connect with others who share your skills. Collaborate on projects, exchange ideas, and grow together.';
  static const wishesReachDefinition =
      'Find others with similar goals and support each other\'s journeys.';
  static const skillForWishReachDefinition =
      'Exchange your skills for wishes.\nOffer your skills to help others achieve their wishes, and vice versa.';
  static const skillForWish = 'Skill for Wish';

  static const getStarted = 'Get Started';
  static const next = 'Next';
  static const letsGo = 'Let\'s Go';

  static const undo = 'Undo';
  static const removed = 'Removed';

  /// Localizable strings end

  /// Mock data start

  static const mockDaysAgo = 'x days ago';
  static final mockDateTimeObject = DateTime(2025, 7, 1);
  static const mockInterestTitle = 'Graphic Design';
  static const mockSkillsTitles = [
    'Web Development',
    'Illustration',
    'Graphic Design',
  ];
  static const mockWishesTitles = [
    'Piano',
    'Content Writing',
    'Latte Art',
    'Digital Marketing',
  ];
  static const mockInterestsTitles = [
    'Web Development',
    'Illustration',
    'Graphic Design',
    'Piano',
    'Content Writing',
    'Latte Art',
    'Digital Marketing',
  ];
  static const mockInterestId = 'someMockInterestId';
  static const mockUserId = 'someMockUserId';
  static const mockUserName = 'Ethan Carter';
  static const mockUserName2 = 'Liam Johannes';
  static const mockInterestDescription =
      'I\'m looking to learn how to play the guitar.\nI\'m a beginner and would love to find someone who can teach me the basics. I\'m available for lessons on weekends.';
  static const mockTags = ['Guitar', 'Music', 'Lessons', 'Art'];
  static const mockEmail = 'william.henry.harrison@example-pet-store.com';
  static const mockMessage1 =
      'I\'ve found some great resources for learning Spanish. Let\'s schedule a session!';
  static const mockMessage2 =
      'I\'ve been working on my graphic design portfolio. Let me know if you need any feedback.';
  static const mockMessage3 =
      'I\'m  interested  in  learning  how  to  play  the  guitar.  I  can  teach  you  how  to  code  in  Python  in  return.';
  static const mockMessage4 =
      'That  sounds  like  a  great  exchange!  I\'m  excited  to  get  started.  When  are  you  available?';

  /// Mock data end

  /// Exception messages start

  static const excMessageNullId = 'Passed "null ID".';
  static const excMessageNullUserId = 'Passed "null User ID".';
  static const excMessageNullPerson1Id = 'Passed "null Person 1 ID".';
  static const excMessageNullPerson2Id = 'Passed "null Person 2 ID".';
  static const excMessageNullChatId = 'Passed "null Chat ID".';
  static const excMessageNullSenderId = 'Passed "null Sender ID".';
  static const excMessageNullCurrentSenderId =
      'Passed "null Current Sender ID".';
  static const excMessageNullReceiverId = 'Passed "null Receiver ID".';
  static const excMessageNullTitle = 'Passed "null Title".';
  static const excMessageNullUserName = 'Passed "null User Name".';
  static const excMessageNullEmail = 'Passed "null Email".';
  static const excMessageNullOnTapSave = 'Passed "null onTapSave".';
  static const excMessageNullOnTapReach = 'Passed "null onTapReach".';
  static const excMessageNullAppBarActions =
      '"appBarEditAction" is false but onTapSignIn, onTapSignOut,'
      ' onTapEditProfile, or onTapHelp is null.'
      ' They are required for the popup menu button (RsPopupMenuButton).';
  static const excMessageNullUser = 'Passed "null user".';

  static const excMessageMin1 = 'Pass at least 1 of them.';
  static const excMessageExtraNotMap = '`extra` is not a Map.';
  static const excMessageNullFields = 'One or more fields are null.';
  static const excMessageNullFirebaseAuthCurrentUser =
      'Null `FirebaseAuth.instance.currentUser`.';

  static const excMessageMissingChatPropertiesPack =
      'Missing "chat properties pack" fields.';
  static const excMessageInterestFromPathCheck =
      '`interest` is null or not an InterestModel.'
      ' Or `fromPath` is null or not a String.';
  static const excMessageUserIdAndNameStream =
      'Error getting current user\'s id and name.';

  static const excMessageInterestModelFromMap =
      'Check `map` passed to `InterestModel.fromMap` constructor.';
  static const excMessageProfileModelFromMap =
      'Check `map` passed to `ProfileModel.fromMap` constructor.';
  static const excMessageChatModelFromMapAndId =
      'Check data passed to `ChatModel.fromMapAndId` constructor.';
  static const excMessageMessageModelFromMapAndId =
      'Check data passed to `MessageModel.fromMapAndId` constructor.';
  static const excMessageInterestDetails =
      'Check `InterestDetails` build method.';
  static const excMessageInterestDetailsReach = 'Check `onTapReach` method.';
  static const excMessageScaffoldAppBarBodies = 'Check `ScaffoldAppBarBodies`.';
  static const excMessageStartAllChatsSubscription =
      'Check `startAllChatsSubscription`';
  static const excMessagePackChattersProperties =
      'Check `packChattersProperties`';
  static const excMessageOnTapChat = 'Check `onTapChat`';
  static const excMessageUpdateFields = 'Check `updateFields`';
  static const excMessage_messagesScreenBuilder =
      'Check `_messagesScreenBuilder`';
  static const excMessageStartMessagesSubscription =
      'Check `startMessagesSubscription`';
  static const excMessage_buildInterestDetails =
      'Check `buildInterestDetails`.';
  static const excMessageSendMessage = 'Check `sendMessage`.';
  static const excMessageSubscribeToUserIdAndNameStream =
      'Check `subscribeToUserIdAndNameStream`.';
  static const excMessageUpdateUserName = 'Check `updateUserName`.';

  static const excMessageFileRouting = 'routing.dart';

  /// Exception messages end
}
