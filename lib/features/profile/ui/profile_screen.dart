import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import '../../auth/ui/auth_screen.dart';
import '../domain/profile_model.dart';
import 'profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _skillsController;
  late TextEditingController _wishesController;

  String? _uid;
  String? _email;
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    _uid = profileViewModel.uid;
    _email = profileViewModel.email;
    _profile = profileViewModel.profile;
    final bool loading = profileViewModel.loading;
    // final Future<String> Function(ProfileModel newProfile) updateProfile =
    //     profileViewModel.updateProfile;

    _nameController = TextEditingController(text: _profile?.name);
    _bioController = TextEditingController(text: _profile?.bio);
    _skillsController = TextEditingController(
      // text: _profile?.skills.join(', '),
    );
    _wishesController = TextEditingController(
      // text: _profile?.wishes.join(', '),
    );

    if (_uid == null) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(Str.noUserInfoMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
            child: const Text(Str.signIn),
          ),
        ],
      );
    }

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text(Str.editProfile)),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: Str.name),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? Str.required : null,
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: Str.bio),
              ),
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(
                  labelText: Str.skillsInputDescription,
                ),
              ),
              TextFormField(
                controller: _wishesController,
                decoration: const InputDecoration(
                  labelText: Str.wishesInputDescription,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: const Text(Str.saveProfile),
              ),
              const SizedBox(height: 24),
              Text('${Str.email}: $_email'),
              const SizedBox(height: 24),
              if (_profile != null)
                Text(
                  '${Str.lastUpdated}: ${DateTime.fromMillisecondsSinceEpoch(_profile!.lastEditedTime).toString()}',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile(
    Future<String> Function(ProfileModel newProfile) updateProfile,
  ) async {
    String updatingResult;
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

    if (!_formKey.currentState!.validate()) {
      updatingResult = Str.fillRequiredFields;
    } else if (_uid == null) {
      updatingResult = Str.unknownErrorSignAgain;
    } else {
      final newProfile = ProfileModel(
        uid: _uid!,
        name: _nameController.text.trim(),
        email: _email!,
        bio: _bioController.text.trim(),
        // skills:
        //     _skillsController.text
        //         .trim()
        //         .split(',')
        //         .map((s) => s.trim())
        //         .toList(),
        // wishes:
        //     _wishesController.text
        //         .trim()
        //         .split(',')
        //         .map((s) => s.trim())
        //         .toList(),
        lastEditedTime: DateTime.now().millisecondsSinceEpoch,
      );

      updatingResult = await updateProfile(newProfile);
    }

      scaffoldMessengerState.showSnackBar(SnackBar(content: Text(updatingResult)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _skillsController.dispose();

    super.dispose();
  }
}
