import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:task/src/bloc/home_bloc/home_bloc.dart';
import 'package:task/src/data/model/image_model.dart';
import 'package:task/src/presentation/crop_screen/crop_screen.dart';
import 'package:task/src/presentation/search_screen/search_screen.dart';

import '../widgets/image_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetHomeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton.filledTonal(
                onPressed: () {
                  Get.to(const SearchScreen());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is SuccessHomeState) {
              var e = state.model;
              return ImageView(e: e);
            } else if (state is LoadingHomeState) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Column();
          },
        ),
      ),
    );
  }
}
