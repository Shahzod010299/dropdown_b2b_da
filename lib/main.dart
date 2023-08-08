import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test2Screen(),
    );
  }
}

class DropDownValueModel extends Equatable {
  final String iconUrl;
  final String name;
  final dynamic value;

  DropDownValueModel(
      {required this.iconUrl, required this.name, required this.value});

  factory DropDownValueModel.fromJson(Map<String, dynamic> json) =>
      DropDownValueModel(
        iconUrl: json["icon"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
    "icon": iconUrl,
    "name": name,
    "value": value,
  };

  @override
  List<Object> get props => [iconUrl,name, value];
}

class Test2Screen extends StatefulWidget {
  const Test2Screen({super.key});

  @override
  State<Test2Screen> createState() => _Test2ScreenState();
}

List<DropDownValueModel> getDropDownData() {
  List<DropDownValueModel> list = [];
  list.add(
    DropDownValueModel(
        iconUrl: 'assets/icons/ic_tuda.png',
        name: 'Туда и обратно',
        value: "value1"),
  );
  list.add(
    DropDownValueModel(
        iconUrl: 'assets/icons/ic_arrow_right.png',
        name: 'В одну сторону',
        value: "value2"),
  );
  list.add(
    DropDownValueModel(
        iconUrl: 'assets/icons/ic_slujni.png',
        name: 'Сложный маршрут',
        value: "value3"),
  );

  return list;
}

class _Test2ScreenState extends State<Test2Screen> {
  DropDownValueModel? dropdownValue = getDropDownData()[0];
  final focusNode = FocusNode();
  IconData icon = Icons.arrow_drop_down;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        icon = Icons.arrow_drop_up_outlined;
        setState(() {});
      } else {
        icon = Icons.arrow_drop_down;
        setState(() {});
      }
    });
  }

  final items = getDropDownData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownButtonFormField2(
            focusNode: focusNode,
            value: dropdownValue,
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                icon,
                color: focusNode.hasFocus ? Colors.blue : Colors.black45,
              ),
              iconSize: 24,
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        ImageIcon(AssetImage(e.iconUrl)),
                        const SizedBox(width: 5),
                        Text(
                          e.name,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              dropdownValue = value;
            },
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              selectedMenuItemBuilder: (context, child) => Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                  child: Row(
                    children: [
                      ImageIcon(AssetImage(dropdownValue!.iconUrl),color: Colors.blue,),
                      const SizedBox(width: 5),
                      Text(
                        dropdownValue?.name ?? '',
                        style: const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
