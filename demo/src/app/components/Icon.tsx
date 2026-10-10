import type { CSSProperties } from 'react';

import homeSvg from '../assets/home.svg';
import todoSvg from '../assets/todo.svg';
import completeSvg from '../assets/compelete.svg';
import profileSvg from '../assets/profile.svg';
import arrowLeftSvg from '../assets/arrowleft.svg';
import arrowBackSvg from '../assets/arrowback.svg';
import moonSvg from '../assets/moon-01.svg';
import logoutSvg from '../assets/log-out-01.svg';

/** The app's own SVG icons. Flutter tints them with a ColorFilter (srcIn), so here they
 *  are used as CSS masks and coloured with `currentColor`. */
export const APP_ICONS = {
  home: { src: homeSvg, w: 21, h: 21 },
  todo: { src: todoSvg, w: 19, h: 22 },
  complete: { src: completeSvg, w: 25, h: 24 },
  profile: { src: profileSvg, w: 25, h: 24 },
  arrowLeft: { src: arrowLeftSvg, w: 12, h: 12 },
  arrowBack: { src: arrowBackSvg, w: 16, h: 16 },
  moon: { src: moonSvg, w: 24, h: 25 },
  logout: { src: logoutSvg, w: 24, h: 24 },
} as const;

export type AppIconName = keyof typeof APP_ICONS;

export function AppIcon({ name, className }: { name: AppIconName; className?: string }) {
  const icon = APP_ICONS[name];
  const style: CSSProperties = {
    width: icon.w,
    height: icon.h,
    WebkitMaskImage: `url("${icon.src}")`,
    maskImage: `url("${icon.src}")`,
  };
  return <span className={`app-icon ${className ?? ''}`} style={style} aria-hidden="true" />;
}

/** Material icons used by the app (Icons.add, more_vert, ...), 24x24 viewBox. */
const MATERIAL_PATHS = {
  add: 'M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z',
  moreVert:
    'M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z',
  arrowBack: 'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z',
  edit: 'M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z',
  image:
    'M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z',
  cameraAlt:
    'M9 2 7.17 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2h-3.17L15 2H9zm3 15c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z',
  cameraOutlined:
    'M9 2 7.17 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2h-3.17L15 2H9zm11 16H4V6h4.05l1.83-2h4.24l1.83 2H20v12zM12 7c-2.76 0-5 2.24-5 5s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0 8c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3z',
} as const;

export type MaterialIconName = keyof typeof MATERIAL_PATHS;

export function MaterialIcon({ name, size = 24 }: { name: MaterialIconName; size?: number }) {
  return (
    <svg
      className="material-icon"
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="currentColor"
      aria-hidden="true"
      focusable="false"
    >
      <path d={MATERIAL_PATHS[name]} />
    </svg>
  );
}
