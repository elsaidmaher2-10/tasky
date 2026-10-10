import { useEffect, useState } from 'react';

function formatTime(d: Date): string {
  return d.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false });
}

/** Live clock, ticking once per second boundary-ish (every 15s is plenty for hh:mm). */
export function useClock(): Date {
  const [now, setNow] = useState(() => new Date());
  useEffect(() => {
    const t = window.setInterval(() => setNow(new Date()), 15000);
    return () => window.clearInterval(t);
  }, []);
  return now;
}

/** iOS-style status bar drawn over the app. `tone` is the colour of the glyphs. */
export function StatusBar({ tone }: { tone: 'light' | 'dark' }) {
  const now = useClock();
  return (
    <div className={`status-bar tone-${tone}`} aria-hidden="true">
      <span className="status-time">{formatTime(now).replace(/^24:/, '00:')}</span>
      <span className="status-icons">
        <svg width="18" height="12" viewBox="0 0 18 12" fill="currentColor">
          <rect x="0" y="8" width="3" height="4" rx="0.8" />
          <rect x="5" y="5.5" width="3" height="6.5" rx="0.8" />
          <rect x="10" y="3" width="3" height="9" rx="0.8" />
          <rect x="15" y="0" width="3" height="12" rx="0.8" />
        </svg>
        <svg width="16" height="12" viewBox="0 0 16 12" fill="currentColor">
          <path d="M8 2.2c2.3 0 4.4.9 6 2.4l1-1.1A10.4 10.4 0 0 0 8 .7C5.2.7 2.7 1.8 1 3.5l1 1.1a8.8 8.8 0 0 1 6-2.4Zm0 3.4c1.4 0 2.700.5 3.700 1.400l1-1.100A7.200 7.200 0 0 0 8 4.100c-1.800 0-3.500.7-4.700 1.800l1 1.100c1-.9 2.300-1.400 3.700-1.400Zm0 3.300c.7 0 1.300.3 1.800.7L8 11.500 6.200 9.600c.5-.4 1.100-.7 1.800-.7Z" />
        </svg>
        <svg width="27" height="13" viewBox="0 0 27 13" fill="none">
          <rect x="0.5" y="0.5" width="22" height="12" rx="3.5" stroke="currentColor" opacity="0.4" />
          <rect x="2" y="2" width="19" height="9" rx="2.2" fill="currentColor" />
          <path d="M24 4.500v4c.8-.3 1.500-1.100 1.500-2s-.7-1.700-1.500-2Z" fill="currentColor" opacity="0.5" />
        </svg>
      </span>
    </div>
  );
}
