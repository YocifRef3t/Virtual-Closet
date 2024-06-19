import 'package:go_router/go_router.dart';
import 'package:virtual_closet/core/models/my_user_model.dart';
import 'package:virtual_closet/core/models/outfit_model.dart';
import 'package:virtual_closet/feature/auth/presentation/view/login_view.dart';
import 'package:virtual_closet/feature/auth/presentation/view/register_view.dart';
import 'package:virtual_closet/feature/home/presentation/view/preview_outfit_view.dart';
import 'package:virtual_closet/feature/home/presentation/view/search_result_view.dart';
import 'package:virtual_closet/feature/outfit/presentation/view/make_outfit_view.dart';
import 'package:virtual_closet/feature/splash/presentation/view/splah_view.dart';

import '../../feature/home/presentation/view/home.dart';

abstract class AppRouter {
  static const kHomeViewPath = "/HomeViewPath";
  static const kLoginViewPath = "/LoginViewPath";
  static const kRegisterViewPath = "/RegisterViewPath";
  static const kMakeOutfitViewPath = "/MakeOutfitViewPath";
  static const kSearchResultViewPath = "/SearchResultViewPath";
  static const kPreviewOutfitViewPath = "/PreviewOutfitViewPath";
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginViewPath,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kRegisterViewPath,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: kHomeViewPath,
        builder: (context, state) => Home(
          user: state.extra as MyUserModel,
        ),
      ),
      GoRoute(
        path: kMakeOutfitViewPath,
        builder: (context, state) => MakeOutFitView(
          user: state.extra as MyUserModel,
        ),
      ),
      GoRoute(
        path: kPreviewOutfitViewPath,
        builder: (context, state) {
          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return PreviewOutfitView(
            outfit: data['outfit'] as OutfitModel,
            user: data['user'] as MyUserModel,
          );
        },
      ),
      GoRoute(
        path: kSearchResultViewPath,
        builder: (context, state) {
          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return SearchResultView(
            data: data['data'] as Map<String, dynamic>,
            user: data['user'] as MyUserModel,
          );
        },
      ),
    ],
  );
}
