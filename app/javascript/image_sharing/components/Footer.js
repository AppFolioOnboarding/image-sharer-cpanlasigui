import PropTypes from 'prop-types';
import React from 'react';

export default function Footer(props) {
  return (
    <footer className='text-center'>
      <small>
        {props.title}
      </small>
    </footer>
  );
}

Footer.propTypes = {
  title: PropTypes.string.isRequired
};
