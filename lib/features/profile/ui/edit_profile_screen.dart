import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../profile/domain/models/app_user.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _skillsController;

  bool _loading = true;
  AppUser? _user;
  bool edited = false;


  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _skillsController = TextEditingController();

    _loadProfile();
  }


  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      final profile = await context.read<EditProfileViewModel>().getProfile(uid);

      if (profile != null) {
        setState(() {
          _user = profile;
          _nameController.text = profile.name;
          _bioController.text = profile.bio;
          _skillsController.text = profile.skills.join(', ');

          _loading = false;
        });
      }
      else {
        // No profile yet
        setState(() => _loading = false);
      }
    }

  }


  Future<void> _saveProfile() async {

    if (!_formKey.currentState!.validate()) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || _user == null) return;

    final user = AppUser(
      uid: uid,
      name: _nameController.text.trim(),
      email: FirebaseAuth.instance.currentUser!.email ?? '',
      bio: _bioController.text.trim(),
      skills: _skillsController.text
          .trim()
          .split(',')
          .map((s) => s.trim())
          .toList(),
      lastEditedTime: DateTime.now().millisecondsSinceEpoch,
    );

    for (final entry in user.toMap().entries) {
      // skip uid, email, lastEditedTime
      if (entry.key == 'uid' ||
          entry.key == 'email' ||
          entry.key == 'lastEditedTime') {
        continue;
      }

      // check skills
      if (entry.key == 'skills') {
        if (entry.value.toString() != _user!.toMap()[entry.key].toString()) {
          edited = true;
          break;
        }
        continue;
      }

      // check name, bio
      if (entry.value != _user!.toMap()[entry.key]) {
        edited = true;
        break;
      }
    }

    if (!edited) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No changes to save')),
        );
      }

      return;
    }

    await context.read<EditProfileViewModel>().saveProfile(user);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Saved')),
      );
    }

  }


  @override
  Widget build(BuildContext context) {

    if (_loading) {
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
              const SizedBox(height: 24),
              Text('Last edited: ${DateTime.fromMillisecondsSinceEpoch(_user!.lastEditedTime).toString()}')
            ],
          ),
        ),
      ),

    );
  }


  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _skillsController.dispose();

    super.dispose();
  }

}
