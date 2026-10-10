import { createContext, useContext, type ReactNode } from 'react';
import { createPortal } from 'react-dom';

/** The element inside the phone screen where dialogs, sheets and menus are drawn, so they
 *  are clipped by the phone and scale with it. */
const OverlayContext = createContext<HTMLElement | null>(null);

export const OverlayProvider = OverlayContext.Provider;

export function useOverlayElement(): HTMLElement | null {
  return useContext(OverlayContext);
}

export function Portal({ children }: { children: ReactNode }) {
  const el = useContext(OverlayContext);
  return el ? createPortal(children, el) : null;
}
