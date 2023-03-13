/// Support for doing something awesome.
///
/// More dartdocs go here.
library onfido_web_sdk;

export 'src/onfido_none.dart'
  if(dart.library.html) 'src/onfido_web.dart';