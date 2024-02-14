import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/error/error_page.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/feature/auth/controller/auth_controller.dart';
import 'package:strideon/feature/auth/views/auth_view/forget_password_page.dart';
import 'package:strideon/feature/auth/views/auth_view/login_page.dart';
import 'package:strideon/feature/auth/views/auth_view/register_screen.dart';
import 'package:strideon/feature/auth/views/welcome_screen.dart';
import 'package:strideon/feature/card_board/views/board_menu.dart';
import 'package:strideon/feature/card_board/views/create_board.dart';
import 'package:strideon/feature/card_board/views/select_board_bg.dart';
import 'package:strideon/feature/card_board/views/stride_board.dart';
import 'package:strideon/feature/onboarding/views/onboarding.dart';
import 'package:strideon/feature/settings/profile/profile_edit.dart';
import 'package:strideon/feature/settings/setting_screen.dart';
import 'package:strideon/feature/views/home/main_page.dart';
import 'package:strideon/feature/workspace/screen/add_mod_page.dart';
import 'package:strideon/feature/workspace/screen/edit_workspace.dart';
import 'package:strideon/feature/workspace/screen/mod_tools_page.dart';
import 'package:strideon/feature/workspace/screen/workspace_screen.dart';
import 'package:strideon/gobal/board_menu/board_menu.dart';
import 'package:strideon/gobal/notification/notification_page.dart';
import 'package:strideon/gobal/workspace/create_workspace_screen.dart';
import 'package:strideon/services/kanban/widget/create_project.dart';
import 'package:strideon/services/kanban/widget/join_project.dart';
import 'package:strideon/widgets/cardboard_widget/board_powerups.dart';
import 'package:strideon/widgets/cardboard_widget/board_settings.dart';
import 'package:strideon/widgets/cardboard_widget/copy_board.dart';
import 'package:strideon/widgets/cardboard_widget/invite_members.dart';
import 'package:strideon/widgets/cardboard_widget/members_workspace.dart';

final appRouterkey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangeProvider);

  return GoRouter(
      navigatorKey: appRouterkey,
      debugLogDiagnostics: true,
      initialLocation: RouteConstant.onboardingScreen.getPath,
      routes: [
        GoRoute(
            name: RouteConstant.welcomeScreen.name,
            path: RouteConstant.welcomeScreen.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const WelcomeScreen()),
        GoRoute(
            name: RouteConstant.onboardingScreen.name,
            path: RouteConstant.onboardingScreen.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const OnBoardingScreen()),
        GoRoute(
            name: RouteConstant.homeScreen.name,
            path: RouteConstant.homeScreen.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const HomePage()),
        GoRoute(
            name: RouteConstant.settingScreen.name,
            path: RouteConstant.settingScreen.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const SettingScreen()),
        GoRoute(
          path: '/homeScreen/:name',
          name: RouteConstant.workSpaceScreen.name,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: WorkSpaceScreen(name: state.pathParameters['name']!));
          },
        ),
        GoRoute(
          path: '/workSpaceScreen/:name',
          name: RouteConstant.modsToolsPage.name,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: ModsToolsPage(name: state.pathParameters['name']!));
          },
        ),
        GoRoute(
          path: '/modsToolsPage/:name',
          name: RouteConstant.editWorkSpacePage.name,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: EditWorkSpacePage(name: state.pathParameters['name']!));
          },
        ),
        GoRoute(
          name: RouteConstant.addModsPage.name,
          path: '/add-mods/:name',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: AddModsPage(name: state.pathParameters['name']!));
          },
        ),
        GoRoute(
          name: RouteConstant.strideBoardPage.name,
          path: '/project/:name',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: StrideBoard(name: state.pathParameters['name']!));
          },
        ),
        GoRoute(
            name: RouteConstant.registerScreen.name,
            path: RouteConstant.registerScreen.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const RegisterScreen()),

        GoRoute(
            name: RouteConstant.loginPage.name,
            path: RouteConstant.loginPage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const LoginPage()),

        GoRoute(
            name: RouteConstant.forgetPasswordPage.name,
            path: RouteConstant.forgetPasswordPage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const ForgetPasswordPage()),
        GoRoute(
            name: RouteConstant.createWorkSpacePage.name,
            path: RouteConstant.createWorkSpacePage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const CreateWorkSpacePage()),
        GoRoute(
            name: RouteConstant.profileEditPage.name,
            path: RouteConstant.profileEditPage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileEditPage()),
        GoRoute(
            name: RouteConstant.notificationPage.name,
            path: RouteConstant.notificationPage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const NotificationPage()),
        GoRoute(
            name: RouteConstant.strideBoardMenu.name,
            path: RouteConstant.strideBoardMenu.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const StrideBoardMenu()),
        GoRoute(
            name: RouteConstant.memberWorkSpace.name,
            path: RouteConstant.memberWorkSpace.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const MemberWorkspace()),
        GoRoute(
            name: RouteConstant.inviteWorkSpaceMember.name,
            path: RouteConstant.inviteWorkSpaceMember.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const InviteMember()),
        GoRoute(
            name: RouteConstant.createBoardPage.name,
            path: RouteConstant.createBoardPage.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const CreateBoardPage()),
        GoRoute(
            name: RouteConstant.selectBgColor.name,
            path: RouteConstant.selectBgColor.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const SelectBoardBackground()),
        GoRoute(
            name: RouteConstant.boardMenu.name,
            path: RouteConstant.boardMenu.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const BoardMenu()),
        GoRoute(
            name: RouteConstant.powerUp.name,
            path: RouteConstant.powerUp.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const PowerUps()),
        GoRoute(
            name: RouteConstant.copyBoard.name,
            path: RouteConstant.copyBoard.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const CopyBoard()),
        GoRoute(
            name: RouteConstant.boardSettings.name,
            path: RouteConstant.boardSettings.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const BoardSettings()),
        GoRoute(
            name: RouteConstant.createProjectView.name,
            path: RouteConstant.createProjectView.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const CreateProject()),
        GoRoute(
            name: RouteConstant.joinProjectView.name,
            path: RouteConstant.joinProjectView.getPath,
            builder: (BuildContext context, GoRouterState state) =>
                const JoinProject()),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorPage());
      },
      redirect: (context, state) {
        if (authState.isLoading || authState.hasError) return null;

        final isAuth = authState.valueOrNull != null;

        final isOnboarding =
            state.matchedLocation == RouteConstant.onboardingScreen.getPath;
        if (isOnboarding) {
          return isAuth
              ? RouteConstant.homeScreen.getPath
              : RouteConstant.onboardingScreen.getPath;
        }

        //Managing Auth Router Outside.

        final isLoggingIn =
            state.matchedLocation == RouteConstant.welcomeScreen.getPath;

        final isRLoggingIn =
            state.matchedLocation == RouteConstant.registerScreen.getPath;

        final isLLoggingIn =
            state.matchedLocation == RouteConstant.loginPage.getPath;

        final isFLoggingIn =
            state.matchedLocation == RouteConstant.forgetPasswordPage.getPath;

        if (isLoggingIn) {
          return isAuth ? RouteConstant.homeScreen.getPath : null;
        }

        if (isRLoggingIn) {
          return isAuth ? RouteConstant.homeScreen.getPath : null;
        }

        if (isLLoggingIn) {
          return isAuth ? RouteConstant.homeScreen.getPath : null;
        }

        if (isFLoggingIn) {
          return isAuth ? RouteConstant.homeScreen.getPath : null;
        }

        return isAuth ? null : RouteConstant.onboardingScreen.getPath;
      });
});
