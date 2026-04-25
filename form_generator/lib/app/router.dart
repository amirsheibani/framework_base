import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:form_generator/features/main_layout/presentation/pages/main_layout.dart';
import 'package:form_generator/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';


class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}


enum AppRouterPath{
  splash('/splash'),
  mainLayout('/'),
  ;



  final String path;
  const AppRouterPath(this.path);
}

final appRouter = GoRouter(
  observers: [
    // ChuckerFlutter.navigatorObserver,
  ],
  initialLocation: AppRouterPath.splash.path,
  refreshListenable: GoRouterRefreshStream(AppLinks().uriLinkStream),
  redirect: (context,state){
    // final loggedIn = true;
    // final isAuthRoute = state.matchedLocation.startsWith('/auth');
    // final isSplash = state.matchedLocation == '/splash';
    //
    // if (isSplash) return null;
    // if (!loggedIn && !isAuthRoute) return '/auth/login';
    // if (loggedIn && isAuthRoute) return '/';



    return null;
  },
  routes: [
    GoRoute(
      path: AppRouterPath.splash.path,
      builder: (_, __) => const SplashPage(),
    ),

    GoRoute(
      path: AppRouterPath.mainLayout.path,
      builder: (_, __) => const MainLayout(),
    ),


  ],
);