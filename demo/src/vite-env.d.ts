// Asset imports resolve to a URL string (Vite) in both dev and build.
declare module '*.svg' {
  const url: string;
  export default url;
}
declare module '*.png' {
  const url: string;
  export default url;
}
// Side-effect stylesheet imports (TypeScript 6 checks them).
declare module '*.css';
