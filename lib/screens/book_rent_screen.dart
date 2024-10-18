import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BooksEcommercePage extends StatefulWidget {
  @override
  _BooksEcommercePageState createState() => _BooksEcommercePageState();
}

class _BooksEcommercePageState extends State<BooksEcommercePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Featured',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.cartShopping, color: Colors.black),
            onPressed: () {
              // Shopping Cart Action
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.bars, color: Colors.black),
            onPressed: () {
              // Menu Action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Book Owners",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Give your Book to others in need and earn",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // Navigate to the book details
                              },
                              child: Row(children: [
                                const Text(
                                  "Explore Now",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'asset/images/book_shop_error.png', // Replace with the image of the featured book
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Section Title (Best Sellers)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Best Sellers",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to view all books
                    },
                    child: const Text(
                      "View all",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // GridView for Best Sellers
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: screenWidth / (screenHeight * 0.65),
                ),
                itemCount: books.length, // Number of books
                itemBuilder: (context, index) {
                  return BookCard(
                    book: books[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model for Book
class Book {
  final String title;
  final String imageUrl;
  final double price;

  Book({required this.title, required this.imageUrl, required this.price});
}

// List of Books
List<Book> books = [
  Book(
    title: "Civil Engineering Book",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuZKONiIZQQq3LtdPZwChIKEPYfpHkketTRA&s",
    price: 680,
  ),
  Book(
    title: "Eiegtering Engineering",
    imageUrl:
        "https://media.springernature.com/full/springer-static/cover-hires/book/978-3-030-78995-4",
    price: 580,
  ),
  Book(
    title: "Software Engineering Book",
    imageUrl:
        "https://vandanapublications.com/_app_data/PRODUCT/20231207174457-software-engineering-question-and-answer-book.jpg",
    price: 480,
  ),
  Book(
    title: "Mechanical Engineering",
    imageUrl:
        "https://www.madrasshoppe.com/142717-large_default/mechanical-engineering-rasheed-ahmed-khan-ali-hasan.jpg",
    price: 780,
  ),
];

// Widget to display each book
class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                book.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              style: const TextStyle(
                fontFamily: "Kanit-Regular",
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${book.price}Rs',
              style: const TextStyle(color: Colors.green),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.cartShopping, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
