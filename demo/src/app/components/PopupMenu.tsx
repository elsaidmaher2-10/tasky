import { useEffect, useRef, useState } from 'react';
import { MaterialIcon } from './Icon';
import { Portal, useOverlayElement } from './Overlay';

interface MenuItem {
  id: string;
  label: string;
}

const MENU_ITEM_HEIGHT = 48;
const MENU_VERTICAL_PADDING = 8;

/** PopupMenuButton: a three-dots button that opens a menu drawn over the whole screen. */
export function PopupMenu({
  items,
  onSelect,
  label,
}: {
  items: MenuItem[];
  onSelect: (id: string) => void;
  label: string;
}) {
  const overlay = useOverlayElement();
  const buttonRef = useRef<HTMLButtonElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);
  const [pos, setPos] = useState<{ top: number; right: number } | null>(null);

  const close = () => {
    setPos(null);
    buttonRef.current?.focus({ preventScroll: true });
  };

  const open = () => {
    const button = buttonRef.current;
    if (!button || !overlay) return;
    const b = button.getBoundingClientRect();
    const o = overlay.getBoundingClientRect();
    // The phone is scaled with CSS transform, so convert screen pixels to phone pixels.
    const scale = o.width / overlay.offsetWidth;
    const menuHeight = items.length * MENU_ITEM_HEIGHT + MENU_VERTICAL_PADDING * 2;
    const rawTop = (b.top - o.top) / scale;
    const maxTop = overlay.offsetHeight - menuHeight - 40;
    setPos({ top: Math.max(8, Math.min(rawTop, maxTop)), right: (o.right - b.right) / scale + 4 });
  };

  useEffect(() => {
    if (!pos) return undefined;
    menuRef.current?.querySelector<HTMLElement>('[role="menuitem"]')?.focus({ preventScroll: true });
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setPos(null);
        buttonRef.current?.focus({ preventScroll: true });
      }
    };
    document.addEventListener('keydown', handler);
    return () => document.removeEventListener('keydown', handler);
  }, [pos]);

  return (
    <>
      <button
        ref={buttonRef}
        type="button"
        className="icon-button"
        aria-label={label}
        aria-haspopup="menu"
        aria-expanded={pos !== null}
        onClick={open}
      >
        <MaterialIcon name="moreVert" />
      </button>
      {pos && (
        <Portal>
          <div className="scrim" onMouseDown={(e) => e.target === e.currentTarget && close()}>
            <div
              ref={menuRef}
              className="popup-menu"
              role="menu"
              style={{ top: pos.top, right: pos.right }}
              onKeyDown={(e) => {
                const els = Array.from(menuRef.current?.querySelectorAll<HTMLElement>('[role="menuitem"]') ?? []);
                const i = els.indexOf(document.activeElement as HTMLElement);
                if (e.key === 'ArrowDown') {
                  e.preventDefault();
                  els[(i + 1) % els.length]?.focus();
                } else if (e.key === 'ArrowUp') {
                  e.preventDefault();
                  els[(i - 1 + els.length) % els.length]?.focus();
                }
              }}
            >
              {items.map((item) => (
                <button
                  key={item.id}
                  type="button"
                  role="menuitem"
                  className="popup-item"
                  onClick={() => {
                    setPos(null);
                    onSelect(item.id);
                  }}
                >
                  {item.label}
                </button>
              ))}
            </div>
          </div>
        </Portal>
      )}
    </>
  );
}
