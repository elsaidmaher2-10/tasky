export type RoutePath =
  | '/welcome'
  | '/home'
  | '/todo'
  | '/completed'
  | '/profile'
  | '/high-priority'
  | '/add-task'
  | '/user-details';

export type DemoAction = 'toggle-theme' | 'open-edit' | 'open-delete' | 'reset';

export interface DemoNotification {
  id: string;
  /** Short label for the panel button. */
  label: string;
  title: string;
  body: string;
  /** Screen opened when the notification is tapped. */
  route: RoutePath;
}

export type DemoFeature =
  | { id: string; label: string; kind: 'route'; route: RoutePath }
  | { id: string; label: string; kind: 'action'; action: DemoAction };

export type FrameId = 'black' | 'natural' | 'white' | 'blue';

export interface Task {
  id: number;
  name: string;
  description: string;
  high: boolean;
  checked: boolean;
}
