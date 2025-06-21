import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isBleConnected = prefs.getBool('ff_isBleConnected') ?? _isBleConnected;
    });
    _safeInit(() {
      _isBluetoothEnabled =
          prefs.getBool('ff_isBluetoothEnabled') ?? _isBluetoothEnabled;
    });
    _safeInit(() {
      _ConnectedDevices = prefs
              .getStringList('ff_ConnectedDevices')
              ?.map((x) {
                try {
                  return BTDeviceStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _ConnectedDevices;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_currentDevice')) {
        try {
          final serializedData = prefs.getString('ff_currentDevice') ?? '{}';
          _currentDevice =
              BTDeviceStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _receivedData = prefs.getString('ff_receivedData') ?? _receivedData;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isBleConnected = false;
  bool get isBleConnected => _isBleConnected;
  set isBleConnected(bool value) {
    _isBleConnected = value;
    prefs.setBool('ff_isBleConnected', value);
  }

  bool _isBluetoothEnabled = false;
  bool get isBluetoothEnabled => _isBluetoothEnabled;
  set isBluetoothEnabled(bool value) {
    _isBluetoothEnabled = value;
    prefs.setBool('ff_isBluetoothEnabled', value);
  }

  List<BTDeviceStruct> _ConnectedDevices = [];
  List<BTDeviceStruct> get ConnectedDevices => _ConnectedDevices;
  set ConnectedDevices(List<BTDeviceStruct> value) {
    _ConnectedDevices = value;
    prefs.setStringList(
        'ff_ConnectedDevices', value.map((x) => x.serialize()).toList());
  }

  void addToConnectedDevices(BTDeviceStruct value) {
    ConnectedDevices.add(value);
    prefs.setStringList('ff_ConnectedDevices',
        _ConnectedDevices.map((x) => x.serialize()).toList());
  }

  void removeFromConnectedDevices(BTDeviceStruct value) {
    ConnectedDevices.remove(value);
    prefs.setStringList('ff_ConnectedDevices',
        _ConnectedDevices.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromConnectedDevices(int index) {
    ConnectedDevices.removeAt(index);
    prefs.setStringList('ff_ConnectedDevices',
        _ConnectedDevices.map((x) => x.serialize()).toList());
  }

  void updateConnectedDevicesAtIndex(
    int index,
    BTDeviceStruct Function(BTDeviceStruct) updateFn,
  ) {
    ConnectedDevices[index] = updateFn(_ConnectedDevices[index]);
    prefs.setStringList('ff_ConnectedDevices',
        _ConnectedDevices.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInConnectedDevices(int index, BTDeviceStruct value) {
    ConnectedDevices.insert(index, value);
    prefs.setStringList('ff_ConnectedDevices',
        _ConnectedDevices.map((x) => x.serialize()).toList());
  }

  bool _isFetchingConnectedDevices = false;
  bool get isFetchingConnectedDevices => _isFetchingConnectedDevices;
  set isFetchingConnectedDevices(bool value) {
    _isFetchingConnectedDevices = value;
  }

  bool _isFetchingDevices = false;
  bool get isFetchingDevices => _isFetchingDevices;
  set isFetchingDevices(bool value) {
    _isFetchingDevices = value;
  }

  List<BTDeviceStruct> _foundDevices = [];
  List<BTDeviceStruct> get foundDevices => _foundDevices;
  set foundDevices(List<BTDeviceStruct> value) {
    _foundDevices = value;
  }

  void addToFoundDevices(BTDeviceStruct value) {
    foundDevices.add(value);
  }

  void removeFromFoundDevices(BTDeviceStruct value) {
    foundDevices.remove(value);
  }

  void removeAtIndexFromFoundDevices(int index) {
    foundDevices.removeAt(index);
  }

  void updateFoundDevicesAtIndex(
    int index,
    BTDeviceStruct Function(BTDeviceStruct) updateFn,
  ) {
    foundDevices[index] = updateFn(_foundDevices[index]);
  }

  void insertAtIndexInFoundDevices(int index, BTDeviceStruct value) {
    foundDevices.insert(index, value);
  }

  List<BTDeviceStruct> _currentDevices = [];
  List<BTDeviceStruct> get currentDevices => _currentDevices;
  set currentDevices(List<BTDeviceStruct> value) {
    _currentDevices = value;
  }

  void addToCurrentDevices(BTDeviceStruct value) {
    currentDevices.add(value);
  }

  void removeFromCurrentDevices(BTDeviceStruct value) {
    currentDevices.remove(value);
  }

  void removeAtIndexFromCurrentDevices(int index) {
    currentDevices.removeAt(index);
  }

  void updateCurrentDevicesAtIndex(
    int index,
    BTDeviceStruct Function(BTDeviceStruct) updateFn,
  ) {
    currentDevices[index] = updateFn(_currentDevices[index]);
  }

  void insertAtIndexInCurrentDevices(int index, BTDeviceStruct value) {
    currentDevices.insert(index, value);
  }

  BTDeviceStruct _currentDevice = BTDeviceStruct.fromSerializableMap(
      jsonDecode('{\"name\":\"No Device Connected\",\"id\":\"\"}'));
  BTDeviceStruct get currentDevice => _currentDevice;
  set currentDevice(BTDeviceStruct value) {
    _currentDevice = value;
    prefs.setString('ff_currentDevice', value.serialize());
  }

  void updateCurrentDeviceStruct(Function(BTDeviceStruct) updateFn) {
    updateFn(_currentDevice);
    prefs.setString('ff_currentDevice', _currentDevice.serialize());
  }

  String _receivedData = 'Waiting...';
  String get receivedData => _receivedData;
  set receivedData(String value) {
    _receivedData = value;
    prefs.setString('ff_receivedData', value);
  }

  bool _isDeviceConnected = false;
  bool get isDeviceConnected => _isDeviceConnected;
  set isDeviceConnected(bool value) {
    _isDeviceConnected = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
