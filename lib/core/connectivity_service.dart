import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Provides the internet connection state
class ConnectivityState extends Equatable {
  final bool isReady;
  final ConnectivityResult state;

  const ConnectivityState(
      {this.state = ConnectivityResult.none, this.isReady = false});

  @override
  List<Object?> get props => [];

  /// Returns a [ConnectivityState] with a new state
  ConnectivityState copyWith({ConnectivityResult? changes, bool? ready}) =>
      ConnectivityState(
          state: changes ?? state, isReady: ready ?? this.isReady);
}

/// A simple [Cubit] that manages the [ConnectivityState] as its state.
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityState()) {
    listenConnectionChanged();
  }

  /// Returns a [StreamSubscription<ConnectivityResult>] that :
  /// emit when the device's internet connection state change
  /// and call [editState]
  StreamSubscription<ConnectivityResult> listenConnectionChanged() =>
      Connectivity().onConnectivityChanged.listen((connectionState) {
        debugPrint('Connection changed : ${connectionState.name}');
        editState(connectionState);
      });

  /// update state with a new [ConnectivityResult]
  void editState(ConnectivityResult newState) =>
      emit(state.copyWith(changes: newState));

  /// update state with a new [ConnectivityResult]
  void editReady() {
    emit(state.copyWith(ready: !state.isReady));
  }
}
