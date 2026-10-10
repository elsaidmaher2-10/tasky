import { useDemo } from '../../bridge/DemoContext';
import { useAppStore } from '../store';
import { Checkbox } from '../components/Controls';
import { AppIcon, MaterialIcon } from '../components/Icon';
import { TaskList } from '../components/TaskList';
import avatarDefault from '../assets/image.png';
import wave from '../assets/waving_hand.png';

/** archived_task: "Achieved Tasks" card with the circular progress indicator. */
function AchievedCard({ done, total }: { done: number; total: number }) {
  const ratio = total === 0 ? 0 : done / total;
  const percent = total === 0 ? 0 : ratio * 100;
  const radius = 20;
  const circumference = 2 * Math.PI * radius;
  return (
    <div className="achieved-card">
      <div>
        <div className="t-title-medium">Achieved Tasks</div>
        <div className="t-title-small">
          {done} out of {total} Done
        </div>
      </div>
      <div className="progress" role="img" aria-label={`${percent.toFixed(1)} percent of tasks done`}>
        {/* The app rotates the indicator by -90deg on top of Flutter's own top start. */}
        <svg viewBox="0 0 48 48" className="progress-svg" aria-hidden="true">
          <circle cx="24" cy="24" r={radius} className="progress-track" />
          <circle
            cx="24"
            cy="24"
            r={radius}
            className="progress-value"
            strokeDasharray={`${circumference * ratio} ${circumference}`}
          />
        </svg>
        <span className="progress-label t-title-medium">{percent.toFixed(1)}%</span>
      </div>
    </div>
  );
}

/** Highprepiortywidget: up to four high priority tasks and a button to see them all. */
function HighPriorityCard() {
  const demo = useDemo();
  const store = useAppStore();
  const high = store.state.tasks.filter((t) => t.high).slice(0, 4);
  return (
    <section className="priority-card" aria-labelledby="high-priority-title">
      <h2 id="high-priority-title" className="priority-title">
        High Priority Tasks
      </h2>
      <div className="priority-row">
        <ul className="priority-list">
          {high.map((task) => (
            <li key={task.id} className="priority-item">
              <Checkbox
                checked={task.checked}
                label={`Mark "${task.name}" as ${task.checked ? 'not done' : 'done'}`}
                onChange={(value) => store.setChecked(task.id, value)}
              />
              <span className={task.checked ? 't-headline-small' : 't-headline-medium'}>{task.name}</span>
            </li>
          ))}
        </ul>
        <button
          type="button"
          className="round-arrow"
          aria-label="See all high priority tasks"
          onClick={() => demo.navigate('/high-priority')}
        >
          <AppIcon name="arrowLeft" />
        </button>
      </div>
    </section>
  );
}

/** HomeScreen: greeting, progress, high priority tasks and the full task list. */
export function HomeScreen() {
  const demo = useDemo();
  const store = useAppStore();
  const { tasks, userName, quote, avatar } = store.state;
  const done = tasks.filter((t) => t.checked).length;

  return (
    <div className="home">
      <div className="home-scroll">
        <div className="home-header">
          <div className="avatar avatar-small">
            <img src={avatar ?? avatarDefault} alt="" />
          </div>
          <div>
            <div className="t-title-medium">Good Evening, {userName ?? 'Guest'}</div>
            <div className="t-title-small">{quote}</div>
          </div>
        </div>

        <h1 className="t-display-large home-heading">Yuhuu, Your work is&nbsp;</h1>
        <div className="home-heading-row">
          <span className="t-display-large">almost done!&nbsp;</span>
          <img src={wave} width={28} height={28} alt="" />
        </div>

        <AchievedCard done={done} total={tasks.length} />
        <div className="gap-h8" />
        <HighPriorityCard />
        <h2 className="t-title-medium home-my-tasks">My Tasks</h2>
        <div className="home-tasks">
          <TaskList tasks={tasks} />
        </div>
      </div>

      <button type="button" className="fab" onClick={() => demo.navigate('/add-task')}>
        <MaterialIcon name="add" />
        <span>Add New Task</span>
      </button>
    </div>
  );
}
