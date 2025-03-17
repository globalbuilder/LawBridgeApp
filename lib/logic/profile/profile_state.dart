// lib/logic/profile/profile_state.dart
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFetched extends ProfileState {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String bio;
  final String? imageUrl;
  const ProfileFetched({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.bio,
    this.imageUrl,
  });
  @override
  List<Object?> get props => [id, firstName, lastName, phone, address, bio, imageUrl ?? ''];
}

class ProfileUpdated extends ProfileState {
  final String message;
  const ProfileUpdated({required this.message});
  @override
  List<Object?> get props => [message];
}

class ProfileError extends ProfileState {
  final String error;
  const ProfileError({required this.error});
  @override
  List<Object?> get props => [error];
}
