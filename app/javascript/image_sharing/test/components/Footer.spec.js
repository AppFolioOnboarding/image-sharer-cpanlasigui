/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Footer title="Title" />);
    const title = wrapper.find('small');

    assert.strictEqual(title.length, 1);
    assert.strictEqual(title.children().text(), 'Title');
  });
});
