import { useState } from 'react';
import { DEMO_CONFIG } from '../demo.config';
import { useDemo, type StackEntry } from '../bridge/DemoContext';
import { useAppStore } from './store';
import { OverlayProvider } from './components/Overlay';
import { AppOverlays } from './Overlays';
import { WelcomeScreen } from './screens/Welcome';
import { MainScreen } from './screens/Main';
import { HighPriorityScreen } from './screens/TaskScreens';
import { AddTaskScreen } from './screens/AddTask';
import { UserDetailsScreen } from './screens/Profile';

function renderRoute(entry: StackEntry) {
  switch (entry.route) {
    case '/welcome':
      return <WelcomeScreen />;
    case '/home':
    case '/todo':
    case '/completed':
    case '/profile':
      return <MainScreen route={entry.route} />;
    case '/high-priority':
      return <HighPriorityScreen />;
    case '/add-task':
      return <AddTaskScreen />;
    case '/user-details':
      return <UserDetailsScreen />;
  }
}

/** The rebuilt Tasky app. It fills the phone screen (390x844) and reads its theme from the store. */
export function AppRoot() {
  const demo = useDemo();
  const { state } = useAppStore();
  const [overlayEl, setOverlayEl] = useState<HTMLElement | null>(null);

  return (
    <OverlayProvider value={overlayEl}>
      <div className="tasky" data-theme={state.dark ? 'dark' : 'light'} lang={DEMO_CONFIG.lang} dir={DEMO_CONFIG.dir}>
        {demo.stack.map((entry, index) => (
          <div
            key={entry.id}
            className={`route ${entry.pushed ? 'is-pushed' : ''} ${entry.leaving ? 'is-leaving' : ''}`}
            inert={index < demo.stack.length - 1 || entry.leaving}
          >
            {renderRoute(entry)}
          </div>
        ))}
        <div ref={setOverlayEl} className="overlay-root" />
        <AppOverlays />
      </div>
    </OverlayProvider>
  );
}
