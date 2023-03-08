/// Support for doing something awesome.
///
/// More dartdocs go here.
@JS()
library onfido_web_sdk;

import 'package:js/js.dart';
import 'dart:html' as html;

export 'src/onfido_web_sdk_base.dart';

// Load the Onfido Web SDK JavaScript file.
Future<void> loadSdk() async {
  final script = html.ScriptElement();
  script.src =
  'https://assets.onfido.com/web-sdk-releases/11.0.0/onfido.min.js';
  script.async = true;
  script.defer = true;
  html.document.body?.children.add(script);
}

void start({
  required String token,
  required Function onComplete,
  required List<String> steps,
  bool useModal = false,
}) {
  Onfido().init(token, useModal, onComplete, steps);
}


@JS()
@staticInterop
class Onfido {
  external factory Onfido();
}

extension on Onfido {
  external void init(String token, bool useModal, Function onComplete, List<String> steps);
}