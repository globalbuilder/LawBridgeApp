// lib/presentation/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_bloc.dart';
import '../../../logic/profile/profile_event.dart';
import '../../../logic/profile/profile_state.dart';
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _navigateToEdit(BuildContext context, Map<String, dynamic> profileData) {
    Navigator.pushNamed(context, '/profile/edit');
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the token from AuthBloc
    final authState = context.watch<AuthBloc>().state;
    String? token;
    if (authState is AuthAuthenticated) {
      token = authState.accessToken;
    }

    if (token == null) {
      return const Scaffold(
        body: Center(child: Text('Not authenticated. Please log in.')),
      );
    }

    // Dispatch fetch with the token
    context.read<ProfileBloc>().add(FetchProfileEvent(token: token));

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFetched) {
            final profileData = {
              'id': state.id,
              'first_name': state.firstName,
              'last_name': state.lastName,
              'phone': state.phone,
              'address': state.address,
              'bio': state.bio,
              'image': state.imageUrl,
            };
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.imageUrl != null)
                    Center(
                      child: Image.network(
                        state.imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Center(child: Text('No profile image')),
                  const SizedBox(height: 24),
                  Text('Profile ID: ${state.id}'),
                  Text('First Name: ${state.firstName}'),
                  Text('Last Name: ${state.lastName}'),
                  Text('Phone: ${state.phone}'),
                  Text('Address: ${state.address}'),
                  Text('Bio: ${state.bio}'),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _navigateToEdit(context, profileData),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
