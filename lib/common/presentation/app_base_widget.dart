
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/common/domain/providers/global_navigation_provider.dart';
import 'package:shopzy/common/domain/router/route_action.dart';

class AppBaseWidget extends ConsumerStatefulWidget {
  final Widget child;

  const AppBaseWidget(this.child, {super.key});

  @override
  ConsumerState createState() => _AppBaseWidgetState();
}

class _AppBaseWidgetState extends ConsumerState<AppBaseWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(appTrackingTransparencyChannelProvider).requestTracking();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if you need context to showDialog or bottomSheet, use BaseRouter's navigatorContext because main context
    // won't work as BaseWidget is the first widget in builder method of MaterialApp.router so Navigator is not ready yet.
    // Be careful not to use it directly in build method (it is not ready yet), but in button callback or within
    // WidgetsBinding.instance.addPostFrameCallback.
    // final navigatorContext = ref.read(baseRouterProvider).navigatorContext;
    ref.globalNavigationListener();
    return BaseWidget(
      onGlobalFailure: _onGlobalFailure,
      onGlobalInfo: _onGlobalInfo,
      child: widget.child,
    );
  }

  void _onGlobalFailure(Failure failure) {
    logError('''
        showing ${failure.isCritical ? '' : 'non-'}critical failure with 
        title ${failure.title}, 
        error: ${failure.error},
        stackTrace: ${failure.stackTrace}
      ''');
    // use WidgetsBinding.instance.addPostFrameCallback to show a toast or snackbar
  }

  void _onGlobalInfo(GlobalInfo globalInfo) {
    logInfo('''
        globalInfoStatus: ${globalInfo.globalInfoStatus}
        title: ${globalInfo.title}, 
        message: ${globalInfo.message},
      ''');
    // use WidgetsBinding.instance.addPostFrameCallback to show a toast or snackbar
  }
}

extension _WidgetRefExtensions on WidgetRef {
  void globalNavigationListener() {
    listen<RouteAction?>(
      globalNavigationProvider,
      (_, state) => state?.execute(read(baseRouterProvider)),
    );
  }
}
