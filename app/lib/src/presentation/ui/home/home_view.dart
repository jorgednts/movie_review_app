import 'package:app/src/presentation/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListenableBuilder(
          listenable: viewModel.fetchPopularMovies,
          builder: (_, child) {
            if (viewModel.fetchPopularMovies.running) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: viewModel.popularMovies.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(viewModel.popularMovies[index].title),
                  ),
            );
          },
        ),
      ),
    );
  }
}
