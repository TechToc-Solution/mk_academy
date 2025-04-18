import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/lesson_model.dart';
import '../../data/model/units_model.dart';
import '../../data/repos/curriculum_repo.dart';

part 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  final CurriculumRepo _curriculumRepo;
  List<Lesson> lessons = [];
  int _currentPage = 1;
  bool hasReachedMax = false;
  bool _isFetching = false;
  CurriculumCubit(this._curriculumRepo) : super(CurriculumInitial());

  Future<void> getUnits({required int subjectId}) async {
    if (isClosed) return;
    emit(UnitsLoading());
    final result = await _curriculumRepo.fetchUnits(subjectId);
    if (!isClosed) {
      result.fold((failure) {
        emit(UnitsError(errorMsg: failure.message));
      }, (unitsModel) {
        emit(UnitsSuccess(units: unitsModel.units));
      });
    }
  }

  Future<void> getLessons(int unitId, {bool loadMore = false}) async {
    if (_isFetching || isClosed || (hasReachedMax && loadMore)) return;
    _isFetching = true;
    try {
      if (!loadMore) {
        _currentPage = 1;
        hasReachedMax = false;
        lessons.clear();
        emit(LessonsLoading(isFirstFetch: true));
      } else {
        emit(LessonsLoading(isFirstFetch: false));
      }

      final result = await _curriculumRepo.fetchLessons(unitId, _currentPage);

      if (!isClosed) {
        result.fold(
          (failure) => emit(LessonsError(errorMsg: failure.message)),
          (lessonsModel) {
            _currentPage++;
            hasReachedMax = !lessonsModel.hasNext;
            lessons = [...lessons, ...lessonsModel.lessons];
            emit(LessonsSuccess());
          },
        );
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> getLessonDetails(int lessonId) async {
    if (isClosed) return;

    emit(LessonDetailsLoading(lessonId: lessonId));

    final result = await _curriculumRepo.fetchLessonDetails(lessonId);

    if (!isClosed) {
      result.fold(
        (failure) => emit(LessonDetailsError(errorMsg: failure.message)),
        (lesson) => emit(LessonDetailsSuccess(lesson: lesson)),
      );
    }
  }

  void resetLessonsPagination() {
    _currentPage = 1;
    hasReachedMax = false;
    lessons.clear();
    emit(CurriculumInitial());
  }
}
