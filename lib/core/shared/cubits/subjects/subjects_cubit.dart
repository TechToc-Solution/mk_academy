import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/shared/repos/subjects/subjects_repo.dart';

part 'subjects_state.dart';

class subjectsCubit extends Cubit<subjectsState> {
  subjectsCubit(this._homeRepo) : super(SubjectsInitial());
  subjectsRepo _homeRepo;

  Future<void> getSubjects() async {
    var data = await _homeRepo.getSubjects();
    data.fold((failure) {
      emit(getSubjectsError(erroMsg: failure.message));
    }, (subjects) {
      emit(getSubjectsSucess(subjectsData: subjects.subjectData!));
    });
  }
}
