import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
  type ReactNode,
} from 'react';
import { useAppStore } from '../app/store';
import type { DemoAction, RoutePath } from '../types';

export const TAB_ROUTES: readonly RoutePath[] = ['/home', '/todo', '/completed', '/profile'];
const PUSHED_ROUTES: readonly RoutePath[] = ['/high-priority', '/add-task', '/user-details'];
const KNOWN_ROUTES: readonly string[] = ['/welcome', ...TAB_ROUTES, ...PUSHED_ROUTES];

const LEAVE_MS = 220;
const BANNER_MS = 5500;

export interface StackEntry {
  id: number;
  route: RoutePath;
  /** true for screens pushed on top of the base screen (they slide in). */
  pushed: boolean;
  leaving: boolean;
}

export interface PhoneNotification {
  uid: number;
  title: string;
  body: string;
  route: RoutePath;
}

interface DemoContextValue {
  stack: StackEntry[];
  currentRoute: RoutePath;
  navigate: (route: string) => void;
  back: () => void;
  notify: (n: { title: string; body: string; route: RoutePath }) => void;
  pending: PhoneNotification[];
  banner: PhoneNotification | null;
  dismissBanner: () => void;
  openNotification: (uid: number) => void;
  locked: boolean;
  lock: () => void;
  unlock: () => void;
  runAction: (name: DemoAction) => void;
  /** Small message shown inside the phone, e.g. "route not available in demo". */
  hint: string | null;
}

const DemoContext = createContext<DemoContextValue | null>(null);

function isTab(route: RoutePath): boolean {
  return TAB_ROUTES.includes(route);
}

export function DemoProvider({ children }: { children: ReactNode }) {
  const store = useAppStore();
  const nextId = useRef(2);
  const [stack, setStack] = useState<StackEntry[]>([
    { id: 1, route: '/home', pushed: false, leaving: false },
  ]);
  const stackRef = useRef(stack);
  stackRef.current = stack;
  const [pending, setPending] = useState<PhoneNotification[]>([]);
  const [banner, setBanner] = useState<PhoneNotification | null>(null);
  const [locked, setLocked] = useState(false);
  const [hint, setHint] = useState<string | null>(null);
  const hintTimer = useRef<number | undefined>(undefined);
  const notifUid = useRef(1);

  const showHint = useCallback((text: string) => {
    setHint(text);
    window.clearTimeout(hintTimer.current);
    hintTimer.current = window.setTimeout(() => setHint(null), 2600);
  }, []);

  const navigate = useCallback(
    (target: string) => {
      if (!KNOWN_ROUTES.includes(target)) {
        showHint('This route is not available in the demo');
        return;
      }
      const route = target as RoutePath;
      setStack((prev) => {
        const base = prev[0];
        if (route === '/welcome') {
          return [{ id: nextId.current++, route, pushed: false, leaving: false }];
        }
        if (isTab(route)) {
          // Switching tabs keeps the same base entry so the main screen is not remounted.
          if (prev.length === 1 && isTab(base.route)) {
            return [{ ...base, route }];
          }
          return [{ id: nextId.current++, route, pushed: false, leaving: false }];
        }
        // Pushed screen: make sure a main screen sits underneath.
        const baseStack: StackEntry[] = isTab(base.route)
          ? prev.filter((e) => !e.leaving)
          : [{ id: nextId.current++, route: '/home', pushed: false, leaving: false }];
        if (baseStack[baseStack.length - 1].route === route) return baseStack;
        return [...baseStack, { id: nextId.current++, route, pushed: true, leaving: false }];
      });
    },
    [showHint],
  );

  const back = useCallback(() => {
    const current = stackRef.current;
    if (current.length < 2) return;
    const top = current[current.length - 1];
    if (top.leaving) return;
    setStack((prev) => prev.map((e) => (e.id === top.id ? { ...e, leaving: true } : e)));
    window.setTimeout(() => {
      setStack((cur) => cur.filter((e) => e.id !== top.id));
    }, LEAVE_MS);
  }, []);

  const dismissBanner = useCallback(() => setBanner(null), []);

  // A ref mirrors `locked` so notify() sees a lock() made in the same tick
  // (e.g. "lock the phone, then send a notification" from the panel).
  const lockedRef = useRef(false);

  const lock = useCallback(() => {
    lockedRef.current = true;
    setBanner(null);
    setLocked(true);
  }, []);
  const unlock = useCallback(() => {
    lockedRef.current = false;
    setLocked(false);
  }, []);

  const notify = useCallback((n: { title: string; body: string; route: RoutePath }) => {
    const item: PhoneNotification = { uid: notifUid.current++, ...n };
    setPending((prev) => [item, ...prev]);
    if (!lockedRef.current) setBanner(item);
  }, []);

  const openNotification = useCallback(
    (uid: number) => {
      const target = pending.find((n) => n.uid === uid) ?? (banner?.uid === uid ? banner : null);
      setPending((prev) => prev.filter((n) => n.uid !== uid));
      setBanner(null);
      lockedRef.current = false;
      setLocked(false);
      if (target) navigate(target.route);
    },
    [pending, banner, navigate],
  );

  useEffect(() => {
    if (!banner) return undefined;
    const t = window.setTimeout(() => setBanner(null), BANNER_MS);
    return () => window.clearTimeout(t);
  }, [banner]);

  useEffect(() => () => window.clearTimeout(hintTimer.current), []);

  const runAction = useCallback(
    (name: DemoAction) => {
      switch (name) {
        case 'toggle-theme':
          store.setDark(!store.state.dark);
          return;
        case 'reset':
          store.reset();
          setPending([]);
          setBanner(null);
          lockedRef.current = false;
          setLocked(false);
          setStack([{ id: nextId.current++, route: '/home', pushed: false, leaving: false }]);
          return;
        case 'open-edit':
        case 'open-delete': {
          const task = store.state.tasks.find((t) => !t.checked) ?? store.state.tasks[0];
          if (!task) {
            showHint('Add a task first');
            return;
          }
          navigate('/home');
          // Only one overlay at a time, like the real app.
          store.openEdit(name === 'open-edit' ? task.id : null);
          store.openDelete(name === 'open-delete' ? task.id : null);
          return;
        }
      }
    },
    [store, navigate, showHint],
  );

  const value = useMemo<DemoContextValue>(
    () => ({
      stack,
      currentRoute: stack[stack.length - 1].route,
      navigate,
      back,
      notify,
      pending,
      banner,
      dismissBanner,
      openNotification,
      locked,
      lock,
      unlock,
      runAction,
      hint,
    }),
    [stack, navigate, back, notify, pending, banner, dismissBanner, openNotification, locked, lock, unlock, runAction, hint],
  );

  return <DemoContext.Provider value={value}>{children}</DemoContext.Provider>;
}

export function useDemo(): DemoContextValue {
  const ctx = useContext(DemoContext);
  if (!ctx) throw new Error('useDemo must be used inside <DemoProvider>');
  return ctx;
}
