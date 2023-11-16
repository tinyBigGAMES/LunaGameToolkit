<?php
/******************************************************************************
        .
     .--:         :
    ----        :---:
  .-----         .-.
 .------          .
 -------.
.--------               :
.---------             .:.
 ----------:            .
 :-----------:
  --------------:.         .:.
   :------------------------
    .---------------------.
       :---------------:.
          ..:::::::..
              ...
     _
    | |    _  _  _ _   __ _
    | |__ | || || ' \ / _` |
    |____| \_,_||_||_|\__,_|
         Game Toolkit™

Copyright © 2022-present tinyBigGAMES™ LLC
         All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

See LICENSE for license information
-------------------------------------------------------------------------------
Based on:
  https://github.com/telecube/mysql-api
  
******************************************************************************/

// ensure this definition exists before running the script.
if(!defined('MAIN_INCLUDED'))
	exit("Not allowed here!");

// the master db for write/read
$master_db_host = "localhost";
$master_db_port = "3306";
$master_db_user = "";
$master_db_pass = "";

// set strong keys here - a good key generator can be found at: https://www.grc.com/passwords.htm
$apikey         = "";
