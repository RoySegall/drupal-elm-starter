<?php

$plugin = array(
  'label' => t('Board messages'),
  'resource' => 'board_messages',
  'name' => 'board_messages__1_0',
  'entity_type' => 'node',
  'bundle' => 'board_messages',
  'description' => t('Provide the list of available board messages'),
  'class' => 'DevDaysRestfulBoardMessages',
  'authentication_types' => TRUE,
  'authentication_optional' => TRUE,
);
