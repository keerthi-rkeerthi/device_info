import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class IPAddressScreen extends StatefulWidget {
  const IPAddressScreen({super.key});
  @override
  _IPAddressScreenState createState() => _IPAddressScreenState();
}

class _IPAddressScreenState extends State<IPAddressScreen> {
  String ipAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchIPAddress();
  }

  Future<void> fetchIPAddress() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final dio = Dio();
      final response = await dio.get('https://api64.ipify.org?format=json');

      if (response.statusCode == 200) {
        setState(() {
          ipAddress = response.data['ip'];
        });
      }
    } else {
      setState(() {
        ipAddress = 'No network connection';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Address Example'),
      ),
      body: Center(
        child: Text('Your IP Address: $ipAddress'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IPAddressScreen(),
  ));
}
