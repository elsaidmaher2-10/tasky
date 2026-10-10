import { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { useAppStore } from '../store';
import { TextField, PrimaryButton } from '../components/Controls';
import logo from '../assets/logo.png';
import wave from '../assets/waving_hand.png';
import pana from '../assets/pana.svg';

/** WelcomeScreen: asks for the user's name, then opens the main screen. */
export function WelcomeScreen() {
  const demo = useDemo();
  const store = useAppStore();
  const [name, setName] = useState('');
  const [error, setError] = useState<string | null>(null);

  const submit = () => {
    if (name === '') {
      setError('Please Enetr Your Full Name');
      return;
    }
    setError(null);
    store.setUser(name);
    demo.navigate('/home');
  };

  return (
    <div className="screen welcome safe-top safe-bottom">
      <form
        className="welcome-scroll"
        onSubmit={(e) => {
          e.preventDefault();
          submit();
        }}
        noValidate
      >
        <div className="welcome-brand">
          <img src={logo} width={43} height={42} alt="" />
          <span className="t-display-medium">Tasky</span>
        </div>

        <div className="welcome-title">
          <h1 className="t-display-small">Welcome To Tasky&nbsp;</h1>
          <img src={wave} width={28} height={28} alt="" />
        </div>
        <p className="t-display-small welcome-sub">Your productivity journey starts here.</p>

        <div className="welcome-art">
          <img src={pana} alt="" />
        </div>

        <TextField
          label="Full Name"
          labelClass="field-label t-label"
          value={name}
          onChange={setName}
          hint="e.g. Sarah Khalid"
          error={error}
          autoComplete="name"
        />
        <div className="gap-h24" />
        <PrimaryButton onClick={submit}>Let’s Get Started</PrimaryButton>
      </form>
    </div>
  );
}
