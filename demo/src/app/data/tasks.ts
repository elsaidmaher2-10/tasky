import type { Task } from '../../types';

/**
 * Sample data, shaped like the app's TaskModel (taskname, taskdescription,
 * isHighPeriorty, ischecked, id). The first two descriptions are the app's own hint
 * texts. A task with an empty description is included on purpose: the app hides the
 * description line when it is empty.
 */
export const INITIAL_TASKS: Task[] = [
  {
    id: 0,
    name: 'Finish UI design for login screen',
    description: 'Finish onboarding UI and hand off to devs by Thursday.',
    high: true,
    checked: false,
  },
  {
    id: 1,
    name: 'Review pull requests',
    description: 'Check the open PRs for the checkout flow.',
    high: true,
    checked: false,
  },
  {
    id: 2,
    name: 'Prepare weekly report',
    description: 'Summarize progress and blockers for the team.',
    high: false,
    checked: false,
  },
  {
    id: 3,
    name: 'Book dentist appointment',
    description: '',
    high: false,
    checked: false,
  },
  {
    id: 4,
    name: 'Reply to client emails',
    description: 'Send the updated mockups to Ahmed.',
    high: true,
    checked: true,
  },
  {
    id: 5,
    name: 'Grocery shopping',
    description: 'Milk, eggs, coffee and fruit.',
    high: false,
    checked: true,
  },
];
