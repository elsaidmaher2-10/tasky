import {
  createContext,
  useCallback,
  useContext,
  useMemo,
  useReducer,
  type ReactNode,
} from 'react';
import { DEMO_CONFIG } from '../demo.config';
import type { Task } from '../types';
import { INITIAL_TASKS } from './data/tasks';

export interface AppState {
  tasks: Task[];
  nextId: number;
  /** null = logged out, the welcome screen asks for a name. */
  userName: string | null;
  quote: string;
  /** Data URI of a profile picture picked in the (simulated) image dialog. */
  avatar: string | null;
  dark: boolean;
  editingId: number | null;
  deletingId: number | null;
  avatarDialogOpen: boolean;
}

type Action =
  | { type: 'setChecked'; id: number; value: boolean }
  | { type: 'delete'; id: number }
  | { type: 'add'; name: string; description: string; high: boolean }
  | { type: 'edit'; id: number; name: string; description: string; high: boolean }
  | { type: 'setUser'; name: string | null; quote?: string }
  | { type: 'setAvatar'; avatar: string | null }
  | { type: 'setDark'; dark: boolean }
  | { type: 'openEdit'; id: number | null }
  | { type: 'openDelete'; id: number | null }
  | { type: 'avatarDialog'; open: boolean }
  | { type: 'reset' };

function initialState(): AppState {
  return {
    tasks: INITIAL_TASKS.map((t) => ({ ...t })),
    nextId: INITIAL_TASKS.length,
    userName: DEMO_CONFIG.user.name,
    quote: DEMO_CONFIG.user.quote,
    avatar: null,
    dark: DEMO_CONFIG.defaultDark,
    editingId: null,
    deletingId: null,
    avatarDialogOpen: false,
  };
}

function reducer(state: AppState, action: Action): AppState {
  switch (action.type) {
    case 'setChecked':
      return {
        ...state,
        tasks: state.tasks.map((t) => (t.id === action.id ? { ...t, checked: action.value } : t)),
      };
    case 'delete':
      return {
        ...state,
        tasks: state.tasks.filter((t) => t.id !== action.id),
        deletingId: null,
      };
    case 'add':
      return {
        ...state,
        tasks: [
          ...state.tasks,
          {
            id: state.nextId,
            name: action.name,
            description: action.description,
            high: action.high,
            checked: false,
          },
        ],
        nextId: state.nextId + 1,
      };
    case 'edit':
      return {
        ...state,
        editingId: null,
        tasks: state.tasks.map((t) =>
          t.id === action.id
            ? { ...t, name: action.name, description: action.description, high: action.high }
            : t,
        ),
      };
    case 'setUser':
      return {
        ...state,
        userName: action.name,
        quote: action.quote ?? (action.name === null ? DEMO_CONFIG.user.quote : state.quote),
      };
    case 'setAvatar':
      return { ...state, avatar: action.avatar };
    case 'setDark':
      return { ...state, dark: action.dark };
    case 'openEdit':
      return { ...state, editingId: action.id };
    case 'openDelete':
      return { ...state, deletingId: action.id };
    case 'avatarDialog':
      return { ...state, avatarDialogOpen: action.open };
    case 'reset':
      return initialState();
  }
}

export interface AppStore {
  state: AppState;
  setChecked: (id: number, value: boolean) => void;
  deleteTask: (id: number) => void;
  addTask: (name: string, description: string, high: boolean) => void;
  editTask: (id: number, name: string, description: string, high: boolean) => void;
  setUser: (name: string | null, quote?: string) => void;
  setAvatar: (avatar: string | null) => void;
  setDark: (dark: boolean) => void;
  openEdit: (id: number | null) => void;
  openDelete: (id: number | null) => void;
  setAvatarDialog: (open: boolean) => void;
  reset: () => void;
}

const AppStoreContext = createContext<AppStore | null>(null);

export function AppStoreProvider({ children }: { children: ReactNode }) {
  const [state, dispatch] = useReducer(reducer, undefined, initialState);

  const setChecked = useCallback((id: number, value: boolean) => dispatch({ type: 'setChecked', id, value }), []);
  const deleteTask = useCallback((id: number) => dispatch({ type: 'delete', id }), []);
  const addTask = useCallback(
    (name: string, description: string, high: boolean) => dispatch({ type: 'add', name, description, high }),
    [],
  );
  const editTask = useCallback(
    (id: number, name: string, description: string, high: boolean) =>
      dispatch({ type: 'edit', id, name, description, high }),
    [],
  );
  const setUser = useCallback((name: string | null, quote?: string) => dispatch({ type: 'setUser', name, quote }), []);
  const setAvatar = useCallback((avatar: string | null) => dispatch({ type: 'setAvatar', avatar }), []);
  const setDark = useCallback((dark: boolean) => dispatch({ type: 'setDark', dark }), []);
  const openEdit = useCallback((id: number | null) => dispatch({ type: 'openEdit', id }), []);
  const openDelete = useCallback((id: number | null) => dispatch({ type: 'openDelete', id }), []);
  const setAvatarDialog = useCallback((open: boolean) => dispatch({ type: 'avatarDialog', open }), []);
  const reset = useCallback(() => dispatch({ type: 'reset' }), []);

  const value = useMemo<AppStore>(
    () => ({
      state,
      setChecked,
      deleteTask,
      addTask,
      editTask,
      setUser,
      setAvatar,
      setDark,
      openEdit,
      openDelete,
      setAvatarDialog,
      reset,
    }),
    [state, setChecked, deleteTask, addTask, editTask, setUser, setAvatar, setDark, openEdit, openDelete, setAvatarDialog, reset],
  );

  return <AppStoreContext.Provider value={value}>{children}</AppStoreContext.Provider>;
}

export function useAppStore(): AppStore {
  const ctx = useContext(AppStoreContext);
  if (!ctx) throw new Error('useAppStore must be used inside <AppStoreProvider>');
  return ctx;
}
