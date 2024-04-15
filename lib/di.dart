import 'package:four_gemini/app/presentation/home/home_notifier.dart';
import 'package:get_it/get_it.dart';
final sl = GetIt.instance;

void initDi(){
  sl.registerFactory<HomeNotifier>(() => HomeNotifier());
}