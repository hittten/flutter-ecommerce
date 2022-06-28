// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Navigator example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Navigator example'),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Center(
              child: ElevatedButton(
                child: const Text('Open popup screen'),
                onPressed: () {
                  // print(context.widget.runtimeType);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: const Text('push new screen'),
                            ),
                            body: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Go Back')),
                            ),
                          )));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
