import 'package:boh_hummm/config/connection_db/i_connection_db.dart';
import 'package:boh_hummm/config/connection_db/impl/connection_db_sqlite.dart';
import 'package:boh_hummm/controller/controller.dart';
import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/dao/impl/delivery_dao.dart';
import 'package:boh_hummm/dao/impl/user_dao.dart';
import 'package:boh_hummm/model/delivery_model.dart';
import 'package:boh_hummm/model/user_model.dart';
import 'package:flutter/material.dart';

class DeliveriesView extends StatefulWidget {
  const DeliveriesView({
    super.key,
  });

  @override
  State<DeliveriesView> createState() => _DeliveriesViewState();
}

class _DeliveriesViewState extends State<DeliveriesView> {
  final IConnectionDb connection = ConnectionDbSqlite();
  late final IDao userDao;
  late final IDao deliveryDao;
  late final Controller<UserModel> controller;
  late final Controller<DeliveryModel> controllerDelivery;
  UserModel? userModel;
  late List<Map<String, Object?>> listOrdersFees = [];
  int _selectedIndex = 0;
  final _orderController = TextEditingController();
  final _feeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDao = UserDao(connection: connection);
    deliveryDao = DeliveryDao(connection: connection);
    controller = Controller(dao: userDao);
    controllerDelivery = Controller(dao: deliveryDao);
    _loadUser();
    _loadOrdersFees();
  }

  Future<void> _loadUser() async {
    var user = await controller.fetchDataById(id: 1);
    setState(() {
      userModel = user;
    });
  }

  Future<void> _loadOrdersFees() async {
    var ordersFees = await controllerDelivery.fetchAllData();
    setState(() {
      listOrdersFees = ordersFees;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double taxa = 0.0;
    listOrdersFees.forEach((e) => taxa += double.tryParse(e['del_fee'].toString())!);

    final widgetOptions = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: _orderController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                labelText: 'Comanda',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: _feeController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                labelText: 'Taxa',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                controllerDelivery.addData(
                  DeliveryModel(
                    del_order: int.tryParse(_orderController.text),
                    del_fee: double.tryParse(_feeController.text),
                    del_delr_id: 1,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Inserir'),
            ),
          ),
        ],
      ),
      listOrdersFees.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemCount: listOrdersFees.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.deepPurple[100],
                    child: ListTile(
                      title: Text(
                        'Comanda: ${listOrdersFees[index]['del_order'].toString()}',
                      ),
                      subtitle: Text(
                        'Taxa: R\$${listOrdersFees[index]['del_fee'].toString()}',
                      ),
                    ),
                  );
                },
              ),
            ),
      Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Entregas: ${listOrdersFees.length}',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Total: ${taxa.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height / 7),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          toolbarHeight: double.infinity,
          leadingWidth: double.infinity,
          leading: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: size.width / 8,
                  child: Icon(
                    Icons.person,
                    size: size.width / 7,
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 29,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    userModel?.use_name ?? 'Loading',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.width / 100,
                  ),
                  Text(
                    userModel?.use_email ?? 'Loading',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Entregas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Ganhos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
