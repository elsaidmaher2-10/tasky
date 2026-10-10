import { DEMO_CONFIG } from '../demo.config';
import type { PhoneNotification } from '../bridge/DemoContext';

export function AppBadge() {
  return (
    <span className="app-badge" aria-hidden="true">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
        <path d="m5 12.500 4.500 4.500L19 7.500" />
      </svg>
    </span>
  );
}

/**
 * iOS-style banner that drops from the top of the screen, under the Dynamic Island.
 * The wrapper is a live region so assistive tech announces it; the button opens the
 * screen the notification points at.
 */
export function NotificationBanner({
  notification,
  onOpen,
}: {
  notification: PhoneNotification | null;
  onOpen: (uid: number) => void;
}) {
  return (
    <div className="banner-region" role="status" aria-live="polite">
      {notification && (
        <button
          key={notification.uid}
          type="button"
          className="banner"
          onClick={() => onOpen(notification.uid)}
          aria-label={`${notification.title}. ${notification.body}. Tap to open.`}
        >
          <AppBadge />
          <span className="banner-text">
            <span className="banner-head">
              <span className="banner-title">{notification.title}</span>
              <span className="banner-time">now</span>
            </span>
            <span className="banner-body">{notification.body}</span>
          </span>
          <span className="sr-only">{DEMO_CONFIG.appName}</span>
        </button>
      )}
    </div>
  );
}
