import 'package:flutter/material.dart';
import '../../../mock/departments.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../theme/app_spacing.dart';

/// Presents the "Add Student" form. This is a UI-only mock: it validates
/// input and shows a success confirmation, but doesn't persist — wiring
/// this to a real repository later is a matter of replacing the
/// [PrimaryButton] onPressed with a repository call.
Future<void> showAddStudentSheet(BuildContext context) {
  return showAppBottomSheet(
    context: context,
    title: 'Add Student',
    child: const _AddStudentForm(),
  );
}

class _AddStudentForm extends StatefulWidget {
  const _AddStudentForm();

  @override
  State<_AddStudentForm> createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<_AddStudentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  String? _department = mockDepartments.first.id;
  String _year = 'I';
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
              decoration: const InputDecoration(labelText: 'Full name', hintText: 'e.g. Ananya Reddy'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _rollController,
              decoration: const InputDecoration(labelText: 'Roll number', hintText: 'e.g. CSE23099'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Roll number is required' : null,
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
              initialValue: _year,
              decoration: const InputDecoration(labelText: 'Year'),
              items: const ['I', 'II', 'III', 'IV']
                  .map((y) => DropdownMenuItem(value: y, child: Text('Year $y')))
                  .toList(),
              onChanged: (v) => setState(() => _year = v ?? 'I'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', hintText: 'name@attence.edu'),
              validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Add Student',
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
