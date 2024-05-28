import 'package:flutter/material.dart';
import 'book_detail_page.dart';
import 'add_book_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String searchQuery = '';

  final List<Map<String, String>> books = [
    {
      'title': '1984',
      'author': 'George Orwell',
      'cover': 'assets/1984.jpg',
      'description': 'A dystopian novel set in a totalitarian society ruled by Big Brother.',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'cover': 'assets/mockingbird.jpg',
      'description': 'A novel about the serious issues of rape and racial inequality.',
    },
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'cover': 'assets/gatsby.jpg',
      'description': 'A story about the young and mysterious millionaire Jay Gatsby and his obsession with Daisy Buchanan.',
    },
  ];

  void _navigateToBookDetail(BuildContext context, Map<String, String> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }

  void _addBook(Map<String, String> book) {
    setState(() {
      books.add(book);
    });
  }

  void _editBook(Map<String, String> updatedBook, int index) {
    setState(() {
      books[index] = updatedBook;
    });
  }

  void _deleteBook(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this book?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: _BooksSearchDelegate(),
              );
              if (query != null) {
                setState(() {
                  searchQuery = query;
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          if (searchQuery.isEmpty ||
              book['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              book['author']!.toLowerCase().contains(searchQuery.toLowerCase())) {
            return ListTile(
              leading: SizedBox(
                width: 40,
                height: 60,
                child: Image.asset(book['cover']!, fit: BoxFit.cover),
              ),
              title: Text(book['title']!),
              subtitle: Text(book['author']!),
              onTap: () => _navigateToBookDetail(context, book),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBookPage(
                            onAddBook: (updatedBook) => _editBook(updatedBook, index),
                            existingBook: book,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteBook(context, index),
                  ),
                ],
              ),
            );
          } else {
            return Container(); // Empty container if the book should be filtered out
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(onAddBook: _addBook),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BooksSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Not used, as results are shown in the ListView.builder
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = [
      '1984',
      'To Kill a Mockingbird',
      'The Great Gatsby',
    ]; // Replace with your actual list of book titles

    final List<String> filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions.where((title) => title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            close(context, suggestion);
          },
        );
      },
    );
  }
}
