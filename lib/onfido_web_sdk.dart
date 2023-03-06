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
  script.src = 'https://assets.onfido.com/web-sdk-releases/11.0.0/onfido.min.js';
  script.async = true;
  script.defer = true;
  html.document.body?.children.add(script);
}

// Expose the Onfido Web SDK API methods as Dart methods.
@JS()
@anonymous
class Onfido {
  external factory Onfido({
    String token,
    String containerId,
    Function onComplete,
    List<String> steps});

  external static void startFlow();
}

/*Onfido.init({
token: '<YOUR_SDK_TOKEN>',
containerId: 'onfido-mount',
containerEl: <div id="root" />, //ALTERNATIVE to `containerId`
onComplete: function (data) {
console.log('everything is complete')
},
steps: ['welcome', 'poa', 'document', 'face', 'complete'],
})*/

// TODO: Export any libraries intended for clients of this package.
