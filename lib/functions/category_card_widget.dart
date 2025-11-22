import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  //parameters
  final List categories;
  final int index;

  //contructor
  const CategoryCard({
    super.key,
    required this.categories,
    required this.index,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final category = widget.categories[widget.index];
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                category['image'] ?? '', // use empty string if null
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100, // adjust size
                errorBuilder: (context, error, stackTrace) {
                  // show Flutter icon if image fails to load
                  return const Center(
                    child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category['name'] ?? 'No Name'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}