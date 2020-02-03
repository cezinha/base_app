import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isOffline;

  AppState({
    this.isOffline = false,
  });

  AppState.fromJson(Map<String, dynamic> json): isOffline = json['isOffline'];

  Map<String, dynamic> toJson() => {'isOffline': isOffline};

  @override
  String toString() {
    return 'AppState{isOffline: $isOffline}';
  }

  @override
  List<Object> get props => [isOffline];
}