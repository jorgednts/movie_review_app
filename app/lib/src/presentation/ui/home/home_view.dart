import 'package:app/src/presentation/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListenableBuilder(
          listenable: viewModel.fetchMovies,
          builder: (_, child) {
            if (viewModel.fetchMovies.running) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: viewModel.movies.length,
              itemBuilder:
                  (context, index) =>
                      ListTile(title: Text(viewModel.movies[index].title)),
            );
          },
        ),
      ),
    );
  }
}
