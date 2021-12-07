<?php
/**
 * phpMyAdmin sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <https://docs.phpmyadmin.net/>.
 */

declare(strict_types=1);

/**
 * This is needed for cookie based authentication to encrypt password in
 * cookie. Needs to be 32 chars long.
 */
$cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

/**
 * Servers configuration
 */
$i = 0;

/**
 * First server
 */
$i++;

/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/* Server parameters */
$cfg['Servers'][$i]['compress'] = true;
$cfg['Servers'][$i]['AllowNoPassword'] = true;
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['verbose'] = 'RDS';
#$cfg['Servers'][$i]['host'] = 'terraform-20211206191831258300000003.czccxlfdajua.eu-central-1.rds.amazonaws.com';
