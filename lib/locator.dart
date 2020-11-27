import 'package:doemoring/service/api.dart';
import 'package:get_it/get_it.dart';

import 'provider/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLoctor(){
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => CRUDModel( ));
}