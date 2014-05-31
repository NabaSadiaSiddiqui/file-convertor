package Text::nExcel;

use strict;
use warnings;

use Moose;
use Excel::Writer::XLSX;

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

# read the excel data from streamIn
# and return it as an array where each element is an array reference
sub readExcel
{
	my $self = shift;

}

# write data passed in as an array in the function parameter
# to the file represented by streamOut
sub writeExcel
{
	my $self = shift;

	my $workbook = Excel::Writer::XLSX->new( $self->streamOut );

	my $worksheet = $workbook->add_worksheet();

	$worksheet->write_col('A1', $self->dataObj);
}

1;
