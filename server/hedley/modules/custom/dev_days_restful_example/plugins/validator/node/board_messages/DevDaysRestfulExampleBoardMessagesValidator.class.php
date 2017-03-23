<?php

/**
 * @file
 * Contains DevDaysRestfulExampleBoardValidator.
 */

class DevDaysRestfulExampleBoardMessagesValidator extends EntityValidateBase {

  /**
   * Overrides EntityValidateBase::publicFieldsInfo().
   */
  public function publicFieldsInfo() {
    $public_fields = parent::publicFieldsInfo();

    unset($public_fields['title']);

    $public_fields['body'] = [
      'required' => TRUE,
    ];

    $public_fields['field_board_reference'] = [
      'required' => TRUE,
    ];

    return $public_fields;
  }

}