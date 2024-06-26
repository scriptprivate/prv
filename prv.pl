#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use Term::ReadLine;
use Try::Tiny;

sub main {
    my $keep_ext = 0;
    my @filters;

    GetOptions(
        'k|keep' => \$keep_ext,
        'f|filter=s{1,}' => \@filters
    );

    my $dir = shift @ARGV || '.';

    opendir(my $dh, $dir) or die "\nCan't open directory '$dir': $!\n\n";
    my @files = grep { $_ ne '.' && $_ ne '..' } readdir($dh);
    closedir($dh);

    if (@filters) {
        @files = grep {
            my $file = $_;
            grep { $file =~ /\Q$_\E$/ } @filters
        } @files;
    }

    my $term = Term::ReadLine->new('file_rename');
    my $OUT = $term->OUT || \*STDOUT;

    print $OUT "\nCurrent files in directory '$dir':\n\n";
    unless (@files) {
        print $OUT "\nNo files found with the specified extensions.\n\n";
        return 1;
    }
    
    print $OUT join("\n", @files) . "\n";
    print $OUT "\nType the new names, one per line. Leave blank to keep the same name.\n\n";

    my @new_names;

    foreach my $file (@files) {
        my $new_name = $term->readline("$file -> ");
        if ($keep_ext) {
            my ($name, $ext) = $file =~ /^(.*?)(\.[^.]+)?$/;
            $new_name .= $ext if $new_name && $ext;
        }
        push @new_names, $new_name || $file;
    }

    for my $i (0..$#files) {
        if ($files[$i] ne $new_names[$i]) {
            try {
                rename("$dir/$files[$i]", "$dir/$new_names[$i]") or die "Failed to rename $files[$i] to $new_names[$i]: $!";
            } catch {
                warn "Failed to rename $files[$i] to $new_names[$i]: $_";
            };
        }
    }

    print $OUT "\nRenaming complete.\n\n";
}

exit main(@ARGV);
