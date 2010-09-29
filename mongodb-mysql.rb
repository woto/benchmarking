require 'rubygems'
require 'mysql'

def flush_mysql
  i = 1
  mysql = Mysql.new('localhost', 'root')
  db_name = "parts_#{i}"
  mysql.query("DROP DATABASE IF EXISTS `#{db_name}`")
  mysql.query("CREATE DATABASE `#{db_name}`")
  mysql.query("USE #{db_name}")

  1.times do |i|
    table_name = "prices_#{i}"
    mysql.query("DROP TABLE IF EXISTS `#{table_name}`")
    mysql.query("CREATE TABLE `#{table_name}` (
       `id` int(11) NOT NULL AUTO_INCREMENT,
       `job_id` int(11) DEFAULT NULL,
       `job_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
       `goods_id` int(11) DEFAULT NULL,
       `supplier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
       `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
       `count` decimal(10,0) DEFAULT NULL,
       `initial_cost` decimal(10,3) DEFAULT NULL,
       `result_cost` decimal(10,3) DEFAULT NULL,
       `margin` decimal(10,3) DEFAULT NULL,
       `manufacturer` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
       `catalog_number` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
       `inn` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
       `kpp` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
       `estimate_days` int(11) DEFAULT NULL,
       `created_at` datetime DEFAULT NULL,
       `updated_at` datetime DEFAULT NULL,
       PRIMARY KEY (`id`, `catalog_number`, `manufacturer`),
       #UNIQUE KEY `ggg` (`catalog_number`(100),`manufacturer`(100), `id`),
       KEY `rrr` (`catalog_number`(100))
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
	PARTITION BY key(`catalog_number`, `manufacturer`)         PARTITIONS 1000
	")

    100_000.times do |i|
      query = "INSERT INTO  `#{table_name}` (
          `id` ,
          `job_id` ,
          `job_title` ,
          `goods_id` ,
          `supplier` ,
          `title` ,
          `count` ,
          `initial_cost` ,
          `result_cost` ,
          `margin` ,
          `manufacturer` ,
          `catalog_number` ,
          `inn` ,
          `kpp` ,
          `estimate_days` ,
          `created_at` ,
          `updated_at`
          )
          VALUES "

      1_000.times do |i|
        query = query + "( NULL ,  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(1_000_000).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '#{rand(100).to_s}',  '2010-08-07 11:46:15',  '2010-08-07 11:46:15' ),"
      end

      query.chop!

      mysql.query(query)

    end
  end
end

flush_mysql
