import type { CSSProperties, ReactNode } from 'react';
import type { FrameId } from '../types';
import { useDemo } from '../bridge/DemoContext';
import { useAppStore } from '../app/store';
import { StatusBar } from './StatusBar';
import { NotificationBanner } from './NotificationBanner';
import { LockScreen } from './LockScreen';

export const PHONE_W = 390;
export const PHONE_H = 844;
/** Bezel thickness around the screen. */
export const BEZEL = 12;

const SCREEN_VARS = {
  '--safe-top': '54px',
  '--safe-bottom': '34px',
} as CSSProperties;

/**
 * The iPhone: bezel, Dynamic Island, side buttons, status bar, home indicator, and the
 * layers that live above the app (banner, hint toast, lock screen). The app itself is
 * passed as children and fills the 390x844 screen.
 */
export function PhoneFrame({ frame, children }: { frame: FrameId; children: ReactNode }) {
  const demo = useDemo();
  const { state } = useAppStore();
  const onLightApp = !state.dark && !demo.locked;

  return (
    <div className={`phone frame-${frame}`} style={{ width: PHONE_W + BEZEL * 2, height: PHONE_H + BEZEL * 2 }}>
      <span className="phone-btn btn-action" aria-hidden="true" />
      <span className="phone-btn btn-vol-up" aria-hidden="true" />
      <span className="phone-btn btn-vol-down" aria-hidden="true" />
      <span className="phone-btn btn-power" aria-hidden="true" />
      <div className="phone-screen" style={{ width: PHONE_W, height: PHONE_H, ...SCREEN_VARS }}>
        {children}
        <StatusBar tone={onLightApp ? 'dark' : 'light'} />
        <div className="island" aria-hidden="true" />
        {!demo.locked && <NotificationBanner notification={demo.banner} onOpen={demo.openNotification} />}
        {demo.hint && (
          <p className="phone-hint" role="status">
            {demo.hint}
          </p>
        )}
        {demo.locked && (
          <LockScreen notifications={demo.pending} onOpen={demo.openNotification} onUnlock={demo.unlock} />
        )}
        <div className={`home-indicator ${onLightApp ? 'is-dark' : ''}`} aria-hidden="true" />
      </div>
    </div>
  );
}
