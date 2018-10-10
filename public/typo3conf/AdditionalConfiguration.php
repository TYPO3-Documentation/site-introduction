<?php

$loader = new Dotenv\Dotenv(__DIR__ . '/../../', '.env.dist');
$loader->overload();
if (file_exists(__DIR__ . '/../../.env')) {
    $loader = new Dotenv\Dotenv(__DIR__ . '/../../');
    $loader->overload();
}

// Database Credentials
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['host'] = getenv('TYPO3_DB_CONNECTIONS_DEFAULT_HOST');
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['port'] = getenv('TYPO3_DB_CONNECTIONS_DEFAULT_PORT');
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['user'] = getenv('TYPO3_DB_CONNECTIONS_DEFAULT_USER');
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['password'] = getenv('TYPO3_DB_CONNECTIONS_DEFAULT_PASS');
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['dbname'] = getenv('TYPO3_DB_CONNECTIONS_DEFAULT_NAME');

// Graphics
$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor'] = getenv('TYPO3_GFX_PROCESSOR');
$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor_path'] = getenv('TYPO3_GFX_PROCESSOR_PATH');
$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor_path_lzw'] = getenv('TYPO3_GFX_PROCESSOR_PATH_LZW');

// Mail
$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport'] = getenv('TYPO3_MAIL_TRANSPORT');
$GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_server'] = getenv('TYPO3_MAIL_TRANSPORT_SMTP_SERVER');

// System
$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = getenv('TYPO3_TRUSTED_HOST_PATTERN');

// Caching
if (!function_exists('setCacheBackend')) {
    function setCacheBackend($backendClassName, $cacheName)
    {
        $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations'][$cacheName]['backend'] = $backendClassName;
        $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations'][$cacheName]['options'] = [];
    }
}
$apcExtensionLoaded = extension_loaded('apc');
$apcuExtensionLoaded = extension_loaded('apcu');
$apcAvailable = $apcExtensionLoaded || $apcuExtensionLoaded;
$apcEnabled = ini_get('apc.enabled') == TRUE;
if (TYPO3\CMS\Core\Utility\GeneralUtility::getApplicationContext() !== 'Development' && $apcAvailable && $apcEnabled) {
    $backendClassName = $apcExtensionLoaded ? 'TYPO3\\CMS\\Core\\Cache\\Backend\\ApcBackend'
        : 'TYPO3\\CMS\\Core\\Cache\\Backend\\ApcuBackend';
} else {
    $backendClassName = 'TYPO3\\CMS\\Core\\Cache\\Backend\\FileBackend';
}
setCacheBackend($backendClassName, 'adminpanel_requestcache');
setCacheBackend($backendClassName, 'cache_hash');
setCacheBackend($backendClassName, 'cache_imagesizes');
setCacheBackend($backendClassName, 'cache_pages');
setCacheBackend($backendClassName, 'cache_pagesection');
setCacheBackend($backendClassName, 'cache_rootline');
setCacheBackend($backendClassName, 'extbase_datamapfactory_datamap');
setCacheBackend($backendClassName, 'extbase_object');
setCacheBackend($backendClassName, 'extbase_reflection');
setCacheBackend($backendClassName, 'extbase_typo3dbbackend_queries');
setCacheBackend($backendClassName, 'extbase_typo3dbbackend_tablecolumns');
if (PHP_SAPI === 'cli') {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['extbase_object']['backend'] = 'TYPO3\\CMS\\Core\\Cache\\Backend\\FileBackend';
}
