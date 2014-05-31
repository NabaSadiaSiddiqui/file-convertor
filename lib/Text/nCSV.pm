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

# read the csv data from streamIn
# and return it as an array reference where each element is an array reference itself
sub readCSV
{
	my $self = shift;

	my $fh = $self->streamIn;

	my $csv = Text::CSV_XS->new ({binary => 1, auto_diag => 1 });
	open my $io, "<", $fh or die "$fh: $!";

	my $data = $csv->getline_all($io);

	$data;
}

sub writeCSV
{
	my $self = shift;
}

1;
