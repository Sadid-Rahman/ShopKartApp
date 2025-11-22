import 'package:flutter/material.dart';
import 'package:shopkart/functions/bottomnav.dart'; // import bottom nav bar
import 'package:shopkart/functions/api.dart'; // import API functions
import 'package:shopkart/functions/product_card_widget.dart'; // import product card widget
import 'package:shopkart/functions/category_card_widget.dart'; // import category card widget 
import 'package:shopkart/routes/wishlist.dart';


class SessionManager {
  SessionManager._privateConstructor();
  static final SessionManager instance = SessionManager._privateConstructor();

  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;
  void setUser(Map<String, dynamic> user) => _user = user;
  void clear() => _user = null;
}



class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [];
  List products = [];
  bool loading = true;
  bool loadingProducts = true;
  List<bool> isFavorited = [];
  Map<String, dynamic>? user;


 @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    // If logout was triggered
    if (args != null && args is Map && args['logout'] == true) {
      SessionManager.instance.clear(); // CLEAR SESSION
      user = null;                     // Forget local user
      setState(() {});                 // refresh UI
      return;
    }

    if (args != null && args is Map<String, dynamic> && args['id'] != null) {
    user = args;
    SessionManager.instance.setUser(args); // update session
    } else {
      // fallback: get from session
      user = SessionManager.instance.user;
    }

    // If session empty and arguments contain user data
    if (user == null && args != null && args is Map<String, dynamic>) {
      user = args;
      SessionManager.instance.setUser(args); // store user in session
    }
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
    loadProducts();
  }

  

  void loadCategories() async {
    final data = await fetchCategory(); // call external API
    if (!mounted) return; 
    setState(() {
      categories = data;
      loading = false;
    });
  }

  void loadProducts() async {
    final productItems = await fetchProducts();
    if (!mounted) return; 
    setState(() {
      products = productItems;
      // Set isFavorited based on productsInWishlist
      isFavorited = productItems.map((p) => productsInWishlist.any((w) => w['title'] == p['title'])).toList();
      loadingProducts = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    /*
    final usr = ModalRoute.of(context)?.settings.arguments;
    if (usr != null && usr is Map<String, dynamic>) {
      user = usr;
      //print(user?['avatar']);
    }
    */
    //print(user?['username'].toString());
    //user = SessionManager.instance.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user != null && user!['username'] != null && user!['username'].isNotEmpty
          ? 'Welcome to ShopKart, ${user!['username'].toString()}'
          : 'ShopKart',
            style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        leading: user?['avatar'] != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/dashboard', arguments: user);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'http://localhost:3000/uploads/${user!['avatar']}',
                ),
              ),
            ),
          ) : null,
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //products
              const Text(
                "Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              loading ? const Center(child: CircularProgressIndicator()): Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index){
                    return ProductCard(
                      products: products, 
                      isFavorited: isFavorited, 
                      index: index,
                      onFavoriteToggle: () {
                        setState(() {
                          isFavorited[index] = !isFavorited[index];
                          if (isFavorited[index]) {
                            addToWishlist(products[index]);
                          } else {
                            productsInWishlist.removeWhere((p) => p['title'] == products[index]['title']);
                          }
                        });
                      }
                    );
                  }
                )
              ),
              
              //Categories
              SizedBox(height: 8),
              const Text(
                "Categories",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              loading ? const Center(child: CircularProgressIndicator()) : Expanded(
                child: GridView.builder(
                  gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(categories: categories, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 0,
        onTap: (index){
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