import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/app_state.dart';
import '../../core/app_flavor.dart';
import '../../core/constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/info_chip.dart';
import '../../shared/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  final AppFlavor flavor;
  const LoginScreen({super.key, required this.flavor});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  List<UserRole> get _availableRoles => widget.flavor.availableRoles;

  late UserRole _selectedRole = _availableRoles.first;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;
  late final AnimationController _fadeController;

  static const Map<UserRole, String> _demoEmails = {
    UserRole.admin: 'admin@attence.edu',
    UserRole.faculty: 'emily.carter@attence.edu',
    UserRole.student: 'sarathy.b@attence.edu',
  };

  @override
  void initState() {
    super.initState();
    _emailController.text = _demoEmails[_selectedRole]!;
    _passwordController.text = '••••••••';
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _selectRole(UserRole role) {
    setState(() {
      _selectedRole = role;
      _emailController.text = _demoEmails[role]!;
    });
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    AppStateScope.of(context).login(_selectedRole);
    setState(() => _isLoading = false);
    switch (_selectedRole) {
      case UserRole.admin:
        context.go('/admin/dashboard');
        break;
      case UserRole.faculty:
        context.go('/faculty/dashboard');
        break;
      case UserRole.student:
        context.go('/student/dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Soft brand-tinted backdrop (no loud gradients, just a gentle wash).
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEFF6FF), Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
              ),
            ),
          ),
          Positioned(
            top: -80,
            right: -60,
            child: _blob(220, AppColors.primary.withValues(alpha: 0.10)),
          ),
          Positioned(
            bottom: -100,
            left: -80,
            child: _blob(260, AppColors.success.withValues(alpha: 0.08)),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeController,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl, horizontal: AppSpacing.lg),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: GlassContainer(child: _buildForm(context)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _buildForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
          alignment: Alignment.center,
          child: const Icon(Icons.fact_check_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(AppConstants.appName, style: AppTextStyles.displaySm(AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text('Sign in to continue to your dashboard', style: AppTextStyles.bodyMd(AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.md),
        InfoChip(
          icon: widget.flavor == AppFlavor.admin ? Icons.language_rounded : Icons.smartphone_rounded,
          label: widget.flavor == AppFlavor.admin ? 'Web console · Administrator access' : 'App · Faculty & Student access',
        ),
        const SizedBox(height: AppSpacing.xl),
        if (_availableRoles.length > 1) ...[
          Text('I am signing in as', style: AppTextStyles.labelMd(AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.sm),
          _RoleSegmentedControl(roles: _availableRoles, selected: _selectedRole, onChanged: _selectRole),
          const SizedBox(height: AppSpacing.xl),
        ],
        Text('Email', style: AppTextStyles.labelMd(AppColors.textSecondary)),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(hintText: 'you@attence.edu', prefixIcon: Icon(Icons.mail_outline_rounded, size: 20)),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Password', style: AppTextStyles.labelMd(AppColors.textSecondary)),
        const SizedBox(height: 6),
        TextField(
          controller: _passwordController,
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: () {}, child: const Text('Forgot password?')),
        ),
        const SizedBox(height: AppSpacing.md),
        PrimaryButton(label: 'Sign in', onPressed: _submit, isLoading: _isLoading, fullWidth: true),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Text(
            _availableRoles.length > 1
                ? 'Demo credentials are pre-filled — just pick a role and sign in.'
                : 'Demo credentials are pre-filled — just sign in.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption(AppColors.textTertiary),
          ),
        ),
      ],
    );
  }
}

class _RoleSegmentedControl extends StatelessWidget {
  final List<UserRole> roles;
  final UserRole selected;
  final ValueChanged<UserRole> onChanged;

  const _RoleSegmentedControl({required this.roles, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.hover,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: roles.map((role) {
          final isSelected = role == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(role),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.card : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  boxShadow: isSelected
                      ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6, offset: const Offset(0, 1))]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  role.shortLabel,
                  style: AppTextStyles.labelMd(isSelected ? AppColors.primary : AppColors.textSecondary),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
