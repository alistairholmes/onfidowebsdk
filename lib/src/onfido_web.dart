/// Support for doing something awesome.
///
/// More dartdocs go here.

import 'dart:js_util';
import 'dart:html' as html;

import 'package:js/js.dart';

// Load the Onfido Web SDK JavaScript file.
Future<void> loadSdk() async {
  html.DivElement mount = html.DivElement(); // create a new div element
  mount.id = 'onfido-mount'; // set the ID of the new div to 'onfido-mount'

  final body = html.querySelector('body')
      as html.BodyElement?; // select the body element of the page
  body?.append(mount);
}

void closeOnfido() {
  final mount = html.querySelector('#onfido-mount'); // create a new div element
  mount?.remove();
}

void start({
  required String token,
  required Function onComplete,
  required List steps,
  String containerId = 'onfido-mount',
  bool useModal = false,
}) {
  final init = allowInterop(Onfido.init);
  init(Opts(
    token: token,
    steps: _buildSteps(steps),
    containerId: containerId,
    useModal: useModal,
    onComplete: allowInterop((data) {
      var dartMap = dartify(data);
      onComplete(dartMap);
    }),
  ));
}

List _buildSteps(List steps) {
  List resultSteps = [];
  for (var value in steps) {
    if (value is String) {
      resultSteps.add(value);
    } else if (value is Map) {
      resultSteps.add(jsify(value));
    }
  }

  return resultSteps;
}

@JS('Onfido')
@staticInterop
class Onfido {
  external static dynamic init(dynamic);
}

@JS()
@anonymous
class Opts {
  external String token;
  external List steps;
  external String containerId;
  external Function(Map) onComplete;
  external bool useModal;

  external factory Opts({
    String token,
    List steps,
    Function onComplete,
    String containerId,
    bool useModal,
  });
}
