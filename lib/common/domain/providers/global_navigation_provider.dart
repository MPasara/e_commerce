import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/domain/router/route_action.dart';

final globalNavigationProvider = StateProvider<RouteAction?>((_) => null);
