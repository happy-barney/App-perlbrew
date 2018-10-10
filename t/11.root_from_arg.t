#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib $FindBin::Bin;
use App::perlbrew;
require "test_helpers.pl";

use File::Temp qw(tempdir);
use Test::Spec;

describe "App::perlbrew#root method" => sub {
    it "should return \$App::perlbrew::PERLBREW_ROOT normally" => sub {
        my $app = App::perlbrew->new;

        is $app->root, $App::perlbrew::PERLBREW_ROOT;
    };

    it "should return the instance property of 'root' if set" => sub {
        my $app = App::perlbrew->new;
        $app->root("/fnord");

        is $app->root, "/fnord";
    };
};

describe "App::perlbrew->new" => sub {
    it "should accept --root args and treat it as the value of PERLBREW_ROOT for the instance" => sub {
        my $temp_perlbrew_root = tempdir( CLEANUP => 1);

        my $app = App::perlbrew->new("--root" => $temp_perlbrew_root);

        is $app->root, $temp_perlbrew_root;
    };
};

runtests unless caller;
