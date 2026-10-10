import type { DemoFeature, DemoNotification, FrameId } from './types';

/**
 * The single place to edit for most changes: app identity, notifications and the
 * shortcut chips shown in the side panel.
 *
 * NOTE: the original Flutter app has no push or local notifications (no
 * firebase_messaging / flutter_local_notifications). The three notifications below
 * are realistic examples derived from its core flows (reminders, high priority
 * tasks, completed tasks). They are demo examples, not features of the real app.
 */
export const DEMO_CONFIG = {
  appName: 'Tasky',
  description: 'A task management app: add, track and complete your tasks.',
  accent: '#15B86C',
  lang: 'en',
  dir: 'ltr' as 'ltr' | 'rtl',
  defaultDark: true,
  defaultFrame: 'black' as FrameId,
  user: {
    name: 'Sarah Khalid',
    quote: 'One task at a time. One step closer.',
  },
  notifications: [
    {
      id: 'reminder',
      label: 'Daily reminder',
      title: 'Daily reminder',
      body: 'You have 4 tasks waiting for you. One task at a time. One step closer.',
      route: '/todo',
    },
    {
      id: 'high-priority',
      label: 'High priority task',
      title: 'High priority task',
      body: 'Finish UI design for login screen is marked as high priority.',
      route: '/high-priority',
    },
    {
      id: 'achievement',
      label: 'Achievement',
      title: 'Nice work! 🎉',
      body: 'You completed 2 tasks today. See everything you achieved.',
      route: '/completed',
    },
  ] satisfies DemoNotification[],
  features: [
    { id: 'welcome', label: 'Welcome screen', kind: 'route', route: '/welcome' },
    { id: 'home', label: 'Home', kind: 'route', route: '/home' },
    { id: 'todo', label: 'To Do', kind: 'route', route: '/todo' },
    { id: 'completed', label: 'Completed', kind: 'route', route: '/completed' },
    { id: 'profile', label: 'Profile', kind: 'route', route: '/profile' },
    { id: 'high-priority', label: 'High priority', kind: 'route', route: '/high-priority' },
    { id: 'add-task', label: 'New task', kind: 'route', route: '/add-task' },
    { id: 'user-details', label: 'User details', kind: 'route', route: '/user-details' },
    { id: 'edit', label: 'Edit task sheet', kind: 'action', action: 'open-edit' },
    { id: 'delete', label: 'Delete dialog', kind: 'action', action: 'open-delete' },
    { id: 'theme', label: 'Dark / light mode', kind: 'action', action: 'toggle-theme' },
    { id: 'reset', label: 'Reset demo', kind: 'action', action: 'reset' },
  ] satisfies DemoFeature[],
};
