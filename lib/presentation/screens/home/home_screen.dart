import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/common/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'logout') {
                      context.read<AuthBloc>().add(LogoutRequested());
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          const Icon(Icons.logout, color: AppColors.error),
                          const SizedBox(width: AppDimensions.paddingS),
                          Text(AppStrings.logout),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return _buildHomeContent(context, state.user);
          } else if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, user) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back!',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.paddingXS),
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              user.email,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingL),

          // Dashboard Section
          Text(
            AppStrings.dashboard,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Total Projects',
                  '12',
                  Icons.folder_outlined,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Active Tasks',
                  '8',
                  Icons.task_outlined,
                  AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Completed',
                  '24',
                  Icons.check_circle_outline,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Pending',
                  '3',
                  Icons.schedule_outlined,
                  AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),

          CustomButton(
            text: 'Create New Project',
            onPressed: () {
              // TODO: Navigate to create project screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Create project functionality coming soon!'),
                ),
              );
            },
            icon: Icons.add,
          ),
          const SizedBox(height: AppDimensions.paddingM),

          CustomButton(
            text: 'View Profile',
            onPressed: () {
              // TODO: Navigate to profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile screen coming soon!'),
                ),
              );
            },
            type: ButtonType.outline,
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 