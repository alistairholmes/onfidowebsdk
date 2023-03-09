/// Support for doing something awesome.
///
/// More dartdocs go here.
@JS()
library onfido_web_sdk;

import 'package:js/js.dart';

export 'src/onfido_web_sdk_base.dart';

// Load the Onfido Web SDK JavaScript file.
Future<void> loadSdk() async {
  // final script = html.ScriptElement();
  // script.src =
  // 'https://assets.onfido.com/web-sdk-releases/12.0.0/onfido.min.js';
  // script.async = true;
  // script.defer = true;
  // html.document.body?.children.add(script);
}

@JS('Onfido')
@staticInterop
class Onfido {
  external static dynamic init(dynamic);
}

@JS('console.log')
external void log(dynamic str);

void start({
  required String token,
  required Function onComplete,
  required List<String> steps,
  String containerId = 'onfido-mount',
  bool useModal = false,
}) {
  // log('starting onfido $options');
  final init = allowInterop(Onfido.init);
  init({
    token: token,
    steps: steps,
    containerId: containerId,
    onComplete: allowInterop((data) {
      log('ON COMPLETE! $data');
      onComplete(data);
    }),
    useModal: useModal,
  });
}

class Opts {
  final String token;
  final List<String> steps;
  final String containerId;
  final Function onComplete;
  final bool useModal;

  Opts({
    required this.token,
    required this.steps,
    required this.onComplete,
    this.containerId = 'onfido-mount',
    this.useModal = false,
  });
}
