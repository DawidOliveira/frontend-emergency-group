import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
