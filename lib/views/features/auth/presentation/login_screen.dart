import 'package:easilybecho/core/common/CommonDropdown.dart';
import 'package:easilybecho/core/common/CommonTextField.dart';
import 'package:easilybecho/core/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              ToastHelper.info('This is an info toast from Login Screen');
            },
          ),
          IconButton(
            icon: Icon(Icons.warning_amber_outlined),
            onPressed: () {
              ToastHelper.warning('This is a warning toast from Login Screen');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('This is the Login Screen'),
                  ElevatedButton(
                    onPressed: () {
                      ToastHelper.warning('This is a warning toast');
                      ToastHelper.info('This is an info toast');
                      ToastHelper.error('This is an error toast');
                      ToastHelper.success('This is a success toast');
                    },
                    child: Text('Show Warning Toast'),
                  ),
                  ElevatedButton(
                    onPressed: () => (),
                    child: Text('Go to Dashboard'),
                  ),
                  SizedBox(height: 20),
                  Card(
                    // shadowColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card Title',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'This is an example of a card widget in the login screen.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          autofocus: true,
                          leading: Icon(Icons.list),
                          title: Text('List Item $index'),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,

                      child: Text('Another Card Example'),
                    ),
                  ),

                  Card(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,

                      child: Text('Yet Another Card Example'),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => (),
                    label: Text('Text Button'),
                    icon: Icon(Icons.touch_app),
                  ),

                  TextFormField(
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    
                      Expanded(child: CommonTextField(label: 'ahfkjl', controller: TextEditingController())),
                      Expanded(child: CommonTextField(label: 'afkl;dja', controller: TextEditingController())),
                      Expanded(child: CommonTextField(label: 'hjafh', controller: TextEditingController())),
                    ],
                  ),
                 Row(
  children: [
    SizedBox(width: 100, child: CommonDropdown(items: ['Item 1', 'Item 2'])),
    SizedBox(width: 100, child: CommonDropdown(items: ['Item 1', 'Item 2'])),
    SizedBox(width: 100, child: CommonDropdown(items: ['Item 1', 'Item 2'])),
  ],
),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                 

                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Submit'),
                    icon: Icon(Icons.send),
                  ),
                  SizedBox(height: 30),
                  OutlinedButton.icon(
                    onPressed: () {},
                    label: Text('Cancel'),
                    icon: Icon(Icons.cancel),
                  ),
                  SizedBox(height: 30),
                  CheckboxListTile(
                    value: true,
                    onChanged: (bool? newValue) {},
                    title: Text("Remember me"),
                  ),
                  Column(
                    children: [
                      SwitchListTile(
                        title: Text("Switch"),
                        value: true,
                        onChanged: (val) {
                          setState(() {
                            val = !val;
                          });
                        },
                      ),

                      RadioListTile<bool>(
                        value: true,
                        groupValue: false,
                        onChanged: (bool? value) {},
                        title: Text("Radio Button"),
                      ),
                    ],
                  ),
                  Slider(
                    value: 0.5,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.blue,
                    onChanged: (double value) {},
                  ),
                  RangeSlider(
                    values: RangeValues(0.2, 0.8),
                    min: 0.0,
                    max: 1.0,
                    onChanged: (RangeValues values) {},
                  ),
                  DropdownButtonFormField<String>(
                    iconEnabledColor: Colors.blue,
                    iconDisabledColor: Colors.grey,
                    iconSize: 24,
                    decoration: InputDecoration(
                      labelText: 'Dropdown',
                      suffixText: 'Optional',
                      // hintText: 'Select an option',
                    ),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                    dropdownColor: Get.isDarkMode ? Colors.black : Colors.white,

                    items: ['Option A', 'Option B'].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    label: "Full Name",
                    controller: TextEditingController(),
                    prefixIcon: Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
