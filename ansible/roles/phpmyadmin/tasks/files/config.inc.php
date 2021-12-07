<?php


declare(strict_types=1);

$cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */


$i = 0;

$i++;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
$cfg['AllowArbitraryServer'] = true;

/* Server parameters */
$cfg['Servers'][$i]['compress'] = true;
$cfg['Servers'][$i]['AllowNoPassword'] = true;
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['verbose'] = 'RDS';
/* $cfg['Servers'][$i]['host'] = $host; */
