# benchmark.t

use strict;
use warnings;
use Test::More;
use Benchmark 'cmpthese';
use File::Slurp::Fast;
use File::Slurp 'read_file';

my $FILE  = $ARGV[0];
my $scan  = File::Slurp::Fast->new( path => $FILE );
my $count = 1000;

sub in_memory {
    my $line_nr = shift;
    my @lines   = read_file($FILE);
    return $lines[$line_nr];
}

cmpthese(
    $count,
    {   'File::Slurp'       => sub { in_memory(10) },
        'File::Slurp::Fast' => sub { $scan->slurp_line(10) },
    }
);

done_testing;
