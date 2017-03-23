<?php
/**
 * @file
 * dev_days_restful_example.features.inc
 */

/**
 * Implements hook_node_info().
 */
function dev_days_restful_example_node_info() {
  $items = array(
    'board' => array(
      'name' => t('Board'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'board_messages' => array(
      'name' => t('Board messages'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}
