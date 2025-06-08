<?php

$file = '';
if (getenv('IS_DDEV_PROJECT') == 'true') {
    $file = realpath(__DIR__) . '/additional_ddev.php';
}
if (is_file($file)) {
    include_once($file);
}
