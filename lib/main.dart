import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/common/presentation/app_base_widget.dart';
import 'package:shopzy/common/utils/custom_provider_observer.dart';
import 'package:shopzy/common/utils/q_logger.dart';
import 'package:shopzy/config/env.dart';
import 'package:shopzy/generated/l10n.dart';
import 'package:shopzy/main/app_environment.dart';
import 'package:shopzy/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvInfo.initialize(environment);
  _registerErrorHandlers();
  Loggy.initLoggy(
    logPrinter:
        !EnvInfo.isProduction || kDebugMode
            ? StreamPrinter(PrettyDeveloperPrinter())
            : DisabledPrinter(),
  );
  if (!kDebugMode) {
    await SentryFlutter.init((options) => options.dsn = 'DSN');
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      observers: [CustomProviderObserver()],
      child: RootAppWidget(),
    ),
  );
}

class RootAppWidget extends ConsumerWidget {
  const RootAppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseRouter = ref.watch(baseRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: EnvInfo.environment != AppEnvironment.PROD,
      title: EnvInfo.appTitle,
      theme: primaryTheme,
      darkTheme: secondaryTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerDelegate: baseRouter.routerDelegate,
      routeInformationParser: baseRouter.routeInformationParser,
      routeInformationProvider: baseRouter.routeInformationProvider,
      builder:
          (context, child) => Material(
            type: MaterialType.transparency,
            child: AppStartupWidget(onLoaded: (_) => child ?? SizedBox()),
          ),
    );
  }
}

final _appStartupProvider = FutureProvider((ref) async {
  // here you can initialize all async dependencies like Firebase, SharedPreferences, etc.
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
});

class AppStartupWidget extends ConsumerWidget {
  final WidgetBuilder onLoaded;

  const AppStartupWidget({super.key, required this.onLoaded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(_appStartupProvider);
    return appStartupState.when(
      loading: () => SizedBox(),
      error:
          (error, stackTrace) => MaterialApp(
            home: Scaffold(body: Center(child: Text(error.toString()))),
          ),
      data: (_) => AppBaseWidget(onLoaded(context)),
    );
  }
}

void _registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  ErrorWidget.builder =
      (FlutterErrorDetails details) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.red, title: Text('Error')),
        body: Center(child: Text(details.toString())),
      );
}
