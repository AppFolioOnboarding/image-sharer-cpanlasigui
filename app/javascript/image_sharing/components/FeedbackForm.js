import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';

const formStyle = {
  maxWidth: '40%',
  margin: '0 auto'
};

export default function FeedbackForm() {
  return (
    <div style={formStyle} >
      <Form>
        <FormGroup>
          <Label for='nameInput'>Your name:</Label>
          <Input type='text' id='nameInput' />
          <Label for='commentsInput'>Comments:</Label>
          <Input type='text' id='commentsInput' />
        </FormGroup>
      </Form>
      <Button color="primary">Submit</Button>
    </div>
  );
}
