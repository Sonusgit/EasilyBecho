import 'package:easilybecho/core/helpers/toast_helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
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
            child: Column(
              children: [
                Text('This is the Login Screen'),
                ElevatedButton(onPressed: () {
                  ToastHelper.warning('This is a warning toast');
                  ToastHelper.info('This is an info toast');
                  ToastHelper.error('This is an error toast');
                  ToastHelper.success('This is a success toast');
                }, child: Text('Show Warning Toast')),
   ElevatedButton(onPressed: () => (), child: Text('Go to Dashboard')),
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder:(context, index) {
                    return ListTile(
                      autofocus: true,
                      leading: Icon(Icons.list),
                      title: Text('List Item $index'),
                    );
                }, ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}