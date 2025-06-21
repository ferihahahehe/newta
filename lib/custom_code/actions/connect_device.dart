// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'index.dart'; // Pastikan ini mengimpor manageDataListener

Future<bool> connectDevice(BTDeviceStruct deviceInfo) async {
  final device = BluetoothDevice.fromId(deviceInfo.id);
  try {
    await device.connect();
    FFAppState().isDeviceConnected = true; // Set status koneksi global

    // Mulai mendengarkan data
    // Pastikan 'manageDataListener' sudah ada sebagai custom action
    await manageDataListener('start', deviceInfo);

    return true;
  } catch (e) {
    debugPrint('Connection failed: ${e.toString()}');
    FFAppState().isDeviceConnected = false;
    return false;
  }
}
