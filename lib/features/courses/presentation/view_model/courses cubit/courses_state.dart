part of 'courses_cubit.dart';

enum CoursesStatus { initial, loading, success, failure }

class CoursesState extends Equatable {
  final CoursesStatus status;
  final List<Courses> courses;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;
  final bool isFirstFetch;

  const CoursesState({
    this.status = CoursesStatus.loading,
    this.courses = const [],
    this.hasReachedMax = false,
    this.isFirstFetch = true,
    this.currentPage = 0,
    this.errorMessage,
  });

  CoursesState copyWith({
    CoursesStatus? status,
    List<Courses>? courses,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return CoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        courses,
        hasReachedMax,
        currentPage,
        errorMessage,
        isFirstFetch
      ];
}
