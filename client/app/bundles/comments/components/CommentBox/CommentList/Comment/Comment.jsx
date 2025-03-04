import BaseComponent from 'libs/components/BaseComponent';
import React from 'react';
import PropTypes from 'prop-types';

import { marked } from 'marked';
import sanitizeHtml from 'sanitize-html';
import css from './Comment.module.scss';

export default class Comment extends BaseComponent {
  static propTypes = {
    author: PropTypes.string.isRequired,
    text: PropTypes.string.isRequired,
  };

  render() {
    const { author, text } = this.props;
    const rawMarkup = marked(text, { gfm: true });
    const sanitizedRawMarkup = sanitizeHtml(rawMarkup);

    /* eslint-disable react/no-danger */
    return (
      <div className={css.comment}>
        <h2 className={`${css.commentAuthor} js-comment-author`}>{author}</h2>
        <span dangerouslySetInnerHTML={{ __html: sanitizedRawMarkup }} className="js-comment-text" />
      </div>
    );
  }
}
