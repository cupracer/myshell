#!/usr/bin/php
<?php

if(!array_key_exists("1", $argv)) {
	die("missing parameter\n");
}

$salt="$1$";

for($n=0;$n<11;$n++) 
{
	$salt.=chr(mt_rand(65,90));
}

echo crypt($argv[1]) . "\n";

