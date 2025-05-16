import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:ai_doc/main.dart' as app;

void main() {
  setUrlStrategy(PathUrlStrategy());
  app.main();
}