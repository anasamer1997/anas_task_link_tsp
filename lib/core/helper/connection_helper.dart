import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionHelper {
  // Function to check if the device is connected to the internet
  Future<bool> checkInternetConnection() async {

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none) ) {
      return false; // Not connected to any network
    } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      return true; // Connected to either mobile data or Wi-Fi
    }

    return false; // Default to not connected
  }

}
