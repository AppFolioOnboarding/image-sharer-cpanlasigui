/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import App from '../../components/App';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<App />);
    const footer = wrapper.find('Footer');

    assert.strictEqual(footer.length, 1);
    assert.strictEqual(footer.prop('title'), 'Copyright: AppFolio Inc. Onboarding');

    assert(wrapper.contains('Tell us what you think'));
  });
});
