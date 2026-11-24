# LOGAI-001 – AI Code Generation Record

**AI Tool:** Claude

**Task:** TMA3084 Lab 05 – Lesson 07, Part 4: Vibe Coding Task 5

**Date:** 24 November 2026

**File:** `lab_a/lib/main.dart`

## Exact Prompt

Refactor the BottomNavigationBar app in lib/main.dart.
Move the selected tab index out of the widget state
into a Provider ChangeNotifier named TabModel.
Read the index with context.watch and update it
with context.read inside onTap.
Keep the UI and the four tab labels exactly the same.
Add no package other than provider.
Return the result as a diff.

## Purpose

To refactor the BottomNavigationBar application by moving its selected tab index into a Provider ChangeNotifier named TabModel, while preserving the existing UI and navigation functionality.

## AI Output

Claude generated a unified diff showing the proposed changes to `lib/main.dart`. The generated diff was reviewed before implementation.