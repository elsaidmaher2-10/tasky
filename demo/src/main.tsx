import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { DEMO_CONFIG } from './demo.config';
import { AppStoreProvider } from './app/store';
import { DemoProvider } from './bridge/DemoContext';
import { DemoShell } from './shell/DemoShell';
import './styles/theme.css';
import './shell/shell.css';

document.documentElement.lang = 'en';
document.title = `${DEMO_CONFIG.appName} - Interactive Demo`;

const rootEl = document.getElementById('root');
if (!rootEl) throw new Error('Missing #root element');

createRoot(rootEl).render(
  <StrictMode>
    <AppStoreProvider>
      <DemoProvider>
        <DemoShell />
      </DemoProvider>
    </AppStoreProvider>
  </StrictMode>,
);
