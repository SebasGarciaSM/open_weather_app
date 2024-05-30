import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_weather_app/pages/details_page.dart';
import 'package:open_weather_app/pages/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/details_page',
        child: (context) => DetailsPage(locationModel: r.args.data));
  }
}
