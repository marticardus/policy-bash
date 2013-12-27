CREATE TABLE IF NOT EXISTS `relay_networks` (
  `networkid` int(11) NOT NULL AUTO_INCREMENT,
  `network` varchar(18) NOT NULL,
  `comment` varchar(80) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`networkid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `relay_user_perms` (
  `login` varchar(80) NOT NULL,
  `sender` varchar(80) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`login`,`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `relay_users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `password` varchar(80) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
