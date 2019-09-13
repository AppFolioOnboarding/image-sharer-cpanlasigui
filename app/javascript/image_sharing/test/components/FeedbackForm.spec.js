/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import * as api from '../../utils/helper';

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

  it('should clear form and render success alert when request succeeds', async () => {
    const wrapper = shallow(<FeedbackForm />);
    let inputs = wrapper.find('Input');

    inputs.at(0).simulate('change', { target: { value: 'Name' } });
    inputs.at(1).simulate('change', { target: { value: 'Comment' } });

    wrapper.update();
    inputs = wrapper.find('Input');
    const button = wrapper.find('Button');

    assert.strictEqual(inputs.at(0).prop('value'), 'Name');
    assert.strictEqual(inputs.at(1).prop('value'), 'Comment');

    const postStub = sinon.stub(api, 'post').resolves({});
    const goodRequest =
      '/api/feedbacks?feedback%5Bname%5D=Name&feedback%5Bcomment%5D=Comment';
    await button.prop('onClick')();
    wrapper.update();
    inputs = wrapper.find('Input');
    const alert = wrapper.find('Alert');

    assert(postStub.calledWith(goodRequest));

    assert.strictEqual(inputs.at(0).prop('value'), '');
    assert.strictEqual(inputs.at(1).prop('value'), '');
    assert.strictEqual(alert.prop('color'), 'success');
    assert.strictEqual(alert.children().text(), 'Success');

    sinon.restore();
  });

  it('should render alert message when request is bad', async () => {
    const wrapper = shallow(<FeedbackForm />);
    const button = wrapper.find('Button');

    const postStub = sinon.stub(api, 'post').rejects({});

    await button.prop('onClick')();
    wrapper.update();
    const alert = wrapper.find('Alert');

    assert(postStub.calledOnce);
    assert.strictEqual(alert.prop('color'), 'warning');
    assert.strictEqual(alert.children().text(), 'Name and Comments Required');

    sinon.restore();
  });
});
