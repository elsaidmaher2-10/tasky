import { MaterialIcon } from './Icon';
import { useDemo } from '../../bridge/DemoContext';

/** Material AppBar: 56px tall, title left-aligned, back arrow on pushed screens. */
export function AppBar({
  title,
  back,
  bold,
}: {
  title: string;
  back?: boolean;
  bold?: boolean;
}) {
  const demo = useDemo();
  return (
    <header className={`app-bar ${back ? 'has-back' : ''}`}>
      {back && (
        <button type="button" className="icon-button app-bar-back" aria-label="Back" onClick={demo.back}>
          <MaterialIcon name="arrowBack" />
        </button>
      )}
      <h1 className={`app-bar-title ${bold ? 'is-bold' : ''}`}>{title}</h1>
    </header>
  );
}
