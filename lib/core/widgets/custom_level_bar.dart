import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

class CustomLevelBar extends StatelessWidget {
  const CustomLevelBar({
    super.key,
    this.showProfile = true,
    this.compact = false,
  });

  final bool showProfile;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return compact
              ? _AnimatedCompactLevelBar(
                  userModel: state.userModel,
                  showProfile: showProfile,
                )
              : _AnimatedLevelBar(
                  userModel: state.userModel,
                  showProfile: showProfile,
                );
        } else if (state is ProfileError) {
          return const SizedBox.shrink();
        }
        return Center(
            child: compact
                ? LinearProgressIndicator()
                : CircularProgressIndicator());
      },
    );
  }
}

class _AnimatedCompactLevelBar extends StatefulWidget {
  final dynamic userModel;
  final bool showProfile;

  const _AnimatedCompactLevelBar({
    required this.userModel,
    required this.showProfile,
  });

  @override
  State<_AnimatedCompactLevelBar> createState() =>
      _AnimatedCompactLevelBarState();
}

class _AnimatedCompactLevelBarState extends State<_AnimatedCompactLevelBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Ensure we don't divide by zero and clamp the value between 0 and 1
    final maxPoints = widget.userModel.maxPoints ?? 1;
    final currentPoints = widget.userModel.points ?? 0;
    final progressValue = (currentPoints / maxPoints).clamp(0.0, 1.0);

    _progressAnimation = Tween<double>(
      begin: 0,
      end: progressValue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuart,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nextLevel = int.parse(widget.userModel.level!) + 1;
    final maxPoints = widget.userModel.maxPoints ?? 1;
    final currentPoints = widget.userModel.points ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showProfile) _buildUserProfile(),
        ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${"level".tr(context)} ${widget.userModel.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${"level".tr(context)} $nextLevel',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            // Background track
                            Container(
                              height: 8,
                              width: constraints.maxWidth,
                              decoration: BoxDecoration(
                                color: AppColors.avatarColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            // Progress bar
                            Container(
                              height: 8,
                              width: constraints.maxWidth *
                                  _progressAnimation.value,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryColors,
                                    AppColors.primaryColors.withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            // Glow at start
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColors,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColors
                                        .withOpacity(0.8),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            // Glow at end when progress > 0
                            if (_progressAnimation.value > 0)
                              Positioned(
                                left: constraints.maxWidth *
                                        _progressAnimation.value -
                                    4,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColors,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColors
                                            .withOpacity(0.8),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 2),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$currentPoints/$maxPoints ${"xp".tr(context)}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        // CircleAvatar(
        //   radius: 36,
        //   backgroundColor: AppColors.primaryColors.withOpacity(0.2),
        //   child: const Icon(
        //     Icons.person,
        //     size: 36,
        //     color: Colors.white,
        //   ),
        // ),
        // const SizedBox(height: 8),
        Text(
          "${widget.userModel.firstName} ${widget.userModel.lastName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _AnimatedLevelBar extends StatefulWidget {
  final dynamic userModel;
  final bool showProfile;

  const _AnimatedLevelBar({
    required this.userModel,
    required this.showProfile,
  });

  @override
  State<_AnimatedLevelBar> createState() => _AnimatedLevelBarState();
}

class _AnimatedLevelBarState extends State<_AnimatedLevelBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Ensure we don't divide by zero and clamp the value between 0 and 1
    final maxPoints = widget.userModel.maxPoints ?? 1;
    final currentPoints = widget.userModel.points ?? 0;
    final progressValue = (currentPoints / maxPoints).clamp(0.0, 1.0);

    _progressAnimation = Tween<double>(
      begin: 0,
      end: progressValue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuint,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showProfile) _buildUserProfile(),
          const SizedBox(height: 12),
          _buildLevelProgressBar(context),
        ],
      ),
    );
  }

  Widget _buildLevelProgressBar(BuildContext context) {
    final nextLevel = int.parse(widget.userModel.level) + 1;
    final hasZeroXP = widget.userModel.points == 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLevelBadge(widget.userModel.level, false),
                  _buildLevelBadge(nextLevel.toString(), true),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  // Background track
                  Container(
                    height: 16,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: AppColors.avatarColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Progress indicator with glow
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          // Main progress bar
                          Container(
                            height: 16,
                            width:
                                constraints.maxWidth * _progressAnimation.value,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColors,
                                  AppColors.primaryColors.withOpacity(0.7),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Glow effect at the start (always visible)
                          if (hasZeroXP || _progressAnimation.value > 0)
                            Positioned(
                              left: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColors,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryColors
                                          .withOpacity(0.8),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          // Glow effect at the end of progress
                          if (_progressAnimation.value > 0)
                            Positioned(
                              left: constraints.maxWidth *
                                      _progressAnimation.value -
                                  8,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColors,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryColors
                                          .withOpacity(0.8),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${widget.userModel.points}/${widget.userModel.maxPoints} ${"xp".tr(context)}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.primaryColors.withOpacity(0.2),
          child: const Icon(
            Icons.person,
            size: 36,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${widget.userModel.firstName} ${widget.userModel.lastName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildLevelBadge(String level, bool isNextLevel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isNextLevel
            ? Colors.transparent
            : AppColors.primaryColors.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isNextLevel
              ? Colors.white.withOpacity(0.3)
              : AppColors.primaryColors,
          width: 1.5,
        ),
      ),
      child: Text(
        "${"level".tr(context)} $level",
        style: TextStyle(
          color: Colors.white,
          fontWeight: isNextLevel ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }
}
