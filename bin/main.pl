#!/usr/bin/perl

use strict;
use warnings;

# link the modules under lib to this executable
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Text::nCSV;
use Text::nExcel;
use Getopt::Long;

my $original_fmt = "";
my $src_file = "";
my $target_fmt = "";
my $dest_file = "";

my $data;

GetOptions("o=s" => \$original_fmt, "s=s" => \$src_file, "t=s" => \$target_fmt, "d=s" => \$dest_file) or die("Error in command line arguments\n");

die("\nusage: bin/main.pl [<command>] [<args>]\n\n\tThe valid, required commands are:\n\t-o\toriginal format. Currently supported formats are csv and xlsx. See note [1] below\n\t-s\tsource file. This is the name of the file that needs to be converted\n\t-t\ttarget format. Currently supported formats are csv and xlsx. See note [1] below\n\t-d\tdesitination file. This is the name of the converted, output file.\n\nExample: bin/main.pl -o csv -s input.csv -t xlsx -d output.xlsx\n\nnote [1] - csv is comma separated value file format; xlsx is excel spreadsheet file format\n") if ($original_fmt eq "" or $src_file eq "" or $target_fmt eq "" or $dest_file eq "");

if($original_fmt eq "csv") {
	my $in = Text::nCSV->new(streamIn => $src_file);
	$data = $in->readCSV();
}
elsif($original_fmt eq "xlsx") {
	my $in = Text::nExcel->new(streamIn => $src_file);
	$data = $in->readCSV();
}
else {
	die("Error :: The flag -o was not specified a supported format. Currently supported formats are csv and xlsx\n\n");
}

if($target_fmt eq "csv") {
	my $out = Text::nExcel->new( streamOut => $dest_file, dataObj => $data);
	$out->writeCSV();
}
elsif($target_fmt eq "xlsx") {
	my $out = Text::nExcel->new( streamOut => $dest_file, dataObj => $data );
	$out->writeExcel();
}
else {
	die("Error :: The flag -t was not specified a supported format. Currently supported formats are csv and xlsx\n\n");
}
