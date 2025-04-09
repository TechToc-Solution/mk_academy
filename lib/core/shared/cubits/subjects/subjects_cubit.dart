import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/shared/repos/subjects/subjects_repo.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit(this._homeRepo) : super(SubjectsInitial());
  final SubjectsRepo _homeRepo;

  Future<void> getSubjects() async {
    emit(GetSubjectsLoading());
    var data = await _homeRepo.getSubjects();
    data.fold((failure) {
      emit(GetSubjectsError(erroMsg: failure.message));
    }, (subjects) {
      emit(GetSubjectsSuccess(subjectsData: subjects.subjectData!));
    });
  }
}
