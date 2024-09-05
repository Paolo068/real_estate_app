import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: 4, // Adjust the number of images as needed
                itemBuilder: (context, index) {
                  return Image.network(
                    'https://example.com/image${index + 1}.jpg', // Replace with your image URLs
                    fit: BoxFit.cover,
                  );
                },
              ),

              // Button and text
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle email login
                },
                child: const Text('Continue with Email'),
              ),
              const Text('OR'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle Google login
                    },
                    icon: const Icon(Icons.abc),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Facebook login
                    },
                    icon: const Icon(Icons.facebook),
                  ),
                ],
              ),
              const Text("Don't have an account? Register"),
            ],
          ),
        ),
      ),
    );
  }
}
