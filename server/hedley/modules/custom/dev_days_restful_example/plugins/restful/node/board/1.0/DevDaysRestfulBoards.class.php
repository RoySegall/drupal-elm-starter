<?php

/**
 * @file
 * Contains DevDaysRestfulBoards.
 */

class DevDaysRestfulBoards extends RestfulEntityBaseNode {

  use DevDaysRestfulExampleTrait;

  /**
   * {@inheritdoc}
   */
  public function publicFieldsInfo() {
    $fields = parent::publicFieldsInfo();

    $fields['description'] = [
      'property' => 'body',
      'sub_property' => 'value',
    ];

    $fields['dummy_field'] = [
      'callback' => [$this, 'DummyField'],
    ];

    $fields['author'] = [
      'property' => 'author',
      'process_callbacks' => [
        [$this, 'CustomAuthor'],
      ],
    ];

    return $fields;
  }

  /**
   * Just dummy field.
   *
   * @param EntityDrupalWrapper $wrapper
   *   The wrapper object.
   *
   * @return string
   *   What to display in the dummy field.
   */
  public function DummyField(EntityDrupalWrapper $wrapper) {
    return t('Dummy field or the title: @title', ['@title' => $wrapper->label()]);
  }

}
