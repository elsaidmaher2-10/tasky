import { useId, type ReactNode } from 'react';
import { MaterialIcon, type MaterialIconName } from './Icon';

/** Material checkbox: 18px box inside a 48px tap target (CustomCheckBox in the app). */
export function Checkbox({
  checked,
  onChange,
  label,
}: {
  checked: boolean;
  onChange: (value: boolean) => void;
  label: string;
}) {
  return (
    <button
      type="button"
      role="checkbox"
      aria-checked={checked}
      aria-label={label}
      className="checkbox"
      onClick={() => onChange(!checked)}
    >
      <span className={`checkbox-box ${checked ? 'is-checked' : ''}`}>
        {checked && (
          <svg viewBox="0 0 18 18" width="18" height="18" aria-hidden="true">
            <path d="M3.6 9.4 7.3 13l7-7.6" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="square" />
          </svg>
        )}
      </span>
    </button>
  );
}

/** Material 3 switch with the app's SwitchThemeData (green track, 3px grey outline when off). */
export function Switch({
  checked,
  onChange,
  label,
}: {
  checked: boolean;
  onChange: (value: boolean) => void;
  label: string;
}) {
  return (
    <button
      type="button"
      role="switch"
      aria-checked={checked}
      aria-label={label}
      className={`switch ${checked ? 'is-on' : ''}`}
      onClick={() => onChange(!checked)}
    >
      <span className="switch-thumb" />
    </button>
  );
}

/** ElevatedButton / ElevatedButton.icon: full width, 8px radius, green. */
export function PrimaryButton({
  children,
  icon,
  onClick,
}: {
  children: ReactNode;
  icon?: MaterialIconName;
  onClick: () => void;
}) {
  return (
    <button type="button" className="primary-button" onClick={onClick}>
      {icon && <MaterialIcon name={icon} size={18} />}
      <span>{children}</span>
    </button>
  );
}

/** CustomFormField: filled text field with the hint shown as placeholder text. */
export function TextField({
  label,
  labelClass = 'field-label',
  value,
  onChange,
  hint,
  multiline,
  error,
  autoComplete,
}: {
  label?: string;
  /** CSS class for the label: the app styles it differently on each screen. */
  labelClass?: string;
  value: string;
  onChange: (value: string) => void;
  hint: string;
  multiline?: boolean;
  error?: string | null;
  autoComplete?: string;
}) {
  const id = useId();
  const errorId = `${id}-err`;
  const common = {
    id,
    value,
    placeholder: hint,
    'aria-invalid': error ? true : undefined,
    'aria-describedby': error ? errorId : undefined,
    className: `text-field-input ${error ? 'has-error' : ''}`,
  };
  return (
    <div className="text-field">
      {label && (
        <label htmlFor={id} className={labelClass}>
          {label}
        </label>
      )}
      {multiline ? (
        <textarea {...common} rows={5} onChange={(e) => onChange(e.target.value)} />
      ) : (
        <input
          {...common}
          type="text"
          autoComplete={autoComplete ?? 'off'}
          onChange={(e) => onChange(e.target.value)}
        />
      )}
      {error && (
        <p id={errorId} className="field-error" role="alert">
          {error}
        </p>
      )}
    </div>
  );
}
