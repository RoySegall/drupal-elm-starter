<?php

$plugin = array(
  'label' => t('Board messages'),
  'description' => t('Validate the board messages content type.'),
  'entity_type' => 'node',
  'bundle' => 'board_messages',
  'class' => 'DevDaysRestfulExampleBoardMessagesValidator',
);
