# Project & SLA Task Tracker

A Flutter mobile app (Group 11) that lets a small software team create, assign
and track project tasks. Each task automatically gets an SLA status based on its
deadline and progress.

## Features
- Choose a team member profile (no real authentication)
- Dashboard with project progress, task counts per SLA status, and "my open tasks"
- Task list with search and SLA filter
- Create, edit, assign and delete tasks (title, description, assignee, priority, deadline, progress)
- Form validation with clear error messages
- Local storage with SQLite, so data persists after the app is closed
- Loading, empty and error states

## SLA rule
Status is computed from the deadline and progress every time it is shown.
It is never stored, so it cannot go out of date.

1. Progress is 100%: **Completed**
2. Deadline day is before today: **Overdue**
3. Deadline is today or within 2 days: **At Risk**
4. Otherwise: **On Track**

Days are counted as whole calendar days, because the date picker only gives a
date. A task due today is At Risk, and only becomes Overdue the next day.
The 2-day window is `SlaHelper.atRiskDays` in `lib/utils/sla_helper.dart`.
All screens use this one helper.

## Technology choices
- **Flutter** (Material 3), with `setState()` for UI state
- **SQLite (`sqflite`)** for persistence. Tasks are structured records that
  need insert, read, update and delete operations, so SQLite fits better than
  SharedPreferences
- **Named routes** with `Navigator.pushNamed` for navigation

## Project structure
    lib/
      main.dart              app entry point and routes
      models/                Task, TeamMember
      screens/               the 6 screens
      services/              database_service.dart (SQLite)
      widgets/               reusable UI components
      utils/                 sla_helper, task_stats, validators, demo data
      theme/                 colours, spacing, theme
    test/                    unit tests for SLA, stats and Task model

## Run the app
Requires the Flutter SDK and an Android emulator or a physical Android/iOS device.

    flutter pub get
    flutter run

Run the tests with `flutter test`. The app uses SQLite, so run it on an
emulator or device, not in a browser. The first launch is seeded with demo
tasks covering all four SLA states.

## Team
| Member | Area |
|---|---|
| Ladouce | UI, screens, theme and navigation |
| Kevin | Task list, details, form and validation |
| Manuelle | Data models, SQLite, SLA logic, statistics and integration |

## Screenshots
Screenshots go here.