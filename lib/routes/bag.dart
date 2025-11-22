import 'package:flutter/material.dart';
import 'package:shopkart/functions/bottomnav.dart';
import 'package:shopkart/routes/wishlist.dart';

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {

  List<dynamic> get wishlistProducts => productsInWishlist; // use global list

  double get totalPrice => wishlistProducts.fold(0, (sum, p) => sum + (p['price'] ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: wishlistProducts.isEmpty
                ? const Center(child: Text("Your bag is empty"))
                : ListView.builder(
                    itemCount: wishlistProducts.length,
                    itemBuilder: (context, index) {
                      final product = wishlistProducts[index];
                      return Card(
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              product['images'] != null && product['images'].isNotEmpty
                                  ? product['images'][0]
                                  : '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_not_supported);
                              },
                            ),
                          ),
                          title: Text(product['title'] ?? 'No Name'),
                          subtitle: Text("\$${product['price']?.toStringAsFixed(2) ?? '0.00'}"),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("\$${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/browse');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/wishlist');
              break;
            case 3:
              break; // already on bag
            case 4:
              Navigator.pushReplacementNamed(context, '/account');
              break;
          }
        },
      ),
    );
  }
}
