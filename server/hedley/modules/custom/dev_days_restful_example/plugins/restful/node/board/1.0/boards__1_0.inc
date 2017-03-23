<?php

$plugin = array(
  'label' => t('Boards'),
  'resource' => 'boards',
  'name' => 'boards__1_0',
  'entity_type' => 'node',
  'bundle' => 'board',
  'description' => t('Provide the list of available boards'),
  'class' => 'DevDaysRestfulBoards',
  'authentication_types' => TRUE,
  'authentication_optional' => TRUE,
);
