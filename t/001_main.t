# 001_main.t

use strict;
use warnings;
use Test::More;
use File::Spec;
use File::Basename 'dirname';
use utf8;

use File::Slurp::Fast;

my $dir = File::Spec->rel2abs( dirname(__FILE__) );
my $txt_file = File::Spec->catfile( $dir, 'data', 'somefile.txt' );


my @lines = (
    'This is a first line',
    'and', 'a ', 'fourth.', "some utf8 ★ ", '', 'A line after an empty one.',
);

my $file = File::Slurp::Fast->new( path => $txt_file );

my $count = 0;
foreach my $line (@lines) {
    is $file->slurp_line( $count++ ), "$line\n", "got expected line $count";
}

done_testing;
