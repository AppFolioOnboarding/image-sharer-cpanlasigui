/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);
    const labels = wrapper.find('Label');
    const inputs = wrapper.find('Input');
    const buttons = wrapper.find('Button');

    assert.strictEqual(labels.length, 2);
    assert.strictEqual(inputs.length, 2);
    assert.strictEqual(buttons.length, 1);

    assert.strictEqual(labels.first().children().text(), 'Your name:');
    assert.strictEqual(labels.last().children().text(), 'Comments:');
    assert.strictEqual(buttons.children().text(), 'Submit');
  });
});
