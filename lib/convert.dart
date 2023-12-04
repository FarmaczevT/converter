import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConvertPage extends StatefulWidget {
  final String title;
  final List<DropdownMenuItem<String>> dropdownItems;

  const ConvertPage(
      {super.key, required this.title, required this.dropdownItems});

  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  String?
      selectedValue; // Добавленная переменная для хранения выбранного значения
  String?
      selectedValue2; // Добавленная переменная для хранения выбранного значения второго списка
  double _convertedValue = 0.0;
  String _convertedWeight = '';
  TextEditingController _textFieldController =
      TextEditingController(); // Определение контроллера

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // Разрешает GestureDetector перехватывать события касания на прозрачных областях
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
                    ],
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
                      value:
                          selectedValue, // Связывание значения списка с переменной
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
                      value:
                          selectedValue2, // Связывание значения второго списка с переменной
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
                'Результат: $_convertedValue $_convertedWeight',
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
    String? weight;

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
        weight = 'lbs.';
      } else if (toUnit == 'Граммы') {
        result = inputValueParsed * 1000;
        weight = 'г.';
      } else if (toUnit == 'Унции') {
        result = inputValueParsed * 35.2739;
        weight = 'OZ.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Фунты') {
      if (toUnit == 'Килограммы') {
        result = inputValueParsed * 0.453592;
        weight = 'кг.';
      } else if (toUnit == 'Граммы') {
        result = inputValueParsed * 453.59;
        weight = 'г.';
      } else if (toUnit == 'Унции') {
        result = inputValueParsed * 16;
        weight = 'OZ.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Граммы') {
      if (toUnit == 'Килограммы') {
        result = inputValueParsed * 0.001;
        weight = 'кг.';
      } else if (toUnit == 'Фунты') {
        result = inputValueParsed * 0.0022;
        weight = 'lbs.';
      } else if (toUnit == 'Унции') {
        result = inputValueParsed * 0.0353;
        weight = 'OZ.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Унции') {
      if (toUnit == 'Килограммы') {
        result = inputValueParsed * 0.0283;
        weight = 'кг.';
      } else if (toUnit == 'Фунты') {
        result = inputValueParsed * 0.0625;
        weight = 'lbs.';
      } else if (toUnit == 'Граммы') {
        result = inputValueParsed * 28.3495;
        weight = 'г.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    }
    // Градусы
    else if (fromUnit == 'Градус Цельсия') {
      if (toUnit == 'Градус Фаренгейта') {
        result = (inputValueParsed * 9 / 5) + 32;
        weight = 'F.';
      } else if (toUnit == 'Кельвин') {
        result = inputValueParsed + 273.15;
        weight = 'K.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Градус Фаренгейта') {
      if (toUnit == 'Градус Цельсия') {
        result = (inputValueParsed - 32) * 5 / 9;
        weight = 'C.';
      } else if (toUnit == 'Кельвин') {
        result = (inputValueParsed + 459.67) * 5 / 9;
        weight = 'K.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Кельвин') {
      if (toUnit == 'Градус Цельсия') {
        result = inputValueParsed - 273.15;
        weight = 'C.';
      } else if (toUnit == 'Градус Фаренгейта') {
        result = (inputValueParsed * 9 / 5) - 459.67;
        weight = 'F.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    }
    // Длина
    else if (fromUnit == 'Миллиметр') {
      if (toUnit == 'Сантиметр') {
        result = inputValueParsed * 0.1;
        weight = 'см.';
      } else if (toUnit == 'Метр') {
        result = inputValueParsed * 0.001;
        weight = 'м.';
      } else if (toUnit == 'Километр') {
        result = inputValueParsed * 0.000001;
        weight = 'км.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Сантиметр') {
      if (toUnit == 'Миллиметр') {
        result = inputValueParsed * 10;
        weight = 'мм.';
      } else if (toUnit == 'Метр') {
        result = inputValueParsed * 0.01;
        weight = 'м.';
      } else if (toUnit == 'Километр') {
        result = inputValueParsed * 0.00001;
        weight = 'км.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Метр') {
      if (toUnit == 'Миллиметр') {
        result = inputValueParsed * 1000;
        weight = 'мм.';
      } else if (toUnit == 'Сантиметр') {
        result = inputValueParsed * 100;
        weight = 'см.';
      } else if (toUnit == 'Километр') {
        result = inputValueParsed * 0.001;
        weight = 'км.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Километр') {
      if (toUnit == 'Миллиметр') {
        result = inputValueParsed * 1000000;
        weight = 'мм.';
      } else if (toUnit == 'Сантиметр') {
        result = inputValueParsed * 100000;
        weight = 'см.';
      } else if (toUnit == 'Метр') {
        result = inputValueParsed * 1000;
        weight = 'м.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    }
    // Площадь
    else if (fromUnit == 'Квадратный метр') {
      if (toUnit == 'Квадратный километр') {
        result = inputValueParsed * 0.000001;
        weight = 'кв. км.';
      } else if (toUnit == 'Гектар') {
        result = inputValueParsed * 0.0001;
        weight = 'га.';
      } else if (toUnit == 'Сотки') {
        result = inputValueParsed * 0.01;
        weight = 'а.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Квадратный километр') {
      if (toUnit == 'Квадратный метр') {
        result = inputValueParsed * 1000000;
        weight = 'кв. м.';
      } else if (toUnit == 'Гектар') {
        result = inputValueParsed * 100;
        weight = 'га.';
      } else if (toUnit == 'Сотки') {
        result = inputValueParsed * 10000;
        weight = 'а.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Гектар') {
      if (toUnit == 'Квадратный метр') {
        result = inputValueParsed * 10000;
        weight = 'кв. м.';
      } else if (toUnit == 'Квадратный километр') {
        result = inputValueParsed * 0.01;
        weight = 'кв. км.';
      } else if (toUnit == 'Сотки') {
        result = inputValueParsed * 100;
        weight = 'а.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Сотки') {
      if (toUnit == 'Квадратный метр') {
        result = inputValueParsed * 100;
        weight = 'кв. м.';
      } else if (toUnit == 'Квадратный километр') {
        result = inputValueParsed * 0.0001;
        weight = 'кв. км.';
      } else if (toUnit == 'Гектар') {
        result = inputValueParsed * 0.01;
        weight = 'га.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    }
    // Объем
    else if (fromUnit == 'Баррели') {
      if (toUnit == 'Литры') {
        result = inputValueParsed * 158.99;
        weight = 'л.';
      } else if (toUnit == 'Кубические сантиметры') {
        result = inputValueParsed * 158987.29;
        weight = 'куб. см.';
      } else if (toUnit == 'Кубические метры') {
        result = inputValueParsed * 0.16;
        weight = 'куб. м.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Литры') {
      if (toUnit == 'Баррели') {
        result = inputValueParsed * 0.0063;
        weight = 'bbl.';
      } else if (toUnit == 'Кубические сантиметры') {
        result = inputValueParsed * 1000;
        weight = 'куб. см.';
      } else if (toUnit == 'Кубические метры') {
        result = inputValueParsed * 0.001;
        weight = 'куб. м.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Кубические сантиметры') {
      if (toUnit == 'Баррели') {
        result = inputValueParsed * 0.0000063;
        weight = 'bbl.';
      } else if (toUnit == 'Литры') {
        result = inputValueParsed * 0.001;
        weight = 'л.';
      } else if (toUnit == 'Кубические метры') {
        result = inputValueParsed * 0.000001;
        weight = 'куб. м.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Кубические метры') {
      if (toUnit == 'Баррели') {
        result = inputValueParsed * 6.29;
        weight = 'bbl.';
      } else if (toUnit == 'Литры') {
        result = inputValueParsed * 1000;
        weight = 'л.';
      } else if (toUnit == 'Кубические сантиметры') {
        result = inputValueParsed * 1000000;
        weight = 'куб. см.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    }
    // Время
    else if (fromUnit == 'Секунды') {
      if (toUnit == 'Минуты') {
        result = inputValueParsed * 0.017;
        weight = 'мин.';
      } else if (toUnit == 'Часы') {
        result = inputValueParsed * 0.00028;
        weight = 'ч.';
      } else if (toUnit == 'Сутки') {
        result = inputValueParsed * 0.000012;
        weight = 'сут.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Минуты') {
      if (toUnit == 'Секунды') {
        result = inputValueParsed * 60;
        weight = 'сек.';
      } else if (toUnit == 'Часы') {
        result = inputValueParsed * 0.017;
        weight = 'ч.';
      } else if (toUnit == 'Сутки') {
        result = inputValueParsed * 0.00069;
        weight = 'сут.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Часы') {
      if (toUnit == 'Секунды') {
        result = inputValueParsed * 3600;
        weight = 'сек.';
      } else if (toUnit == 'Минуты') {
        result = inputValueParsed * 60;
        weight = 'мин.';
      } else if (toUnit == 'Сутки') {
        result = inputValueParsed * 0.042;
        weight = 'сут.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else if (fromUnit == 'Сутки') {
      if (toUnit == 'Минуты') {
        result = inputValueParsed * 1440;
        weight = 'мин.';
      } else if (toUnit == 'Часы') {
        result = inputValueParsed * 24;
        weight = 'ч.';
      } else if (toUnit == 'Секунды') {
        result = inputValueParsed * 86400;
        weight = 'сек.';
      } else {
        showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
        return;
      }
    } else {
      showErrorDialog('Ошибка', 'Не удалось выполнить конвертацию.');
      return;
    }
    if (result % 1 == 0) { // tсли результат является целым числом, то он преобразуется в целое число
        result = result.toInt().toDouble();
      } else {
        result = result.toDouble();
      }

    setState(() {
      _convertedValue = result;
      _convertedWeight = weight!;
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