#!/usr/bin/env perl
use strict;
use warnings;

my $skip = 0;
my $fn = "";

while(<>) {
	if(/^diff --git a\/libelf\/(.*?)\s/) {
		$fn = $1;
		if(! -e "src/$fn") {
			$skip = 1;
		} else {
			$skip = 0;
		}
		goto cleanup_path unless $skip;
	} elsif (/^--- a\/libelf\// || /^[+][+][+] b\/libelf\//) {
		cleanup_path:
		s/a\/libelf/a\/src/;
		s/b\/libelf/b\/src/;
	}
	print unless $skip;
}
