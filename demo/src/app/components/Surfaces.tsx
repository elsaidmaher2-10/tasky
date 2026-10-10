import { useEffect, useId, useRef, type ReactNode, type RefObject } from 'react';
import { Portal } from './Overlay';

function useEscape(onClose: () => void) {
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', handler);
    return () => document.removeEventListener('keydown', handler);
  }, [onClose]);
}

/** Moves focus into the surface when it opens and gives it back when it closes. */
function useFocusIn(ref: RefObject<HTMLElement | null>) {
  useEffect(() => {
    const previous = document.activeElement as HTMLElement | null;
    const target = ref.current?.querySelector<HTMLElement>('input, textarea, button');
    target?.focus({ preventScroll: true });
    return () => previous?.focus?.({ preventScroll: true });
  }, [ref]);
}

/** AlertDialog. */
export function Dialog({
  title,
  children,
  actions,
  onClose,
}: {
  title: string;
  children?: ReactNode;
  actions: ReactNode;
  onClose: () => void;
}) {
  const titleId = useId();
  const ref = useRef<HTMLDivElement>(null);
  useEscape(onClose);
  useFocusIn(ref);
  return (
    <Portal>
      <div className="scrim scrim-center" onMouseDown={(e) => e.target === e.currentTarget && onClose()}>
        <div ref={ref} className="dialog" role="alertdialog" aria-modal="true" aria-labelledby={titleId}>
          <h2 id={titleId} className="dialog-title">
            {title}
          </h2>
          {children && <div className="dialog-content">{children}</div>}
          <div className="dialog-actions">{actions}</div>
        </div>
      </div>
    </Portal>
  );
}

/** showModalBottomSheet. */
export function BottomSheet({
  label,
  children,
  onClose,
}: {
  label: string;
  children: ReactNode;
  onClose: () => void;
}) {
  const ref = useRef<HTMLDivElement>(null);
  useEscape(onClose);
  useFocusIn(ref);
  return (
    <Portal>
      <div className="scrim scrim-bottom" onMouseDown={(e) => e.target === e.currentTarget && onClose()}>
        <div ref={ref} className="bottom-sheet" role="dialog" aria-modal="true" aria-label={label}>
          {children}
        </div>
      </div>
    </Portal>
  );
}
