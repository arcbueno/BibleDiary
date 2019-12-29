import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  
  final BuildContext contexto;
  static final firstName = "Pedro";
  static final lastName = "Bueno";
  final initials = firstName[0]+lastName[0];
  
  MyDrawer({this.contexto});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("$firstName $lastName"),
            accountEmail: Text('parcb.augusto@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                initials,
                style: TextStyle(fontSize: 40),
              ),
            ),
            
          ),
          _tile('Tela inicial',Icons.home, context),
          _tile('Novo período de estudo',Icons.timer, context, '/newStudy'),
          _tile('Configurações', Icons.settings, context, '/settings')
        ],
      ),
    );
  }

  Widget _tile(text, icon, context,[route = '/']){
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      }
    );
  }
}


