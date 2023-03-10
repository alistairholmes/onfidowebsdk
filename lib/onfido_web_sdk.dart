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
  final init = allowInterop(Onfido.init);
  init(Opts(
    token: token,
    steps: steps,
    containerId: containerId,
    useModal: useModal,
    onComplete: allowInterop((data) {
      onComplete(data);
    }),
  ));
}

@JS()
@anonymous
class Opts {
  external String token;
  external List<String> steps;
  external String containerId;
  external Function onComplete;
  external bool useModal;

  external factory Opts({
    String token,
    List<String> steps,
    Function onComplete,
    String containerId,
    bool useModal,
  });
}
