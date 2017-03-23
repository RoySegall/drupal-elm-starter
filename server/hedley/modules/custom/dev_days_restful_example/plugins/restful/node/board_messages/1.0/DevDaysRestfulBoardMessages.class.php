<?php

/**
 * @file
 * Contains DevDaysRestfulBoardMessages.
 */

class DevDaysRestfulBoardMessages extends RestfulEntityBaseNode {

  use DevDaysRestfulExampleTrait;

  /**
   * {@inheritdoc}
   */
  public function publicFieldsInfo() {
    $fields = parent::publicFieldsInfo();

    // We don't need to display the title in this case since only the body of
    // the message is important.
    unset($fields['label']);

    $fields['text'] = [
      'property' => 'body',
      'sub_property' => 'value',
      'process_callbacks' => [
        [$this, 'stripTags'],
      ]
    ];

    $fields['author'] = [
      'property' => 'author',
      'process_callbacks' => [
        [$this, 'CustomAuthor'],
      ],
    ];

    $fields['board'] = [
      'property' => 'field_board_reference',
      'resource' => array(
        // The name of the bundle.
        'board' => array(
          // The name of the handler.
          'name' => 'boards',
        ),
      ),
    ];

    return $fields;
  }

  /**
   * Removes the HTML tags from a string.
   *
   * @var string $value
   *   The string from the body field.
   *
   * @return string
   *   The body field with no tags.
   */
  public function stripTags($value) {
    return strip_tags($value);
  }

}
