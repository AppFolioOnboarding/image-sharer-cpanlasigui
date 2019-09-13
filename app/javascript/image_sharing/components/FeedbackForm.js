import React, { useState } from 'react';
import { Button, Form, FormGroup, Label, Input, Alert } from 'reactstrap';
import { serialize, post } from '../utils/helper';

const styles = {
  formStyle: {
    maxWidth: '40%',
    margin: '0 auto'
  },
  inlineStyle: {
    display: 'inline'
  },
  leftMarginStyle: {
    marginLeft: '20px'
  }
};

export default function FeedbackForm() {
  const [alert, setAlert] = useState();
  const [name, setName] = useState('');
  const [comment, setComment] = useState('');

  function clearInputs() {
    setName('');
    setComment('');
  }

  function displayAlert(status, message) {
    setAlert({
      color: status,
      message
    });
  }

  function handleClick() {
    const queryParams = serialize({
      feedback: {
        name,
        comment
      }
    });

    return post(`/api/feedbacks?${queryParams}`)
      .then((response) => {
        displayAlert('success', response.message || 'Success');
        clearInputs();
      })
      .catch(() => {
        displayAlert('warning', 'Name and Comments Required');
      });
  }

  return (
    <div style={styles.formStyle} >
      <Form className='feedback-form'>
        <FormGroup>
          <Label for='nameInput'>Your name:</Label>
          <Input onChange={e => setName(e.target.value)} type='text' value={name} id='nameInput' />
          <Label for='commentsInput'>Comments:</Label>
          <Input
            onChange={e => setComment(e.target.value)}
            type='text'
            value={comment}
            id='nameInput'
          />
        </FormGroup>
      </Form>
      <div>
        <Button
          style={styles.inlineStyle}
          onClick={() => handleClick()}
          color="primary"
        >
          Submit
        </Button>
        {alert &&
          <Alert
            style={{ ...styles.inlineStyle, ...styles.leftMarginStyle }}
            color={alert.color}
          >
            {alert.message}
          </Alert>
        }
      </div>
    </div>
  );
}
