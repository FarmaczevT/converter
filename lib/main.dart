import 'package:converter/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ConverterApp());
}

class ConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(172, 255, 196, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> weightDropdownItems = [
      'Килограммы',
      'Фунты',
      'Граммы',
      'Унции'
    ];
    List<String> temperatureDropdownItems = [
      'Градус Цельсия',
      'Градус Фаренгейта',
      'Кельвин'
    ];
    List<String> lengthDropdownItems = [
      'Миллиметр',
      'Сантиметр',
      'Метр',
      'Километр'
    ];
    List<String> areaDropdownItems = [
      'Квадратный метр',
      'Квадратный километр',
      'Гектар',
      'Сотки'
    ];
    List<String> volumeDropdownItems = [
      'Баррели',
      'Литры',
      'Кубические сантиметры',
      'Кубические метры'
    ];
    List<String> timeDropdownItems = [
      'Секунды', 
      'Минуты', 
      'Часы', 
      'Сутки'
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 224),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildButton('Вес-масса', 'assets/images/weight.png', weightDropdownItems),
                ),
                Expanded(
                  child: _buildButton('Температура', 'assets/images/temperature.png', temperatureDropdownItems),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildButton('Длина', 'assets/images/length.png', lengthDropdownItems),
                ),
                Expanded(
                  child: _buildButton('Площадь', 'assets/images/area.png', areaDropdownItems),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildButton('Объем', 'assets/images/obyem.png', volumeDropdownItems),
                ),
                Expanded(
                  child: _buildButton('Время', 'assets/images/time.png', timeDropdownItems),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      String buttonText, String imagePath, List<String> dropdownItems) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: () {
          List<DropdownMenuItem<String>> items =
              dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConvertPage(title: buttonText, dropdownItems: items)),
          );
        },
        style: TextButton.styleFrom(
          minimumSize: const Size(100, 100),
          backgroundColor: const Color.fromARGB(132, 255, 196, 0),
          primary: const Color.fromARGB(255, 49, 49, 49),
          padding: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50.0,
              height: 50.0,
            ),
            const SizedBox(height: 8),
            Text(
              buttonText,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
