import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(172, 255, 196, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Converter'),
    );
  }
}


class ConvertPage extends StatefulWidget {
  final String title;
  final List<DropdownMenuItem<String>> dropdownItems;

  const ConvertPage({super.key, required this.title, required this.dropdownItems});

  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  String? selectedValue; // Добавленная переменная для хранения выбранного значения
  String? selectedValue2; // Добавленная переменная для хранения выбранного значения второго списка
  double _convertedValue = 0.0;
  TextEditingController _textFieldController = TextEditingController(); // Определение контроллера

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // Разрешает GestureDetector перехватывать события касания на прозрачных областях
      onTap: () {
        // Закрываем клавиатуру при касании на любое место на экране
        FocusScope.of(context).unfocus();
      },
    child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 224),
      appBar: AppBar(
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
            // Добавление поля ввода
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textFieldController,
                keyboardType: TextInputType.number, // Устанавливаем тип клавиатуры только с цифрами
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(113, 255, 255, 255),
                  labelText: 'Введите значение',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // Добавление первого выпадающего списка
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ИЗ:'),
                  const SizedBox(width: 8.0),
                    DropdownButton<String>(
                      value: selectedValue, // Связывание значения списка с переменной
                      items: widget.dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          // Обновление состояния виджета
                          selectedValue = newValue;
                        });
                      },
                    ),
                ],
              ),
            ),
            // Добавление второго выпадающего списка
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('В:'),
                  const SizedBox(width: 8.0),
                    DropdownButton<String>(
                      value: selectedValue2, // Связывание значения второго списка с переменной
                      items: widget.dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          // Обновление состояния виджета
                          selectedValue2 = newValue;
                        });
                      },
                    ),
                ],
              ),
            ),
            // Добавление кнопки "Конвертировать"
            ElevatedButton(
              onPressed: () {
                convertValues();
              },
              child: const Text('Конвертировать'),
            ),
            const SizedBox(height: 16.0),

          Text(
            'Результат: $_convertedValue',
            style: const TextStyle(fontSize: 20.0),
          ),
          ],
        ),
      ),
    ),
    );
  }

void convertValues() {
  String? inputValue = _textFieldController.text;
  String? fromUnit = selectedValue;
  String? toUnit = selectedValue2;

  if (inputValue.isEmpty || fromUnit == null || toUnit == null) {
    showErrorDialog('Ошибка', 'Заполните все поля.');
    return;
  }

  double inputValueParsed = double.tryParse(inputValue) ?? 0;
  double result;
  // Вес-масса
  if (fromUnit == 'Килограммы') {
    if (toUnit == 'Фунты') {
      result = inputValueParsed * 2.20462;
    } else if (toUnit == 'Граммы') {
      result = inputValueParsed * 1000;
    } else if (toUnit == 'Унции') {
      result = inputValueParsed * 35.2739;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Фунты') {
    if (toUnit == 'Килограммы') {
      result = inputValueParsed * 0.453592;
    } else if (toUnit == 'Граммы') {
      result = inputValueParsed * 453.59;
    } else if (toUnit == 'Унции') {
      result = inputValueParsed * 16;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Граммы') {
    if (toUnit == 'Килограммы') {
      result = inputValueParsed * 0.001;
    } else if (toUnit == 'Фунты') {
      result = inputValueParsed * 0.0022;
    } else if (toUnit == 'Унции') {
      result = inputValueParsed * 0.0353;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Унции') {
    if (toUnit == 'Килограммы') {
      result = inputValueParsed * 0.0283;
    } else if (toUnit == 'Фунты') {
      result = inputValueParsed * 0.0625;
    } else if (toUnit == 'Граммы') {
      result = inputValueParsed * 28.3495;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } 
  // Градусы
  else if (fromUnit == 'Градус Цельсия') {
    if (toUnit == 'Градус Фаренгейта') {
      result = (inputValueParsed * 9 / 5) + 32;
    } else if (toUnit == 'Кельвин') {
      result = inputValueParsed + 273.15;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Градус Фаренгейта') {
    if (toUnit == 'Градус Цельсия') {
      result = (inputValueParsed - 32) * 5 / 9;
    } else if (toUnit == 'Кельвин') {
      result = (inputValueParsed + 459.67) * 5 / 9;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Кельвин') {
    if (toUnit == 'Градус Цельсия') {
      result = inputValueParsed - 273.15;
    } else if (toUnit == 'Градус Фаренгейта') {
      result = (inputValueParsed * 9 / 5) - 459.67;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  }
  // Длина
  else if (fromUnit == 'Миллиметр') {
    if (toUnit == 'Сантиметр') {
      result = inputValueParsed * 0.1;
    } else if (toUnit == 'Метр') {
      result = inputValueParsed * 0.001;
    } else if (toUnit == 'Километр') {
      result = inputValueParsed * 0.000001;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Сантиметр') {
    if (toUnit == 'Миллиметр') {
      result = inputValueParsed * 10;
    } else if (toUnit == 'Метр') {
      result = inputValueParsed * 0.01;
    } else if (toUnit == 'Километр') {
      result = inputValueParsed * 0.00001;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Метр') {
    if (toUnit == 'Миллиметр') {
      result = inputValueParsed * 1000;
    } else if (toUnit == 'Сантиметр') {
      result = inputValueParsed * 100;
    } else if (toUnit == 'Километр') {
      result = inputValueParsed * 0.001;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Километр') {
    if (toUnit == 'Миллиметр') {
      result = inputValueParsed * 1000000;
    } else if (toUnit == 'Сантиметр') {
      result = inputValueParsed * 100000;
    } else if (toUnit == 'Метр') {
      result = inputValueParsed * 1000;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  }
  // Площадь
  else if (fromUnit == 'Квадратный метр') {
    if (toUnit == 'Квадратный километр') {
      result = inputValueParsed * 0.000001;
    } else if (toUnit == 'Гектар') {
      result = inputValueParsed * 0.0001;
    } else if (toUnit == 'Сотки') {
      result = inputValueParsed * 0.01;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Квадратный километр') {
    if (toUnit == 'Квадратный метр') {
      result = inputValueParsed * 1000000;
    } else if (toUnit == 'Гектар') {
      result = inputValueParsed * 100;
    } else if (toUnit == 'Сотки') {
      result = inputValueParsed * 10000;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Гектар') {
    if (toUnit == 'Квадратный метр') {
      result = inputValueParsed * 10000;
    } else if (toUnit == 'Квадратный километр') {
      result = inputValueParsed * 0.01;
    } else if (toUnit == 'Сотки') {
      result = inputValueParsed * 100;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Сотки') {
    if (toUnit == 'Квадратный метр') {
      result = inputValueParsed * 100;
    } else if (toUnit == 'Квадратный километр') {
      result = inputValueParsed * 0.0001;
    } else if (toUnit == 'Гектар') {
      result = inputValueParsed * 0.01;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  }
  // Объем
  else if (fromUnit == 'Баррели') {
    if (toUnit == 'Литры') {
      result = inputValueParsed * 158.99;
    } else if (toUnit == 'Кубические сантиметры') {
      result = inputValueParsed * 158987.29;
    } else if (toUnit == 'Кубические метры') {
      result = inputValueParsed * 0.16;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Литры') {
    if (toUnit == 'Баррели') {
      result = inputValueParsed * 0.0063;
    } else if (toUnit == 'Кубические сантиметры') {
      result = inputValueParsed * 1000;
    } else if (toUnit == 'Кубические метры') {
      result = inputValueParsed * 0.001;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Кубические сантиметры') {
    if (toUnit == 'Баррели') {
      result = inputValueParsed * 0.0000063;
    } else if (toUnit == 'Литры') {
      result = inputValueParsed * 0.001;
    } else if (toUnit == 'Кубические метры') {
      result = inputValueParsed * 0.000001;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Кубические метры') {
    if (toUnit == 'Баррели') {
      result = inputValueParsed * 6.29;
    } else if (toUnit == 'Литры') {
      result = inputValueParsed * 1000;
    } else if (toUnit == 'Кубические сантиметры') {
      result = inputValueParsed * 1000000;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  }
  // Время
  else if (fromUnit == 'Секунды') {
    if (toUnit == 'Минуты') {
      result = inputValueParsed * 0.017;
    } else if (toUnit == 'Часы') {
      result = inputValueParsed * 0.00028;
    } else if (toUnit == 'Сутки') {
      result = inputValueParsed * 0.000012;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Минуты') {
    if (toUnit == 'Секунды') {
      result = inputValueParsed * 60;
    } else if (toUnit == 'Часы') {
      result = inputValueParsed * 0.017;
    } else if (toUnit == 'Сутки') {
      result = inputValueParsed * 0.00069;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Часы') {
    if (toUnit == 'Секунды') {
      result = inputValueParsed * 3600;
    } else if (toUnit == 'Минуты') {
      result = inputValueParsed * 60;
    } else if (toUnit == 'Сутки') {
      result = inputValueParsed * 0.042;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  } else if (fromUnit == 'Сутки') {
    if (toUnit == 'Минуты') {
      result = inputValueParsed * 1440;
    } else if (toUnit == 'Часы') {
      result = inputValueParsed * 24;
    } else if (toUnit == 'Секунды') {
      result = inputValueParsed * 86400;
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
  }
  else {
    showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
    return;
  }

  setState(() {
    _convertedValue = result;
  });
}

void showErrorDialog(String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
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
    List<String> weightDropdownItems = ['Килограммы', 'Фунты', 'Граммы', 'Унции'];
    List<String> temperatureDropdownItems = ['Градус Цельсия', 'Градус Фаренгейта', 'Кельвин'];
    List<String> lengthDropdownItems = ['Миллиметр', 'Сантиметр', 'Метр', 'Километр'];
    List<String> areaDropdownItems = ['Квадратный метр', 'Квадратный километр', 'Гектар', 'Сотки'];
    List<String> volumeDropdownItems = ['Баррели', 'Литры', 'Кубические сантиметры', 'Кубические метры'];
    List<String> timeDropdownItems = ['Секунды', 'Минуты', 'Часы', 'Сутки'];

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
  

  Widget _buildButton(String buttonText, String imagePath, List<String> dropdownItems) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        onPressed: () {
          List<DropdownMenuItem<String>> items = dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConvertPage(title: buttonText, dropdownItems: items)),
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