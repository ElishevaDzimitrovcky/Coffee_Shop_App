import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../components/coffeeTile.dart';
import '../model/coffee.dart';
import '../model/coffee_shop.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Manager'),
      ),
      body: Consumer<CoffeeShop>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, top: 25, bottom: 25),
                  child: Text(
                    'Manage Products',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: productNameController,
                        decoration: InputDecoration(labelText: 'Product Name'),
                      ),
                      TextField(
                        controller: productPriceController,
                        decoration: InputDecoration(labelText: 'Product Price'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                            labelText: 'Image URL', prefixText: "lib/images/"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => {
                          
                          Provider.of<CoffeeShop>(context, listen: false)
                              .addItemProduct(
                                  productNameController.text,
                                  double.parse(productPriceController.text),
                                  imageController.text),
                          productNameController.clear(),
                          productPriceController.clear(),
                          imageController.clear()
                        },
                        child: Text('Add Product'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: const Text(
                    'Cart Items',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.coffeeShope.length,
                  itemBuilder: (context, index) {
                    Coffee coffee = value.coffeeShope[index];
                    return CoffeeTileCartManager(
                      coffee: coffee,
                      onPressed: () =>
                          Provider.of<CoffeeShop>(context, listen: false)
                              .removeItem(coffee),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
