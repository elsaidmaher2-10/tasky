import type { Task } from '../../types';
import { useAppStore } from '../store';
import { Checkbox } from './Controls';
import { PopupMenu } from './PopupMenu';

// ItemActionEnum.values names, shown as-is in the app's popup menu.
const MENU_ITEMS = [
  { id: 'edit', label: 'edit' },
  { id: 'delete', label: 'delete' },
  { id: 'markAsDone', label: 'markAsDone' },
];

/** TaskListWidget: one rounded row per task with checkbox, texts and an actions menu. */
export function TaskList({ tasks, emptyText }: { tasks: Task[]; emptyText?: string }) {
  const store = useAppStore();

  if (tasks.length === 0) {
    return emptyText ? <p className="empty-state">{emptyText}</p> : null;
  }

  return (
    <ul className="task-list">
      {tasks.map((task) => (
        <li key={task.id} className="task-item">
          <Checkbox
            checked={task.checked}
            label={`Mark "${task.name}" as ${task.checked ? 'not done' : 'done'}`}
            onChange={(value) => store.setChecked(task.id, value)}
          />
          <div className="task-texts">
            <span className={`task-name ${task.checked ? 'is-done' : ''}`}>{task.name}</span>
            {!task.checked && task.description !== '' && (
              <span className="task-description">{task.description}</span>
            )}
          </div>
          <PopupMenu
            label={`Actions for ${task.name}`}
            items={MENU_ITEMS}
            onSelect={(action) => {
              if (action === 'edit') store.openEdit(task.id);
              else if (action === 'delete') store.openDelete(task.id);
              else store.setChecked(task.id, !task.checked);
            }}
          />
        </li>
      ))}
    </ul>
  );
}
