import { useEffect, useState } from 'react';
import { DEMO_CONFIG } from '../demo.config';
import type { FrameId } from '../types';
import { AppRoot } from '../app/AppRoot';
import { BEZEL, PHONE_H, PHONE_W, PhoneFrame } from './PhoneFrame';
import { ControlPanel } from './ControlPanel';

const FRAME_W = PHONE_W + BEZEL * 2;
const FRAME_H = PHONE_H + BEZEL * 2;
/** Below this width the panel stacks under the phone. */
const STACK_BREAKPOINT = 900;

function useViewport() {
  const read = () => ({ w: window.innerWidth, h: window.innerHeight });
  const [size, setSize] = useState(read);
  useEffect(() => {
    const onResize = () => setSize(read());
    window.addEventListener('resize', onResize);
    return () => window.removeEventListener('resize', onResize);
  }, []);
  return size;
}

/** Page layout: the phone on the left, the control panel on the right (stacked on small screens). */
export function DemoShell() {
  const { w, h } = useViewport();
  const [frame, setFrame] = useState<FrameId>(DEMO_CONFIG.defaultFrame);
  const [zoom, setZoom] = useState(1);

  const stacked = w < STACK_BREAKPOINT;
  // Fit the phone to the viewport (height on desktop, width when stacked), never upscale,
  // then apply the viewer's zoom on top. The logical 390x844 size never changes.
  const fit = stacked ? (w - 32) / FRAME_W : (h - 48) / FRAME_H;
  const scale = Math.max(0.3, Math.min(1, fit)) * zoom;

  return (
    <div className={`stage ${stacked ? 'is-stacked' : ''}`}>
      <div className="stage-phone">
        <div className="phone-slot" style={{ width: FRAME_W * scale, height: FRAME_H * scale }}>
          <div className="phone-scale" style={{ transform: `scale(${scale})` }}>
            <PhoneFrame frame={frame}>
              <AppRoot />
            </PhoneFrame>
          </div>
        </div>
      </div>
      <ControlPanel frame={frame} onFrame={setFrame} zoom={zoom} onZoom={setZoom} />
    </div>
  );
}
