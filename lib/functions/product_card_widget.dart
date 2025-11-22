import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  
  // parameters
  final List products;
  final List<bool> isFavorited;
  final int index;
  final VoidCallback? onFavoriteToggle;

  //contructor
  const ProductCard(
    {
      super.key,
      required this.products,
      required this.isFavorited,
      required this.index,
      required this.onFavoriteToggle,
    });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Flexible(
                  child: Stack(
                    children : [ 
                      SizedBox(
                        width: double.infinity, // forces full width of parent (card)
                        child: Image.network(
                          widget.products[widget.index]['images'][0] ?? '', // use empty string if null
                          fit: BoxFit.fill,
                                                          
                          errorBuilder: (context, error, stackTrace) {
                            // show Flutter icon if image fails to load
                            return const Center(
                              child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: (){
                             if (widget.onFavoriteToggle != null) {
                              widget.onFavoriteToggle!();
                            }
                            // Handle wishlist action 
                          }, 
                            icon: Icon(
                            widget.isFavorited[widget.index] ? Icons.favorite : Icons.favorite_border),
                            color: Colors.red,
                            iconSize: 30,
                          )
                      )
                    ]
                  ),
                ),
                SizedBox(height: 16),
                Text(widget.products[widget.index]['title'] ?? 'No Name'
                    , style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
                Text(
                  "\$${widget.products[widget.index]['price']?.toStringAsFixed(2) ?? '0.00'}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                  )),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}