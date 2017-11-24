package Data::TableReader::Decoder::XLSX;

use Moo 2;
use Carp;
extends 'Data::TableReader::Decoder::Spreadsheet';

# ABSTRACT: Access sheets/rows of a Microsoft Excel 2003+ spreadsheet

=head1 DESCRIPTION

See L<Data::TableReader::Decoder::Spreadsheet>.
This subclass simply initializes the parser with an instance of
L<Spreadsheet::ParseXLSX>.

=cut

sub _build_workbook {
	my $self= shift;
	
	my $wbook;
	my $f= $self->file_handle;
	if (ref $f and ref($f)->can('worksheets')) {
		$wbook= $f;
	} else {
		require Spreadsheet::ParseXLSX;
		$wbook= Spreadsheet::ParseXLSX->new->parse($f);
	}
	defined $wbook or croak "Can't parse file '".$self->file_name."'";
	return $wbook;
}

1;