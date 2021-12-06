import 'package:get_it/get_it.dart';
import 'package:lang/providers/verbprovider.dart';

GetIt backend = GetIt.instance;

setup() {
  backend.registerLazySingleton(() => VerbProvider());
}
