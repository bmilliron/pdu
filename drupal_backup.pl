#!/usr/bin/perl

use IO::Prompt;

#get the MySQL password used for backups, if needed.
#my $password = prompt('Enter MySQL Password:', -e => '*');
#print "$password\n";

#check for the backup forlder, and create if needed
my $date=`date +%Y%m%d`;
chomp($date);

#directory paths
my $backupFilePath = "/var/drupal_backups/";
my $backupDirectory = $backupFilePath . "drupal_full_backup_" . $date;
my $drupalHome = "/var/www/html";
my $drupalDbName = "drupaldbname";
my $drupalBackupFiles = $backupDirectory . "/drupal_backup_files";
my $apacheBackupFiles = $backupDirectory . "/apache_backup_files";
my $databaseBackupFiles = $backupDirectory . "/database_backup_files";

#check for backup directory
if (-e $backupDirectory && -d $backupDirectory){

	print "The backup destination folder exists. \n";
}else{

	system("mkdir $backupDirectory");
}

#make drupal_files directory, in backup directory
if (-e $drupalBackupFiles  && -d $drupalBackupFiles){

        print "The drupal backup files folder destination exists. \n";
}else{

        system("mkdir $backupDirectory/drupal_files");
}

#make database_backups directory, in backup directory
if (-e $databaseBackupFiles && -d $databaseBackupFiles){

        print "The database backup files folder destination exists. \n";
}else{

        system("mkdir $backupDirectory/database_backup_files");
}

#make an apache conf files backup directory
if (-e $apacheBackupFiles && -d $apacheBackupFiles){

        print "The apache backup files folder destination exists. \n";
}else{

        system("mkdir $backupDirectory/apache_backup_files");
}

#backup drupal files
system("cp -r /var/www/html $backupDirectory/drupal_files");

#backup apache conf files
system("cp -r /etc/apache2 $backupDirectory/apache_backup_files");

#MySQL database backup
system("mysqldump -u root $drupalDbName  > $backupDirectory/database_backup_files/" . $drupalDbName . "_full_" . $date . ".sql");


