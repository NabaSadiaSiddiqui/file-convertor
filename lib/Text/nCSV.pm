package Text::nCSV;

use strict;
use warnings;

use Moose;
use Text::CSV_XS;

# streamOut is the path to the file that has to be written out to
has 'streamOut' => (
	is => 'rw',
	isa => 'Str',
	);

# streamIn is the path to the file that was to be read in from
has 'streamIn' => (
	is => 'rw',
	isa => 'Str',
	);

# dataObj is an array ref that will be written to streamOut -> initialized in the constructor
has 'dataObj' => (
	is => 'rw',
	isa => 'ArrayRef',
	);

# read the csv data from streamIn
# and return it as an array reference where each element is an array reference itself
sub readCSV
{
	my $self = shift;

	my $fh = $self->streamIn;

	my $csv = Text::CSV_XS->new ({binary => 1, auto_diag => 1 });
	open my $io, "<", $fh or die "$fh: $!";

	my $data = $csv->getline_all($io);

	close $fh;

	$data;
}

# write data saved in dataObj
# to the file represented by streamOut
sub writeCSV
{
	my $self = shift;

	my $fh = $self->streamOut;
	my $data = $self->dataObj;
	
	my $csv = Text::CSV_XS->new ({binary => 1, auto_diag => 1, eol => $/, quote_space => 0 });
	open my $io, ">", $fh or die "$fh: $!";
	
	foreach my $row (@$data) {
		$csv->print($io, $row);
	}
}

1;
