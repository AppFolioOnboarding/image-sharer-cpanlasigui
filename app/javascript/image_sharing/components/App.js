import React from 'react';
import FeedbackForm from './FeedbackForm';
import Header from './Header';
import Footer from './Footer';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <FeedbackForm />
      <Footer title="Copyright: AppFolio Inc. Onboarding" />
    </div>
  );
}

/* TODO: Add Prop Types check*/
