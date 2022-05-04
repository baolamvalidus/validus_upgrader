/*
 * Copyright (c) 2019 Larry Aasen. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only call clearSavedSettings() during testing to reset internal values.
    Upgrader().clearSavedSettings(); // REMOVE this for release builds

    // On Android, the default behavior will be to use the Google Play Store
    // version of the app.
    // On iOS, the default behavior will be to use the App Store version of
    // the app, so update the Bundle Identifier in example/ios/Runner with a
    // valid identifier already in the App Store.

    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Upgrader Example'),
          ),
          body: UpgradeAlert(
            debugLogging: true,
            showReleaseNotes: false,

            /// Force
            validusVersionUrl: "https://run.mocky.io/v3/0ec9185e-b762-4aa4-bf5b-f685fddd1e64",

            /// Optional
            // validusVersionUrl: "https://run.mocky.io/v3/0b444760-4aa8-449f-9419-9c68c829d785",

            child: Center(child: Text('Checking...')),
          )),
    );
  }
}
