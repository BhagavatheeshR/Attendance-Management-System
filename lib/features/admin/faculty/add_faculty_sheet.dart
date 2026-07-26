import 'package:flutter/material.dart';
import '../../../mock/departments.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../theme/app_spacing.dart';

Future<void> showAddFacultySheet(BuildContext context) {
  return showAppBottomSheet(
    context: context,
    title: 'Add Faculty',
    child: const _AddFacultyForm(),
  );
}

class _AddFacultyForm extends StatefulWidget {
  const _AddFacultyForm();

  @override
  State<_AddFacultyForm> createState() => _AddFacultyFormState();
}

class _AddFacultyFormState extends State<_AddFacultyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _empIdController = TextEditingController();
  final _emailController = TextEditingController();
  String? _department = mockDepartments.first.id;
  String _designation = 'Assistant Professor';
  bool _submitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_nameController.text} added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name', hintText: 'e.g. Dr. Nathan Bishop'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _empIdController,
              decoration: const InputDecoration(labelText: 'Employee ID', hintText: 'e.g. FAC099'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Employee ID is required' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _department,
              decoration: const InputDecoration(labelText: 'Department'),
              items: mockDepartments
                  .map((d) => DropdownMenuItem(value: d.id, child: Text(d.name)))
                  .toList(),
              onChanged: (v) => setState(() => _department = v),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _designation,
              decoration: const InputDecoration(labelText: 'Designation'),
              items: const ['Assistant Professor', 'Associate Professor', 'Professor', 'Senior Lecturer']
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => _designation = v ?? _designation),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', hintText: 'name@attence.edu'),
              validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Add Faculty',
              onPressed: _submit,
              isLoading: _submitting,
              fullWidth: true,
              icon: Icons.person_add_alt_1_rounded,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
