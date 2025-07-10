abstract class Str {
  static const appTitle = 'Reach Skills';
  static const homeScreenTitle = 'ReachSkills - Home';
  static const profileScreenTitle = 'Profile';
  static const exploreScreenTitle = 'Interests';
  static const exploreScreenLabel = 'Explore';
  static const chatScreenTitle = 'Chat';
  static const messagesScreenTitle = 'Messages';
  static const unknownScreenMessage = 'Unknown Screen';
  static const screenNotFoundMessage = '404\nScreen Not Found';

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
  static const detailsScreenRouteName = 'details';
  // static const interestScreenRoutePath = '/interest';
  // static const detailsScreenRoutePath = '/:id';
  // static const detailsScreenRouteFullPath = '/details/:id';
  static const detailsScreenRoutePath = '/details/:id';

  static const messagesScreenParamId = 'id';
  static const detailsScreenParamId = 'id'; // only for deep linking

  /// Routes end


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

  static const account = 'Account';
  static const name = 'Name';
  static const required = 'Required';
  static const bio = 'Bio';
  static const skillsInputDescription = 'Skills (comma-separated)';
  static const wishesInputDescription = 'Wishes (comma-separated)';
  static const email = 'Email';
  static const lastUpdated = 'Last updated';
  static const daysAgo = 'days ago';

  static const saveProfile = 'Save Profile';
  static const fillRequiredFields = 'Please fill in all required fields.';
  static const unknownErrorSignAgain =
      'Unknown Error. Try signing out and signing in again.';
  static const noChanges = 'No changes to save';
  static const profileSaved = 'Profile Saved';

  static const skill = 'Skill';
  static const wish = 'Wish';

  static const by = 'by';
  static const type = 'Type';
  static const tags = 'Tags';

  static const mockInterestTitle = 'Graphic Design';
  static const mockUserName = 'Ethan Carter';
  static const mockInterestDescription = 'I\'m looking to learn how to play the guitar.\nI\'m a beginner and would love to find someone who can teach me the basics. I\'m available for lessons on weekends.';
  static const mockTags = ['Guitar', 'Music', 'Lessons', 'Art'];
  static const mockEmail = 'william.henry.harrison@example-pet-store.com';
}
