
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shopzy/main/app_environment.dart';

final packageInfoServiceProvider = Provider<PackageInfoService>(
  (ref) => PackageInfoServiceImpl(),
);

abstract interface class PackageInfoService {
  Future<String> getVersionNumber();
}

class PackageInfoServiceImpl implements PackageInfoService {
  @override
  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version}${!EnvInfo.isProduction ? '+${packageInfo.buildNumber} (${EnvInfo.envName.toUpperCase()})' : ''}';
  }
}
