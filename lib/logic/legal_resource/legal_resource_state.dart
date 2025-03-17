// lib/logic/legal_resource/legal_resource_state.dart
import 'package:equatable/equatable.dart';

abstract class LegalResourceState extends Equatable {
  const LegalResourceState();
  @override
  List<Object?> get props => [];
}

/// For the list screen
class ResourcesLoading extends LegalResourceState {}

class ResourcesLoaded extends LegalResourceState {
  final List<Map<String, dynamic>> resources;
  const ResourcesLoaded({required this.resources});

  @override
  List<Object?> get props => [resources];
}

class ResourceDetailLoaded extends LegalResourceState {
  final Map<String, dynamic> resource;
  const ResourceDetailLoaded({required this.resource});

  @override
  List<Object?> get props => [resource];
}

class ResourceError extends LegalResourceState {
  final String error;
  const ResourceError({required this.error});
  @override
  List<Object?> get props => [error];
}

class ResourceInitial extends LegalResourceState {}
