import 'package:flutter/material.dart';

/// Professional color tokens for UnitPro Studio
/// Deep navy + amber accent — clean, modern, engineering-grade
class AppColors {
  AppColors._();

  // Accent — refined amber (not neon, not dull)
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentDim = Color(0xFFB45309);
  static const Color accentSoft = Color(0xFFFEF3C7);

  // Dark theme — deep navy-charcoal
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVar = Color(0xFF334155);
  static const Color darkOnBg = Color(0xFFF1F5F9);
  static const Color darkOnSurface = Color(0xFF94A3B8);

  // Light theme — cool white
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVar = Color(0xFFE2E8F0);
  static const Color lightOnBg = Color(0xFF0F172A);
  static const Color lightOnSurface = Color(0xFF64748B);

  // AMOLED
  static const Color amoledBg = Color(0xFF000000);
  static const Color amoledSurface = Color(0xFF0C0C0C);
  static const Color amoledSurfaceVar = Color(0xFF1A1A1A);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
