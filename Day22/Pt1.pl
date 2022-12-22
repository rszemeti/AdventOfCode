#!/usr/bin/perl

use warnings;
use strict;



use Data::Dumper;

my %n;

while(<DATA>){
 chomp;
  my($line)=$_;
  if($line =~ /^\w+:\s\d+$/){
    my($key,$val)= $line =~ /^(\w+):\s(\d+)$/;
    $n{$key}={ val => $val };
  }else{
    my($key, $val1, $op, $val2) = $line =~ /^(\w+):\s(\w+)\s([\+\-\*\/\=])\s(\w+)$/;
    $n{$key} = { val1 => $val1, val2 => $val2, op => $op };
  }
}




__DATA__
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5