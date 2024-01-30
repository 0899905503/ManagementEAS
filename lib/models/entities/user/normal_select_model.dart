import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NormalSelectModel extends Equatable {
  int? id;
  int? otherId;
  String? key;
  String? display;

  NormalSelectModel(this.id, this.display, {this.key, this.otherId});

  factory NormalSelectModel.empty() {
    return NormalSelectModel(null, null);
  }

  @override
  List<Object?> get props => [id, display, key, otherId];
}
