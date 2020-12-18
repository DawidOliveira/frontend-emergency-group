import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Seus grupos"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _fcm = FirebaseMessaging();

  _showContainer(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text('Crie um grupo'),
        content: TextFormField(
          onChanged: controller.setName,
          initialValue: controller.name,
          decoration: InputDecoration(
            hintText: 'Digite o nome do seu grupo...',
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          FlatButton(
            onPressed: () async {
              await controller.createGroup();
              Navigator.of(context).pop();
            },
            child: Text('Criar'),
          ),
        ],
      ),
    );
  }

  _showMessage(Map<String, dynamic> message) {
    final url =
        message['notification']['body'].toString().split(" ").last.toString();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message['notification']['title']),
            actions: [
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () async {
                  if (await canLaunch(url))
                    await launch(url);
                  else
                    throw 'Não pode ser aberto este link';
                },
                child: Text('Abrir no maps'),
              ),
            ],
            content: Text(message['notification']['body']),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        _showMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _showMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _showMessage(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: controller.signOut,
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContainer(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Observer(builder: (context) {
          if (controller.listGroups == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: controller.getGroups,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
              itemCount: controller.listGroups.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('/group',
                      arguments: controller.listGroups[index]);
                },
                title: Text('${controller.listGroups[index].name}'),
              ),
            ),
          );
        }),
      ),
    );
  }
}
