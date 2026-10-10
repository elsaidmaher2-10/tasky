import { DEMO_CONFIG } from '../demo.config';
import type { FrameId } from '../types';
import { useDemo } from '../bridge/DemoContext';
import { useAppStore } from '../app/store';

export const FRAMES: { id: FrameId; label: string; color: string }[] = [
  { id: 'black', label: 'Black', color: '#1d1d1f' },
  { id: 'natural', label: 'Natural titanium', color: '#b7b1a6' },
  { id: 'white', label: 'White', color: '#ececee' },
  { id: 'blue', label: 'Blue', color: '#3b5a7a' },
];

interface Props {
  frame: FrameId;
  onFrame: (id: FrameId) => void;
  zoom: number;
  onZoom: (value: number) => void;
}

/** Side panel: everything a viewer can try that a real phone would receive or trigger. */
export function ControlPanel({ frame, onFrame, zoom, onZoom }: Props) {
  const demo = useDemo();
  const { state } = useAppStore();

  const sendAll = () => {
    DEMO_CONFIG.notifications.forEach((n, i) => {
      window.setTimeout(() => demo.notify({ title: n.title, body: n.body, route: n.route }), i * 650);
    });
  };

  const lockAndSend = () => {
    demo.lock();
    const n = DEMO_CONFIG.notifications[0];
    window.setTimeout(() => demo.notify({ title: n.title, body: n.body, route: n.route }), 700);
  };

  return (
    <aside className="panel" aria-label="Demo controls">
      <header className="panel-head">
        <h1>{DEMO_CONFIG.appName}</h1>
        <p>{DEMO_CONFIG.description}</p>
        <p className="panel-note">
          Interactive demo, rebuilt in React from the Flutter app. Sample data only; it may differ from the
          real app in small details.
        </p>
      </header>

      <section className="panel-section" aria-labelledby="p-notif">
        <h2 id="p-notif">Try a notification</h2>
        <p className="panel-help">Tap the banner on the phone to open its screen.</p>
        <div className="btn-stack">
          {DEMO_CONFIG.notifications.map((n) => (
            <button
              key={n.id}
              type="button"
              className="panel-btn"
              onClick={() => demo.notify({ title: n.title, body: n.body, route: n.route })}
            >
              <span className="panel-btn-icon" aria-hidden="true">🔔</span>
              {n.label}
            </button>
          ))}
          <button type="button" className="panel-btn is-ghost" onClick={sendAll}>
            Send all three
          </button>
        </div>
      </section>

      <section className="panel-section" aria-labelledby="p-lock">
        <h2 id="p-lock">Lock screen</h2>
        <div className="btn-row">
          <button type="button" className="panel-btn" onClick={demo.locked ? demo.unlock : demo.lock}>
            {demo.locked ? 'Unlock phone' : 'Lock phone'}
          </button>
          <button type="button" className="panel-btn is-ghost" onClick={lockAndSend}>
            Lock and send reminder
          </button>
        </div>
      </section>

      <section className="panel-section" aria-labelledby="p-feat">
        <h2 id="p-feat">Jump to</h2>
        <div className="chips">
          {DEMO_CONFIG.features.map((f) => {
            const active = f.kind === 'route' && demo.currentRoute === f.route;
            const label =
              f.kind === 'action' && f.action === 'toggle-theme'
                ? state.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode'
                : f.label;
            return (
              <button
                key={f.id}
                type="button"
                className="chip"
                aria-pressed={f.kind === 'route' ? active : undefined}
                onClick={() => (f.kind === 'route' ? demo.navigate(f.route) : demo.runAction(f.action))}
              >
                {label}
              </button>
            );
          })}
        </div>
      </section>

      <section className="panel-section" aria-labelledby="p-view">
        <h2 id="p-view">View</h2>
        <div className="swatches" role="radiogroup" aria-label="Frame colour">
          {FRAMES.map((f) => (
            <button
              key={f.id}
              type="button"
              role="radio"
              aria-checked={frame === f.id}
              aria-label={f.label}
              title={f.label}
              className="swatch"
              style={{ background: f.color }}
              onClick={() => onFrame(f.id)}
            />
          ))}
        </div>
        <label className="zoom">
          <span>Zoom {Math.round(zoom * 100)}%</span>
          <input
            type="range"
            min={0.6}
            max={1.2}
            step={0.05}
            value={zoom}
            onChange={(e) => onZoom(Number(e.target.value))}
          />
        </label>
      </section>
    </aside>
  );
}
