import 'package:emergency_group/app/models/group.dart';
import 'package:emergency_group/app/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'group_controller.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends ModularState<GroupPage, GroupController> {
  @override
  void initState() {
    super.initState();
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    final _group = ModalRoute.of(context).settings.arguments as GroupModel;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          _group.name,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.zero,
            onSelected: (value) {
              if (value == 'removeGroup')
                controller.deleteGroup(groupId: _group.id);
              if (value == 'addUser') _showContainer(context);
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                value: 'removeGroup',
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  title: Text('Apagar grupo'),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'addUser',
                child: ListTile(
                    leading: Icon(
                      Icons.person_add,
                      color: Colors.grey,
                    ),
                    title: Text('Adicionar usuário')),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.sendNotification();
        },
        child: Icon(Icons.warning),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<Object>(
          future: controller.getUserGroups(groupId: _group.id),
          builder: (context, _) {
            return Observer(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          height: 0,
                        ),
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      UserModel user = controller.users[index];
                      return ListTile(
                          title: Text('${user.fullname}'),
                          subtitle: Text(user.username),
                          trailing: controller.user.id == _group.ownerId
                              ? IconButton(
                                  onPressed: () {
                                    controller.removeUserGroup(
                                      groupId: _group.id,
                                      userId: user.id,
                                    );
                                    if (controller.user.id == user.id)
                                      Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    user.id == _group.ownerId
                                        ? Icons.exit_to_app
                                        : Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              : null);
                    }),
              ),
            );
          }),
    );
  }

  void _showContainer(BuildContext ctx) {
    final group = ModalRoute.of(ctx).settings.arguments as GroupModel;
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text('Adicione um usuário'),
        content: TextFormField(
          onChanged: controller.setUsername,
          initialValue: controller.username,
          decoration: InputDecoration(
            hintText: 'Digite o username do usuário...',
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
              await controller.addUserInGroup(
                groupId: group.id,
                username: controller.username,
                ctx: ctx,
              );
              Navigator.of(context).pop();
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
