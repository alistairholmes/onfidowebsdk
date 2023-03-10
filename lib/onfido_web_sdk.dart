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
  html.DivElement newDiv = html.DivElement(); // create a new div element
  newDiv.id = 'onfido-mount'; // set the ID of the new div to 'onfido-mount'

  final body = html.querySelector('body'); // select the body element of the page
  body?.append(newDiv);
}

void closeOnfido() {
  html.DivElement newDiv = html.DivElement(); // create a new div element
  newDiv.id = 'onfido-mount';
  newDiv.remove();
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
