import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../widgets/image_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static final GlobalKey<FormState> key = GlobalKey<FormState>();
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        key: key,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Search Screen'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<HomeBloc>()
                                .add(GetSearchHomeEvent(controller.text));
                          },
                          icon: Icon(Icons.search)),
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if (state is SuccessHomeState) {
                      var e = state.model;
                      return Expanded(child: ImageView(e: e));
                    } else if (state is LoadingHomeState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Center(
                        child:
                            Text('Images Not Found on ${controller.text}  '));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
