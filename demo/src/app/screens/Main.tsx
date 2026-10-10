import { useDemo } from '../../bridge/DemoContext';
import type { RoutePath } from '../../types';
import { AppIcon, type AppIconName } from '../components/Icon';
import { HomeScreen } from './Home';
import { CompleteScreen, TodoScreen } from './TaskScreens';
import { ProfileScreen } from './Profile';

const TABS: { route: RoutePath; label: string; icon: AppIconName }[] = [
  { route: '/home', label: 'Home', icon: 'home' },
  { route: '/todo', label: 'To Do', icon: 'todo' },
  { route: '/completed', label: 'Completed', icon: 'complete' },
  { route: '/profile', label: 'Profile', icon: 'profile' },
];

/** MainScreen: the selected tab on top and the BottomNavigationBar below it. */
export function MainScreen({ route }: { route: RoutePath }) {
  const demo = useDemo();
  return (
    <div className="screen main safe-top">
      <main className="main-body">
        {route === '/home' && <HomeScreen />}
        {route === '/todo' && <TodoScreen />}
        {route === '/completed' && <CompleteScreen />}
        {route === '/profile' && <ProfileScreen />}
      </main>
      <nav className="bottom-nav safe-bottom" aria-label="Main">
        {TABS.map((tab) => {
          const selected = tab.route === route;
          return (
            <button
              key={tab.route}
              type="button"
              className={`bottom-nav-item ${selected ? 'is-selected' : ''}`}
              aria-current={selected ? 'page' : undefined}
              onClick={() => demo.navigate(tab.route)}
            >
              <span className="bottom-nav-icon">
                <AppIcon name={tab.icon} />
              </span>
              <span className="bottom-nav-label">{tab.label}</span>
            </button>
          );
        })}
      </nav>
    </div>
  );
}
