import { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { useAppStore } from '../store';
import { AppBar } from '../components/AppBar';
import { PrimaryButton, Switch, TextField } from '../components/Controls';

/** Fields shared by the "New Task" screen and the edit bottom sheet. */
export function TaskForm({
  name,
  description,
  high,
  onName,
  onDescription,
  onHigh,
  nameError,
}: {
  name: string;
  description: string;
  high: boolean;
  onName: (v: string) => void;
  onDescription: (v: string) => void;
  onHigh: (v: boolean) => void;
  nameError: string | null;
}) {
  return (
    <>
      <TextField
        label="Task Name"
        labelClass="field-label t-title-medium"
        value={name}
        onChange={onName}
        hint="Finish UI design for login screen"
        error={nameError}
      />
      <div className="gap-h16" />
      <TextField
        label="Task Description"
        labelClass="field-label t-title-medium"
        value={description}
        onChange={onDescription}
        hint="Finish onboarding UI and hand off to devs by Thursday."
        multiline
      />
      <div className="gap-24" />
      <div className="switch-row">
        <span className="t-headline-medium" id="high-priority-label">
          High Priority&nbsp;&nbsp;
        </span>
        <Switch checked={high} onChange={onHigh} label="High Priority" />
      </div>
    </>
  );
}

/** AddTask: pushed from the Home floating action button. */
export function AddTaskScreen() {
  const demo = useDemo();
  const store = useAppStore();
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  // Addtaskcontroller starts with ishighPreiorty = true.
  const [high, setHigh] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const submit = () => {
    if (name === '') {
      setError('Please Enetr TaskName');
      return;
    }
    store.addTask(name, description, high);
    demo.back();
  };

  return (
    <div className="screen pushed-page safe-top">
      <AppBar title="New Task" back />
      <form
        className="form-page"
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
          Add Task
        </PrimaryButton>
        <div className="gap-32" />
      </form>
    </div>
  );
}
