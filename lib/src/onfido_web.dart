/// Support for doing something awesome.
///
/// More dartdocs go here.

import 'dart:js_util';
import 'dart:html' as html;

import 'package:js/js.dart';

// Load the Onfido Web SDK JavaScript file.
void loadSdk() {
  _addHeadElements();
  _addBodyElements();
}

void _addHeadElements() {
  final head = html.querySelector('head') as html.HeadElement?;
  html.LinkElement styleSheet = html.LinkElement();
  styleSheet.id = 'onfido-styles';
  styleSheet.href ='https://assets.onfido.com/web-sdk-releases/latest/style.css';
  styleSheet.type = 'text/css';
  styleSheet.rel = 'stylesheet';
  head?.append(styleSheet);

  html.StyleElement styleElement = html.StyleElement();
  styleElement.text = 'html,body {height: 100%;margin: 0;} body,button {-webkit-font-smoothing: antialiased;}@media (min-width: 30em) {#onfido-mount {position: relative;top: 10%;}}';
  styleElement.id = 'onfido-custom-style';
  head?.append(styleElement);
}

void _addBodyElements() {
  final body = html.querySelector('body') as html.BodyElement?;
  html.DivElement mount = html.DivElement();
  mount.id = 'onfido-mount';
  body?.append(mount);

  html.ScriptElement onfidoJs = html.ScriptElement();
  onfidoJs.id = 'onfido-js';
  onfidoJs.src ='https://assets.onfido.com/web-sdk-releases/12.0.0/onfido.min.js';
  body?.append(onfidoJs);
}

void closeOnfido() {
  final mount = html.querySelector('#onfido-mount'); // create a new div element
  final styleSheet = html.querySelector('#onfido-styles');
  final onfidoJs = html.querySelector('#onfido-js');
  final customStyle = html.querySelector('#onfido-custom-style');

  mount?.remove();
  styleSheet?.remove();
  onfidoJs?.remove();
  customStyle?.remove();
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
