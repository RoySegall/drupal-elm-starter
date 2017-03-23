<?php

/**
 * @file
 * Contains DevDaysRestfulExampleBoardValidator.
 */

class DevDaysRestfulExampleBoardValidator extends EntityValidateBase {

  /**
   * Overrides EntityValidateBase::publicFieldsInfo().
   */
  public function publicFieldsInfo() {
    $public_fields = parent::publicFieldsInfo();

    $public_fields['title']['validators'][] = array($this, 'TitleLengthValidation');

    $public_fields['body'] = [
      'required' => TRUE,
    ];

    return $public_fields;
  }

  /**
   * Validate the title is at least 3 characters long.
   *
   * @param string $field_name
   *   The field name.
   * @param mixed $value
   *   The value of the field.
   * @param EntityMetadataWrapper $wrapper
   *   The wrapped entity.
   * @param EntityMetadataWrapper $property_wrapper
   *   The wrapped property.
   */
  public function TitleLengthValidation($field_name, $value, EntityMetadataWrapper $wrapper, EntityMetadataWrapper $property_wrapper) {
    if (strlen($value) < 3) {
      $this->setError($field_name, 'The @field should be at least 3 characters long.');
    }
  }

}
