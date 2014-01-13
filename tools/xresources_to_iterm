#!/usr/bin/env perl
# -*- coding: utf-8 -*-

use strict;

print <<END;
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
END

while (<>) {
    if (/^[^!]/) {
        if (
/^.*\*(color|background|foreground)(\d*)\s*:\s*#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2}).*$/i
          )
        {
            print "\t<key>";

            my $color_index = $2;

            if ( $color_index ne '' ) {
                print "Ansi $color_index Color</key>\n";
            }
            else {
                my $color_type = ucfirst($1);
                print "$color_type Color</key>\n";
            }

            my %co_val = ( 'Red' => $3, 'Green' => $4, 'Blue' => $5 );

            print "\t<dict>\n";

            while ( my ( $co, $val ) = each(%co_val) ) {
                print "\t\t<key>$co Component</key>\n";
                print "\t\t<real>" . hex($val) / 255 . "</real>\n";
            }

            print "\t</dict>\n";

        }
    }
}

print "</dict>\n</plist>\n";
