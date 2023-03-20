<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Flutter and Dart: Onfido Integration

This code provides support for integrating the Onfido Web SDK into a Flutter app. The Onfido Web SDK is a JavaScript
library that provides a way to integrate identity verification into an application.

### Integration
To integrate Onfido into your Flutter app, you will need to perform the following steps:

Import the necessary packages and libraries, including dart:js_util and dart:html.

```
import 'dart:js_util';
import 'dart:html' as html;
```

Load the Onfido Web SDK JavaScript file by calling the loadSdk() function:

```
loadSdk();
```

This function creates a new div element with the ID of 'onfido-mount' and appends it to the body of the HTML document.
This is necessary for the Onfido Web SDK to work properly.

Initialize the Onfido session by calling the `start()` function:

```
start(
    token: 'YOUR_TOKEN_HERE',
    onComplete: (data) {
        // Handle completion of Onfido session here
        print(data);
    },
    steps: ['document', 'face'],
);
```

This function takes several parameters, including the Onfido token, a callback function to handle the completion of the
session, and a list of steps that define the order in which the user will complete the identity verification process. In
this example, the user will be prompted to upload a document and take a face photo.

Remove the Onfido div element from the HTML document when the session is complete by calling the closeOnfido() function:

```
closeOnfido();
```

This function removes the div element with the ID of 'onfido-mount' from the HTML document.
