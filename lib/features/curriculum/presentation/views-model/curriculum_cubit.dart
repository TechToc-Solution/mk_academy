import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/lesson_model.dart';
import '../../data/model/units_model.dart';
import '../../data/repos/curriculum_repo.dart';

part 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  final CurriculumRepo _curriculumRepo;
  List<Lesson> lessons = [];
  int currentPage = 1;
  bool hasReachedMax = false;

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
    if (isClosed || hasReachedMax) return;

    if (!loadMore) {
      currentPage = 1;
      hasReachedMax = false;
      lessons.clear();
      emit(LessonsLoading(isFirstFetch: true));
    } else {
      emit(LessonsLoading(isFirstFetch: false));
    }

    final result = await _curriculumRepo.fetchLessons(unitId, currentPage);

    if (!isClosed) {
      result.fold(
        (failure) => emit(LessonsError(errorMsg: failure.message)),
        (lessonsModel) {
          currentPage++;
          hasReachedMax = !lessonsModel.hasNext;
          lessons = [...lessons, ...lessonsModel.lessons];
          emit(LessonsSuccess());
        },
      );
    }
  }

  void resetLessonsPagination() {
    currentPage = 1;
    hasReachedMax = false;
    lessons = [];
    emit(CurriculumInitial());
  }
}
