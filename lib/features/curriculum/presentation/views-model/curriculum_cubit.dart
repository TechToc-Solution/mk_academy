import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/units_model.dart';
import '../../data/repos/curriculum_repo.dart';

part 'curriculum_state.dart';

class CurriculumCubit extends Cubit<CurriculumState> {
  final CurriculumRepo _curriculumRepo;
  CurriculumCubit(this._curriculumRepo) : super(CurriculumInitial());

  Future<void> getUnits({required int subjectId}) async {
    if (isClosed) return;
    emit(UnitsLoading());
    final result = await _curriculumRepo.fetchUnits(subjectId);
    if (!isClosed) {
      result.fold((failure) {
        emit(UnitsError(errorMsg: failure.message));
      }, (units) {
        emit(UnitsSuccess(units: units));
      });
    }
  }
}
