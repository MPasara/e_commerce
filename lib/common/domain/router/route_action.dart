// ignore_for_file: avoid_dynamic
import 'package:shopzy/common/domain/router/base_router.dart';

abstract class RouteAction {
  final String routeName;
  final dynamic data;

  const RouteAction([this.routeName = '', this.data]);

  void execute(BaseRouter baseRouter);

  @override
  String toString() => routeName;
}

class PushNamedAction extends RouteAction {
  PushNamedAction(super.routeName, super.data);

  @override
  void execute(BaseRouter baseRouter) =>
      baseRouter.pushNamed(routeName, data: data);
}

class PopAction extends RouteAction {
  @override
  void execute(BaseRouter baseRouter) => baseRouter.pop();
}

class PushReplacementNamedAction extends RouteAction {
  PushReplacementNamedAction(super.routeName, super.data);

  @override
  void execute(BaseRouter baseRouter) =>
      baseRouter.pushReplacementNamed(routeName, data: data);
}

class StackNamedAction extends RouteAction {
  StackNamedAction(super.routeName, super.data);

  @override
  void execute(BaseRouter baseRouter) =>
      baseRouter.stackNamed(routeName, data: data);
}
