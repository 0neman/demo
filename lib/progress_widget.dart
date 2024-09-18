import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({super.key});

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // var some = io.Process.runSync(
  //   "C:/Program Files (x86)/My Program/unins000.exe",
  //   [],
  // );

  final storageIO = InternetFileStorageIO();
  bool boolean = false;
  bool done = false;
  // var something = io.File('');
  // var some = io.Directory('C:\\').listSync(followLinks: true);

  @override
  Widget build(BuildContext context) {
    void downloading() async {
      var progress = 0.0;
      await InternetFile.get(
        'https://github.com/0neman/demo/raw/main/mysetup.exe',
        storage: storageIO,
        storageAdditional: storageIO.additional(
          filename: 'classconnect.exe',
          location: 'C:/AutoUpdater/',
        ),
        // force: true,
        progress: (receivedLength, contentLength) {
          progress = receivedLength / contentLength;
          print(progress);

          if (progress == 1.0) {
            // io.Process.runSync(
            //   "C:/ClassConnect/unins000.exe",
            //   [],
            // );

            io.Process.runSync(
              "C:/AutoUpdater/classconnect.exe",
              [],
            );
          }
          setState(() {
            boolean = false;
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0XFF0B2C6A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            boolean
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                    value: 1,
                    strokeWidth: 3,
                  ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: () {
                downloading();
                setState(() {
                  boolean = true;
                });
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
