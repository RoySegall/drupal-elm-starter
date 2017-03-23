<?php

/**
 * @file
 * Contains AccountProcessTrait.
 */

trait DevDaysRestfulExampleTrait {

  /**
   * Return a custom author formatting.
   *
   * @param stdClass $account
   *   The account author.
   * @return null|string
   *   The name of the author.
   */
  public function CustomAuthor(stdClass $account) {
    // We are using this API function and not the global user because there
    // might be an option that the plugin uses another authentication than
    // cookies, i.e access token. In that case, the global user will be
    // anonymous.
    $author = $this->getAccount();

    return $author->uid == $account->uid ? t('You') : $account->name;
  }

  /**
   * {@inheritdoc}
   */
  public function createEntity() {
    $return = parent::createEntity();

    // Extract the entity from the array.
    $entity = reset($return);

    $type = $this->getPluginKey('bundle');
    dev_days_restful_example_push('general', 'create__' . $type, $entity);

    // Return stuff like before.
    return $return;
  }

}
