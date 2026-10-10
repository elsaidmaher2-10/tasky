import { useAppStore } from '../store';
import { AppBar } from '../components/AppBar';
import { TaskList } from '../components/TaskList';

/** TodoScreen: tasks that are not done yet. */
export function TodoScreen() {
  const { state } = useAppStore();
  return (
    <div className="tab-page">
      <AppBar title="To Do tasks" />
      <div className="tab-page-body">
        <TaskList tasks={state.tasks.filter((t) => !t.checked)} emptyText="Nothing left to do." />
      </div>
    </div>
  );
}

/** CompleteScreen: tasks that are done. */
export function CompleteScreen() {
  const { state } = useAppStore();
  return (
    <div className="tab-page">
      <AppBar title="Complete tasks" />
      <div className="tab-page-body">
        <TaskList tasks={state.tasks.filter((t) => t.checked)} emptyText="No completed tasks yet." />
      </div>
    </div>
  );
}

/** HighperiortyScreen: every high priority task, done or not. Pushed from the Home card. */
export function HighPriorityScreen() {
  const { state } = useAppStore();
  return (
    <div className="screen pushed-page safe-top">
      <AppBar title="High Priority Tasks" back />
      <div className="tab-page-body">
        <TaskList tasks={state.tasks.filter((t) => t.high)} emptyText="No high priority tasks." />
      </div>
    </div>
  );
}
