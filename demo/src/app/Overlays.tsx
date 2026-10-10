import { useState } from 'react';
import { useAppStore } from './store';
import { PrimaryButton } from './components/Controls';
import { BottomSheet, Dialog } from './components/Surfaces';
import { TaskForm } from './screens/AddTask';
import { AvatarDialog } from './screens/Profile';
import type { Task } from '../types';

/** showmodalbottomsheet from TaskListWidget: edit a task. */
function EditSheet({ task }: { task: Task }) {
  const store = useAppStore();
  const [name, setName] = useState(task.name);
  const [description, setDescription] = useState(task.description);
  const [high, setHigh] = useState(task.high);
  const [error, setError] = useState<string | null>(null);
  const close = () => store.openEdit(null);

  const submit = () => {
    if (name === '') {
      setError('Please Enetr TaskName');
      return;
    }
    store.editTask(task.id, name, description, high);
  };

  return (
    <BottomSheet label="Edit task" onClose={close}>
      <form
        className="sheet-form"
        noValidate
        onSubmit={(e) => {
          e.preventDefault();
          submit();
        }}
      >
        <div className="form-scroll">
          <TaskForm
            name={name}
            description={description}
            high={high}
            onName={(v) => {
              setName(v);
              if (error) setError(null);
            }}
            onDescription={setDescription}
            onHigh={setHigh}
            nameError={error}
          />
        </div>
        <PrimaryButton icon="add" onClick={submit}>
          Edit Task
        </PrimaryButton>
        <div className="gap-h32" />
      </form>
    </BottomSheet>
  );
}

/** The "Delete Task" AlertDialog. */
function DeleteDialog({ task }: { task: Task }) {
  const store = useAppStore();
  const close = () => store.openDelete(null);
  return (
    <Dialog
      title="Delete Task"
      onClose={close}
      actions={
        <>
          <button type="button" className="text-button" onClick={close}>
            Cancel
          </button>
          <button type="button" className="text-button is-danger" onClick={() => store.deleteTask(task.id)}>
            Delete
          </button>
        </>
      }
    >
      Are You Sure To Delete Task
    </Dialog>
  );
}

/** Every modal surface of the app, driven by the store so shortcuts can open them too. */
export function AppOverlays() {
  const { state } = useAppStore();
  const editing = state.editingId === null ? undefined : state.tasks.find((t) => t.id === state.editingId);
  const deleting = state.deletingId === null ? undefined : state.tasks.find((t) => t.id === state.deletingId);
  return (
    <>
      {editing && <EditSheet key={editing.id} task={editing} />}
      {deleting && <DeleteDialog key={deleting.id} task={deleting} />}
      {state.avatarDialogOpen && <AvatarDialog />}
    </>
  );
}
