import { DEMO_CONFIG } from '../demo.config';
import type { PhoneNotification } from '../bridge/DemoContext';
import { AppBadge } from './NotificationBanner';
import { useClock } from './StatusBar';

interface Props {
  notifications: PhoneNotification[];
  onOpen: (uid: number) => void;
  onUnlock: () => void;
}

/** Lock screen: clock, pending notifications (tap one to unlock and open it) and a way to unlock. */
export function LockScreen({ notifications, onOpen, onUnlock }: Props) {
  const now = useClock();
  const time = now.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: false });
  const date = now.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
  return (
    <section className="lock" aria-label="Lock screen">
      <div className="lock-clock">
        <p className="lock-date">{date}</p>
        <p className="lock-time">{time.replace(/^24:/, '00:')}</p>
      </div>
      <ul className="lock-list" aria-label="Notifications">
        {notifications.length === 0 && (
          <li className="lock-empty">No notifications yet. Send one from the panel.</li>
        )}
        {notifications.map((n) => (
          <li key={n.uid}>
            <button type="button" className="lock-card" onClick={() => onOpen(n.uid)}>
              <AppBadge />
              <span className="banner-text">
                <span className="banner-head">
                  <span className="banner-title">{n.title}</span>
                  <span className="banner-time">now</span>
                </span>
                <span className="banner-body">{n.body}</span>
              </span>
              <span className="sr-only">{DEMO_CONFIG.appName}</span>
            </button>
          </li>
        ))}
      </ul>
      <button type="button" className="lock-unlock" onClick={onUnlock}>
        Unlock
      </button>
    </section>
  );
}
