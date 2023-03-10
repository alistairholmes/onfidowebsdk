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
  html.DivElement mount = html.DivElement(); // create a new div element
  mount.id = 'onfido-mount'; // set the ID of the new div to 'onfido-mount'

  final body = html.querySelector('body') as html.BodyElement?; // select the body element of the page
  body?.append(mount);
}

void closeOnfido() {
  final mount = html.querySelector('#onfido-mount'); // create a new div element
  mount?.remove();
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
