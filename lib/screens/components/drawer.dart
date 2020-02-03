import 'package:base_app/util/analytics.dart';
import 'package:base_app/screens/home.dart';
import 'package:base_app/screens/login.dart';
import 'package:base_app/screens/tela2.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Juliana"),
            accountEmail: Text("j.fake@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.blue: Colors.white,
              child: Text("J", style: TextStyle(fontSize: 40.0), ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Tela 1'),
            onTap: () {
              print('Messages');
              Analytics.logEvent("drawer_click", {'button': 'Tela 1'});
              Navigator.pop(context);
              Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new HomeScreen())
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Tela 2"),
            subtitle: Text("subtela ..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print('Tela 2');
              Analytics.logEvent("drawer_click", {'button': 'Tela 2'});
              Navigator.pop(context);
              Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Tela2Screen())
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Login'),
            onTap: () {
              print('Login');
              Analytics.logEvent("drawer_click", {'button': 'Login'});
              Navigator.pop(context);
              Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new LoginPage())
              );
            }
          ),
        ],
      ),
    );
  }
}