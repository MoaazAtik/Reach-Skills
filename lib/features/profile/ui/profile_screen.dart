import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import '../../auth/ui/auth_viewmodel.dart';
import '../domain/profile_model.dart';
import 'profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _skillsController;
  late TextEditingController _wishesController;

  String? _uid;
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    _uid = context.read<AuthViewModel>().currentUser?.uid;
    context.read<ProfileViewModel>().loadProfile(_uid);
  }

  @override
  Widget build(BuildContext context) {

    _profile = context.watch<ProfileViewModel>().profile;
    bool loading  = context.watch<ProfileViewModel>().loading;

    _nameController = TextEditingController(text: _profile?.name);
    _bioController = TextEditingController(text: _profile?.bio);
    _skillsController = TextEditingController(text: _profile?.skills.join(', '));
    _wishesController = TextEditingController(text: _profile?.wishes.join(', '));

    if (_uid == null || _profile == null) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text('No user info available.'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
            },
            child: const Text('Sign in'),
          ),
        ],
      );
    }

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                value == null || value.isEmpty
                    ? 'Required'
                    : null,
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(
                    labelText: 'Skills (comma-separated)'),
              ),
              TextFormField(
                controller: _wishesController,
                decoration: const InputDecoration(
                    labelText: 'Wishes (comma-separated)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
              const SizedBox(height: 24),
              Text('Last edited: ${DateTime.fromMillisecondsSinceEpoch(_profile!.lastEditedTime).toString()}')
            ],
          ),
        ),
      ),

    );
  }


  Future<void> _saveProfile() async {
    String updatingResult;

    if (!_formKey.currentState!.validate()) {
      updatingResult = 'Please fill in all required fields.';
    } else if (_uid == null || _profile == null) {
      updatingResult = 'Unknown Error. Try signing out and signing in again.';
    } else {
      final newProfile = ProfileModel(
        uid: _uid!,
        name: _nameController.text.trim(),
        email: _profile!.email,
        bio: _bioController.text.trim(),
        skills: _skillsController.text
            .trim()
            .split(',')
            .map((s) => s.trim())
            .toList(),
        wishes: _wishesController.text
            .trim()
            .split(',')
            .map((s) => s.trim())
            .toList(),
        lastEditedTime: DateTime
            .now()
            .millisecondsSinceEpoch,
      );

      updatingResult =
      await context.read<ProfileViewModel>().updateProfile(newProfile);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(updatingResult)),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _skillsController.dispose();

    super.dispose();
  }

}
