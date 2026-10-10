import { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { useAppStore } from '../store';
import { AppBar } from '../components/AppBar';
import { AppIcon, MaterialIcon } from '../components/Icon';
import { PrimaryButton, Switch, TextField } from '../components/Controls';
import { Dialog } from '../components/Surfaces';
import personImg from '../assets/person.png';

/** ProfileScreen: avatar, name, quote and the settings list. */
export function ProfileScreen() {
  const demo = useDemo();
  const store = useAppStore();
  const { userName, quote, avatar, dark } = store.state;

  return (
    <div className="profile">
      <h1 className="profile-title">My Profile</h1>
      <div className="profile-hero">
        <div className="avatar avatar-large">
          <img src={avatar ?? personImg} alt="Profile picture" />
          <button
            type="button"
            className="avatar-camera"
            aria-label="Change profile picture"
            onClick={() => store.setAvatarDialog(true)}
          >
            <MaterialIcon name="cameraOutlined" />
          </button>
        </div>
        <div className="profile-name">{userName ?? ''}</div>
        <div className="t-title-small profile-quote">{quote}</div>
      </div>

      <h2 className="profile-section">Profile Info</h2>
      <button type="button" className="list-tile" onClick={() => demo.navigate('/user-details')}>
        <span className="list-tile-leading">
          <AppIcon name="profile" />
        </span>
        <span className="list-tile-title">Profile</span>
        <AppIcon name="arrowBack" />
      </button>
      <hr className="divider" />
      <div className="list-tile">
        <span className="list-tile-leading">
          <AppIcon name="moon" />
        </span>
        <span className="list-tile-title" id="dark-mode-label">
          Dark Mode
        </span>
        <Switch checked={dark} onChange={store.setDark} label="Dark Mode" />
      </div>
      <hr className="divider" />
      <button
        type="button"
        className="list-tile"
        onClick={() => {
          store.setUser(null);
          demo.navigate('/welcome');
        }}
      >
        <span className="list-tile-leading">
          <AppIcon name="logout" />
        </span>
        <span className="list-tile-title">Log Out</span>
        <AppIcon name="arrowBack" />
      </button>
    </div>
  );
}

function sampleAvatar(background: string, letter: string): string {
  const svg =
    `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120"><rect width="120" height="120" fill="${background}"/>` +
    `<text x="60" y="78" font-family="Arial, sans-serif" font-size="56" font-weight="700" fill="#fff" text-anchor="middle">${letter}</text></svg>`;
  return `data:image/svg+xml;utf8,${encodeURIComponent(svg)}`;
}

/** imageDialogs: Gallery / Camera / Done. The picker and camera are simulated. */
export function AvatarDialog() {
  const store = useAppStore();
  const [selected, setSelected] = useState<string | null>(null);
  const letter = (store.state.userName ?? 'T').trim().charAt(0).toUpperCase() || 'T';
  const close = () => store.setAvatarDialog(false);

  return (
    <Dialog
      title="Choose Image Profile"
      onClose={close}
      actions={
        <>
          <button type="button" className="text-button" onClick={() => setSelected(sampleAvatar('#6a5acd', letter))}>
            <MaterialIcon name="image" size={18} />
            Gallery
          </button>
          <button type="button" className="text-button" onClick={() => setSelected(sampleAvatar('#e07a5f', letter))}>
            <MaterialIcon name="cameraAlt" size={18} />
            Camera
          </button>
          <button
            type="button"
            className="text-button"
            onClick={() => {
              if (selected) store.setAvatar(selected);
              close();
            }}
          >
            Done
          </button>
        </>
      }
    >
      <p className="dialog-note">
        {selected ? 'Picture selected. Tap Done to use it.' : 'Demo: Gallery and Camera pick a sample picture.'}
      </p>
    </Dialog>
  );
}

/** UserDetailsScreen: edit the name and the motivation quote. */
export function UserDetailsScreen() {
  const demo = useDemo();
  const store = useAppStore();
  const [name, setName] = useState(store.state.userName ?? '');
  const [quote, setQuote] = useState(store.state.quote);

  const save = () => {
    store.setUser(name, quote);
    demo.back();
  };

  return (
    <div className="screen pushed-page safe-top">
      <AppBar title="User Details" back bold />
      <form
        className="form-page"
        noValidate
        onSubmit={(e) => {
          e.preventDefault();
          save();
        }}
      >
        <div className="form-scroll">
          <TextField
            label="User Name"
            labelClass="field-label t-label"
            value={name}
            onChange={setName}
            hint="Usama Elgendy"
            autoComplete="name"
          />
          <div className="gap-h20" />
          <TextField
            label="Motivation Quote"
            labelClass="field-label t-label"
            value={quote}
            onChange={setQuote}
            hint="One task at a time. One step closer."
            multiline
          />
        </div>
        <PrimaryButton icon="edit" onClick={save}>
          Save Changes
        </PrimaryButton>
        <div className="gap-h8" />
      </form>
    </div>
  );
}
