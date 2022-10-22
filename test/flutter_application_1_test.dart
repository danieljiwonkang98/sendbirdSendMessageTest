import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sendbird_sdk/sendbird_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('test send message', () async {
    var wait = Completer();
    // Initialize SendbirdSdk instance to use APIs in your app.

    final sendbird = SendbirdSdk(appId: "FF6E181B-6325-4A32-AA6D-B1ADA6BAEE95");

    final user = await sendbird.connect('123');

    final openChannel = await OpenChannel.createChannel(OpenChannelParams());

    final oC = await OpenChannel.getChannel(openChannel.channelUrl);

    await oC.enter();

    final params = UserMessageParams(message: 'MESSAGE');

    final preMessage =
        openChannel.sendUserMessage(params, onCompleted: (msg, error) {
      print('msg sent');
      print(msg);
      wait.complete();
    });

    await wait.future;
  });
}
