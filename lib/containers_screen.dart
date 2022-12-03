import 'package:flutter/material.dart';
import 'package:flutter_application_1/container_model.dart';

class ContainersScreen extends StatelessWidget {
  ContainersScreen(this.containers);

  List<ContainerModel> containers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Containers'),
      ),
      body: ListView.builder(
        itemCount: containers.length,
        itemBuilder: (BuildContext context, int index) {
          final container = containers[index];
          return Card(
            child: ListTile(
              leading: Text(container.id),
              title: Text(container.getWestType(containers[index].typeWaste!)),
              subtitle: Text(container.localNumber),
              trailing: Text(
                container.getColorName(containers[index].wasteTypeColorName!),
              ),
            ),
          );
        },
      ),
    );
  }
}
