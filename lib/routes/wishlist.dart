import 'package:flutter/material.dart';
import 'package:shopkart/functions/bottomnav.dart';
import 'package:shopkart/functions/product_card_widget.dart';
import 'package:shopkart/functions/api.dart'; // import API functions


List<dynamic> productsInWishlist = [];

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

// Function to add a product to the wishlist
void addToWishlist(Map<String, dynamic> product) {
  // Avoid duplicates if needed
  if (!productsInWishlist.any((p) => p['title'] == product['title'])) {
    productsInWishlist.add(product);
  }
}


class _WishlistState extends State<Wishlist> {
  List<bool> isFavorited = [];
  List products = [];
  bool loadingProducts = true;

  void loadProducts() async{
    final productItems = await fetchProducts();
    if (!mounted) return; 
    setState(() {
      products = productItems;

      // Initialize favorite status based on current wishlist
      isFavorited = productItems.map(
        (p) => productsInWishlist.any((w) => w['title'] == p['title'])
      ).toList();

      loadingProducts = false;
    });
  }
  
  @override
  void initState() {
    super.initState();
    loadProducts();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Your Favourites', 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )
              ),
              //products in wishlist
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsInWishlist.length,
                  itemBuilder:(context, index){
                    return ProductCard(
                      products: productsInWishlist, 
                      isFavorited: List<bool>.filled(productsInWishlist.length, true), 
                      index: index,
                      onFavoriteToggle: () {
                        setState(() {
                          //isFavorited[index] = !isFavorited[index];
                          if (isFavorited[index]) {
                            addToWishlist(products[index]);
                          } else {
                            productsInWishlist.remove(products[index]);
                          }
                        });
                      }
                    );
                  }),
              ),
              SizedBox(height: 8),
              // recommendations;
              Text(
                'Recommendations', 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )
              ),
              Expanded(
                child: loadingProducts ? Center(child: CircularProgressIndicator()) :
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder:(context, index){
                    return ProductCard(
                      products: products, 
                      isFavorited: isFavorited, 
                      index: index,
                      onFavoriteToggle: () {
                        setState(() {
                          // Toggle favorite status in isFavorited
                          isFavorited[index] = !isFavorited[index];

                          if (isFavorited[index]) {
                            // Add to wishlist
                            addToWishlist(products[index]);
                          } else {
                            // Remove from wishlist
                            productsInWishlist.removeWhere(
                              (p) => p['title'] == products[index]['title']
                            );
                          }
                        });
                      },
                    );
                  }
                ),
              ),
              SizedBox(height: 8),
              //checkout button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black54
                ),
                onPressed: (){
                  Navigator.pushReplacementNamed(
                    context, '/bag',arguments: {'wishlist_products': productsInWishlist}
                  );
                }, 
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                    ),
                  )
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 2, onTap: (index){
        switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/browse');
              break;
            case 2:
              //already in use
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/bag');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/account');
              break;
          }
        }
      ),
    );
  }
}