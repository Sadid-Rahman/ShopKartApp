import 'package:flutter/material.dart';
import 'package:shopkart/functions/bottomnav.dart';
import 'package:shopkart/functions/api.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}


class _BrowseState extends State<Browse> {
  List categories = [];
  bool loading = true;
  @override
  void initState() {
    loadCategories();
    super.initState();
  }
  void loadCategories() async {
  final data = await fetchCategory(); // call external API
  setState(() {
    categories = data;
    loading = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return SizedBox(
                  width: double.infinity, // makes the button full width
                  height: 100,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue, // optional: button color
                        foregroundColor: Colors.white, // text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // makes corners square
                        )
                      ),
                      onPressed: () {},
                      child: Text(category['name']),  
                    ),
                  ),
                );
              },
            )
        ),
      bottomNavigationBar: MyBottomNavBar(selectedIndex: 1, onTap: (index){
        switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // browse page in use
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