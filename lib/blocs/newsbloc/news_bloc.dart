import 'package:news_app/blocs/newsbloc/news_events.dart';
import 'package:news_app/blocs/newsbloc/news_states.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  final NewsRepository newsRepositoty;

  NewsBloc({required this.newsRepositoty}) : super(NewsLoadingState()) {
    on<StartEvent>(_onStartEvent);
  }

  Future<void> _onStartEvent(StartEvent event, Emitter<NewsStates> emit) async {
    emit(NewsLoadingState());

    try {
      List<ArticleModel> _articleList = await newsRepositoty.fetchNews();
      emit(NewsLoadedState(articleList: _articleList));
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
