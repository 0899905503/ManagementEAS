part of 'main_cubit.dart';

class TkMainState extends Equatable {
  final LoadStatus loadDataStatus;
  final int selectedIndex;

  const TkMainState({
    this.loadDataStatus = LoadStatus.initial,
    this.selectedIndex = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        selectedIndex,
      ];

  TkMainState copyWith({
    LoadStatus? loadDataStatus,
    int? selectedIndex,
  }) {
    return TkMainState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
