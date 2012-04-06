#!/usr/bin/perl

=head1 NAME

pdf-rotate.pl

=head1 SYNOPSIS

pef-rotate.pl filename.pdf angle

=head1 DESCRIPTION

Rotate the pages in the PDF file.

The program dies with a help message if the specified file does
not exist or the angle is not a positive number between 1 and 359
inclusively (to rotate 0 or 360 degrees, do not use this program).

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All rights reserved

You may use this software under the same terms as Perl itself.

=cut

my( $file, $angle ) = @ARGV;

unless( -e $file and 
	$angle > 0 and $angle < 360 and int($angle) == $angle )
	{
	die <<"USAGE";
$0 filename angle
	filename - path to PDF file to convert
	angle    - integer from 1 to 359
USAGE
	}
	
use Text::PDF::File;
use Text::PDF::Utils;

$pdf   = Text::PDF::File->open( $file, 1 );    

$pages = $p->read_obj( $r->{'Pages'} );

$pages->{'Rotate'} = PDFNum( $angle );

$pdf->out_obj( $pages );

$pdf->append_file;
