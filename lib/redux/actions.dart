import 'package:equatable/equatable.dart';

class InitConnectionAction extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangedConnectionAction extends Equatable {
  final bool isOffline;

  ChangedConnectionAction(this.isOffline);

  @override
  List<Object> get props => [isOffline];
}