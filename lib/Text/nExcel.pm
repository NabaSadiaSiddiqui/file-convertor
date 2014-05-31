package Text::nExcel;

use strict;
use warnings;

use Moose;
use Excel::Writer::XLSX;
use Spreadsheet::ParseXLSX;

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
# and return it as an array reference where each element is itself an array reference
sub readExcel
{
	my $self = shift;

	my $parser = Spreadsheet::ParseXLSX->new();
	my $workbook = $parser->parse( $self->streamIn );
	my $worksheet = $workbook->worksheet(0);

	my ( $row_min, $row_max ) = $worksheet->row_range();
	my ( $col_min, $col_max ) = $worksheet->col_range();
	
	my @rowArr = ($row_min..$row_max);
	my @colArr = ($col_min..$col_max);

	my @dataArr = map {
		my $row = $_;

		my @row = map { 
			my $col = $_;
			my $cellObj = $worksheet->get_cell($row, $col);
			my $cellVal = $cellObj->value();
		} @colArr;
	
		\@row;
	} @rowArr;

	\@dataArr;
}

# write data passed in the constructor, and saved as dataObj
# to the file represented by streamOut
sub writeExcel
{
	my $self = shift;

	my $workbook = Excel::Writer::XLSX->new( $self->streamOut );

	my $worksheet = $workbook->worksheet();

	$worksheet->write_col('A1', $self->dataObj);
}

1;
