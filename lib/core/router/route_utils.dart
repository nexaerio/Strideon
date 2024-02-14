enum RouteConstant {
  //All Screen
  onboardingScreen,
  welcomeScreen,
  homeScreen,
  settingScreen,
  registerScreen,
  workSpaceScreen,

  //All Pages

  addTaskPage,
  loginPage,
  forgetPasswordPage,
  createWorkSpacePage,
  workSpaceBoard,
  modsToolsPage,
  addModsPage,
  editWorkSpacePage,
  strideBoardPage,
  strideBoardMenu,
  boardMenu,
  powerUp,
  copyBoard,
  boardSettings,
  selectBgColor,
  memberWorkSpace,
  inviteWorkSpaceMember,
  createBoardPage,
  profileEditPage,
  notificationPage,
  createView,
  createProjectView,
  joinProjectView,
}

extension Route on RouteConstant {
  String get getPath {
    return "/$name";
  }

  String get link {
    return "/:$name";
  }

  String get getSubPath {
    return name;
  }
}
