import 'package:flutter/material.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({Key? key}) : super(key: key);

  // Dummy Data for cards
  final List<Map<String, String>> dummyData = [
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 1', 'price': '\$100'},
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 2', 'price': '\$120'},
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 3', 'price': '\$90'},
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 4', 'price': '\$110'},
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 5', 'price': '\$80'},
    {'image': 'https://via.placeholder.com/150', 'actor': 'Actor 6', 'price': '\$95'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Adjust the height of cards
          ),
          itemCount: dummyData.length,
          itemBuilder: (context, index) {
            final item = dummyData[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image at the top of the card
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      item['image']!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Actor name at the bottom of the image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['actor']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Price and Book Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price Text
                        Text(
                          item['price']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        // Book Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Book', style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
