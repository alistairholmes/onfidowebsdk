Future<void> loadSdk() async {}
void closeOnfido() {}
void start({
  required String token,
  required Function onComplete,
  required List<String> steps,
  String containerId = 'onfido-mount',
  bool useModal = false,
}) {}