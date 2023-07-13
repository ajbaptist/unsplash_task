import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/src/data/model/image_model.dart';
import 'package:task/src/data/repository/unsplash_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      emit(LoadingHomeState());
      var data = await UnsplashRepository.getImages();
      if (data != null) {
        emit(SuccessHomeState(data));
      } else {
        emit(FailedHomeState());
      }
    });

    on<GetSearchHomeEvent>((event, emit) async {
      emit(LoadingHomeState());
      var data = await UnsplashRepository.searchImage(query: event.query);
      if (data != null) {
        emit(SuccessHomeState(data));
      } else {
        emit(FailedHomeState());
      }
    });
  }
}
