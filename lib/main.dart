import 'package:ahorra_gas/core/principal_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'AhorraGas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.principalColor,
        foregroundColor: ColorApp.letterColor,
        toolbarHeight: 230,
        flexibleSpace: Center(
          child: Image.asset(
            'lib/assets/img/logo.png',
            width: 200,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  color: const Color.fromARGB(255, 73, 0, 0),
                  child: Image.asset(
                    'lib/assets/img/gasprice.gif',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Material(
                      child: Container(
                        width: 300,
                        height: 50,
                        child: FloatingActionButton(
                          onPressed: () {},
                          heroTag: 'principal',
                          backgroundColor: ColorApp.colorButton,
                          foregroundColor: ColorApp.letterColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '¡Empieza ahorrar!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
