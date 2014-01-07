CREATE TABLE IF NOT EXISTS `log_rcvd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(200) NOT NULL,
  `rcpt` varchar(200) NOT NULL,
  `count` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `sender_limits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(200) NOT NULL,
  `count` int(11) NOT NULL,
  `max` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sender` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `wblist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(200) NOT NULL,
  `rcpt` varchar(200) NOT NULL,
  `reject` text NOT NULL,
  `blacklisted` int(1) NOT NULL,
  `enabled` int(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `restrictions` (
  `domain` varchar(80) NOT NULL,
  `restrictions` varchar(120) NOT NULL,
  PRIMARY KEY (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `greylist` (
  `sender` varchar(200) NOT NULL,
  `recipient` varchar(200) NOT NULL,
  `host` varchar(15) NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  UNIQUE KEY `sender` (`sender`,`recipient`,`host`),
  KEY `created` (`created`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `verify_info_domains` (
  `domain` varchar(200) NOT NULL,
  `count_rcpt` int(11) NOT NULL,
  `count_eod` int(11) NOT NULL,
  PRIMARY KEY (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `verify_info_mbox` (
  `sender` varchar(200) NOT NULL,
  `recipient` varchar(200) NOT NULL,
  `count` int(11) NOT NULL,
  `instance` varchar(50) NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  PRIMARY KEY (`sender`,`recipient`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
