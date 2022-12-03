#!/usr/bin/perl

use warnings;
use strict;

my($score)=0;

my($opp)={
 A => { X=>3, Y=>6, Z=>0 },
 B => { X=>0, Y=>3, Z=>6 },
 C => { X=>6, Y=>0, Z=>3 },
 S => { X=>1, Y=>2, Z=>3 }
};

my($play)={
 A => { X=>'Z', Y=>'X', Z=>'Y' },
 B => { X=>'X', Y=>'Y', Z=>'Z' },
 C => { X=>'Y', Y=>'Z', Z=>'X' },
};

while(<DATA>){
  my($a,$b)= $_ =~/(\w)\s(\w)/;
  $score += $opp->{$a}->{$play->{$a}->{$b}} + $opp->{S}->{$play->{$a}->{$b}};
}
print $score;

__DATA__
C Z
B Y
C X
B Z
C Y
B Y
C Z
C Z
B Y
B X
C Y
B Y
B Z
A Z
A Y
B X
C Y
C Z
B Z
A Y
C Y
C Z
A Y
C Z
B X
B Y
B Y
A Y
C Z
B Y
B Y
B Y
C Z
C Y
B X
C Y
A Z
C Y
B X
B Z
C Z
C Z
B X
A Y
A Y
C Z
C Z
C Z
B Y
C Y
B Y
C Z
C Z
A Z
B Y
C Y
B X
A Y
C Y
B Y
C Z
A Y
B Y
B Y
B Y
B Z
C Y
A X
C Y
B Y
C Z
A Z
B X
C Z
C X
A Y
C Y
B Z
C Y
C Z
B X
C Z
C Y
B Y
B Y
B Y
B Y
A Y
C Z
C Z
B Y
B Y
C Z
B Z
B Y
B Y
B Y
A Y
B Z
B Y
C Y
B X
B Y
B X
C Z
B X
C Y
B Z
C Z
C Z
B Y
B Z
C Z
B X
C Y
B Y
C Y
C Z
C Y
B Z
C Z
B X
B Y
C Y
B X
B Z
B Y
C Y
B X
C Y
C Z
B Y
B Y
B X
C Y
C Z
C Z
B X
C Y
C Z
B Y
B Z
C Y
C Y
C Z
C Y
C Z
B Y
B Y
C Z
C Y
C Y
C Y
B Y
B Y
A Y
C Z
B X
B Y
C Z
C Z
C Z
B Y
B Z
C Y
C X
B Y
C Z
C Z
B Y
C Z
C Z
C Z
B Z
C Y
B Y
B X
C Z
B X
B X
B Y
C Z
B X
C Z
B Z
C Z
B X
A Y
B X
A Y
A Y
A Z
C Y
B Z
B Z
B X
C Y
C Y
B Y
C Z
B X
C Z
B Y
B Z
C Z
C Z
B Y
C Y
B Y
C Y
A Y
C Z
C Y
C Y
B Y
B Z
C Y
B X
B Z
A Z
C Y
B X
B Y
B Y
B Y
B Z
C Z
A X
B Z
B X
C Y
B Z
B Y
A Y
C Z
B X
C Z
B Z
C Z
B Y
C Z
C Y
B X
C Z
C Y
B Y
C Z
C Y
C Z
C Y
B Z
A Y
B Y
B X
C Y
A X
C Z
A Y
C Z
B Y
C Z
B Y
C Z
B Y
B Y
B Y
B Y
A Y
C Z
B Y
A Z
B Z
C Y
B Y
B Z
A Y
C Z
B Y
B Y
C Z
A Z
B X
A Y
C Z
B Z
B Z
B Y
B X
A Y
B Y
A X
C X
B Z
B Y
C Y
C Z
C Y
C Z
B Y
B Z
C Y
A Z
C Y
C Y
C Y
A Z
C Y
C Z
C Z
C Z
C X
B Y
B Y
C Y
C Z
C Y
B Y
C Y
C Z
C Z
B Z
B Y
B Y
B Y
C Z
C Y
B X
C Y
B Z
B Y
B Y
B Y
C Y
C Y
C Z
C Z
C Y
B X
C Y
B Y
B Z
B Z
B Z
C Z
B X
C Y
C X
C Y
B X
C Z
A Y
A Y
B X
C Z
A Z
C Y
C Z
A Y
C Z
B Y
B Y
C Y
B Y
C Y
B Y
C Y
B Y
C Y
C Y
B Y
C Z
B Z
C Y
A Y
C Y
A Y
B X
C Y
A Y
B Z
B Y
C Y
B Y
C Y
B Y
C Y
C Z
C Y
C Z
B Y
C Y
C Z
B Y
B Z
C Y
A Y
C Z
C Z
C Z
B Z
C Y
A Y
B Z
A Y
B Y
C Y
C Z
C Y
A Y
B X
A Z
C Z
C Y
B X
C Z
A X
C Z
C Y
C Z
B Y
C Y
C Y
B Y
C Y
C Z
C Y
C Y
C Y
A Y
C Z
C Y
C Z
C Z
B X
A Y
B X
B Y
A Y
B Y
A Y
C Z
A Y
C Y
C Y
B Y
C Y
B Z
C Y
C Z
B Z
B Y
B X
B Y
B Y
C Y
C Y
B Y
B X
C Z
B X
B X
A Y
B Z
B X
A Y
C Y
C Y
B X
B Z
C Y
B Y
B X
B X
C Y
C Z
B Y
B Y
B Y
A Y
A Y
C Z
C Z
C Y
B X
C Y
C Y
B Z
B Z
A X
C Y
C Y
A Z
A Y
B X
B Y
C Y
B Y
C Z
B Y
C Y
B Y
C Z
C X
C Z
A Z
B X
A Z
C Z
B Y
C Y
B Z
C Y
B X
C Y
C Z
B Y
A Y
C Y
C Y
B Z
B Y
B X
C Z
B Y
C Y
C Y
C Y
A Z
B Y
B Y
C Y
B Y
C Z
B Y
C Y
B Y
C Z
B X
C Y
B Y
B X
C Y
C Z
C Y
B X
B Y
C Y
B Z
B X
C Y
B X
B Y
B Z
C Y
B Y
C Y
B Y
B Y
C Y
B Z
B Y
C Z
C Z
B X
A X
C Z
B Z
B Y
B X
C Z
C Z
B Z
A Z
B Y
C Y
C Z
C Y
C Y
C Y
C Z
B Y
B Y
C Y
C Z
C Z
C Y
C Y
C Z
B Y
C Y
B Y
B Y
A Y
C Y
A Y
C Z
C Y
C Z
C X
B X
C Z
A Y
B X
C Z
C Z
C Y
B Z
B Y
A Y
C Z
B X
B Y
B Z
B X
C Y
B Y
C Z
C Z
C Z
C Y
A Y
C Z
C Z
B Y
B Y
B Y
C Y
C Y
C Z
B X
C Y
C Y
C Y
B Y
C X
B Y
B Y
C Y
A Z
C Y
C Z
A Y
C Y
B Z
C Y
C Z
A X
B X
C Z
C Y
B Y
C Y
C Y
B Y
C Z
C X
C Y
C Y
B X
C Y
B Y
C Y
C Z
A Z
B X
B X
C Z
C Y
B Y
B Z
B Y
B Z
A X
B X
B X
B X
C Y
A X
C Z
C Z
B Y
B X
B Y
B Y
C Z
B Z
C Y
C Y
B X
B Z
C X
A X
B Y
C X
C X
B Y
C Z
C Z
C Z
B X
B Z
C Y
B Y
A Y
C Z
B Z
A Z
B X
B X
B X
B Y
B X
B X
B X
B Y
C Z
C Y
C Y
C Y
A Y
C Z
C Y
C Z
C Y
B Y
A X
A Z
A Z
C Z
B Z
B Z
B Y
C Z
B Y
B X
B Y
B Z
A Y
B Y
B Y
B Z
C Y
B Y
C Y
B Y
C Y
B Z
C Z
B Z
C Y
B Z
B Y
B Y
A Y
C Z
B Y
B X
B Y
B X
C Z
C Y
B Z
C Z
C Z
A Z
C Z
B X
C Z
C Z
C Z
C Y
B Y
B X
C Y
C Y
C Z
C Z
B X
C Y
C Z
B Z
A Y
A Y
B Y
C Y
B Z
A X
C X
C Y
A Y
B Z
B X
C Z
C Y
B Y
C Z
C Y
B Z
C Z
C Z
C Y
B X
C Z
C Y
B Y
C Y
C Y
C Z
B X
C Y
C Z
C Z
C Y
C Y
B Y
C Y
B X
C Z
B Z
B X
A Z
C Z
B Z
C Z
C Y
B X
C Z
A Z
A Y
A Y
C Y
B Y
B X
C Y
C Z
B X
A Y
B Y
B X
B X
C Y
B Y
C Y
C Z
B Y
B X
C Y
B Y
B X
A Y
B Y
B Y
C Y
A Y
B Y
A Z
C Z
A X
C Z
C X
C Z
C Z
C Y
B Z
B Z
A Z
A Y
B Y
B Y
C X
C Z
C Z
B Z
A X
C Y
C Z
A Y
A Y
B X
C Z
B Z
A X
C Z
C Y
B X
C Y
C Y
C Z
C Z
B X
C Z
A Y
B Y
B X
B Y
C Y
B X
C Y
B Y
A X
C Z
C Y
C Z
B Z
C Y
C Y
C Z
C Z
A Y
C Z
B Y
C Z
C Y
B Y
C Y
A Y
C Y
A Z
C Y
A Z
C Z
C Z
B Y
C Z
C Y
A Y
C Y
A Y
C Z
B Z
B Y
B Z
C Z
B Y
A Z
B Y
C Z
A Y
B Y
A Z
B X
B Z
B X
B Y
B Y
B Y
C Y
C Z
B Y
C X
B Y
A X
B Y
B Y
C Z
C Z
A X
C Z
C Y
C Z
B Y
B Y
B X
B X
A X
B X
B Y
B Y
C Z
B Z
B Y
B Y
B Z
B Y
C Z
C Z
B X
B Z
A Z
B Z
C Z
B Z
C Y
C Z
C Z
B X
C Y
C Y
B X
B Y
C Y
B Y
C Z
C Y
B Y
B X
A Z
C Z
C Y
C Y
B Z
B X
A Z
B Z
C Z
C Z
B X
B X
C Z
C Y
B Z
C Z
C Z
B X
C Y
C Y
B Y
C Y
B Z
C Z
A Y
B X
C Y
C Z
B Y
B X
B X
A Z
B Y
B Y
C Z
B X
A Y
A X
C Y
B Z
B X
A Y
B Y
B X
C Z
C Z
C Z
C Z
C Z
A Y
C Y
C Z
C Y
C Z
C Y
A Y
B Y
C Y
C Y
B Y
C Z
A X
B Y
C Y
C Z
B Y
C Z
B Y
A Z
B X
B X
A Y
B X
C Y
B Z
B Y
B Z
C Y
A Y
C Z
A Y
A Y
C Z
C Z
C Y
B X
A Y
C X
C Y
C X
C Z
B Y
B Y
C Z
B X
B Y
C Z
B X
C Z
C Z
B Y
A Y
B X
B Y
C Z
B Y
C Z
A Y
B X
C Z
C Y
A Y
C Z
A Y
C Y
A Y
C Z
B X
B Y
B Z
A Y
C Z
C Y
C Z
B Z
C Z
C Y
C Y
B Z
C Z
C Y
B X
B Y
A Y
A Y
B X
C Y
C Y
C Z
B Y
B Z
B X
B Y
B Y
B Z
B Y
B Y
B Z
B Y
B X
C Y
C Y
C Z
B X
C Z
C Y
A Y
C Y
C Z
B Y
A Z
C Y
C Z
B X
A Y
C Y
C Y
C Y
A Y
A Y
C Y
B X
C Z
A Y
C X
B Y
C Y
B Y
C Y
B Z
C Y
A Z
B Y
A Y
A Y
B X
B Y
B Y
B Y
C Y
B Z
C Z
B X
B X
B X
C Y
B X
C Z
B Z
C Z
B Y
C Y
C Z
C Y
C Y
B Y
B Y
B Z
B Y
C Z
B Y
B X
C Z
A Z
C Y
C Y
C Z
B Y
A Y
C Z
C Y
B Z
C Z
B Y
B Z
B X
C Y
B X
C Z
B Z
C Z
C Z
B Y
B X
B X
C X
C Z
C Z
A Y
C Z
C Y
C Y
C Y
C Z
C Y
B X
B X
B X
C X
C Y
B X
B X
B X
B Z
A Z
B X
C Y
B Y
C Z
A Z
B Y
B X
B Z
C Y
B Z
B Y
A Z
C Z
B Y
C Y
B Y
B X
C Y
A Z
C Z
C Y
B Y
B X
C Y
C Z
C Y
C Z
B Y
A Z
B Y
B X
C Y
C Y
A X
B X
C Y
C Z
A Z
C Z
C Y
C Z
B Y
B Y
C Z
A Y
C Z
B X
B X
B Y
B Y
B X
B X
B X
B Z
B X
A X
A Y
C Z
C Y
A Y
C Y
C Z
C Y
B Y
C Z
A Y
B X
B X
C Y
C Y
B Z
B Z
B Z
B Y
B Y
B Y
B Y
C Y
C Z
B Z
A Y
B Z
C Y
C Y
C Z
B X
A Y
C Y
B X
B Z
A Y
C Y
C Z
A X
C Z
B X
B X
B Z
A Y
C Z
B Z
C Z
A Y
A Y
B Y
B Y
A Y
C Y
A Y
B X
C Y
C Z
B Y
B Z
C Z
C Y
B Y
C Y
C Z
B Y
C Z
C Y
A Y
C Y
C Y
B X
C Y
B Y
B Y
B X
C Z
B Y
C Y
C Y
B Y
B Y
B Z
C Y
C Z
A X
C Z
C Y
C Y
C Y
B Z
C Y
C Y
C Y
A Y
C Y
A Y
C Y
C Y
C Y
C Y
C Y
C Y
A Z
B Z
B Y
C Z
B Y
C Z
B Y
C Z
B Y
C Z
C Z
C Z
C Y
C Z
B Y
B Y
C Y
C Z
B Z
C Y
A Y
C Y
C Z
C Y
C Y
A Z
B Y
C Y
B X
B Y
C Y
C Z
B Y
C Y
B X
B X
B Y
C Y
B Z
B Y
A Y
B Y
B Y
B X
C Z
B Z
B X
C Z
A Z
B Z
C Y
C Z
C Y
B X
C Y
C X
B Z
C Y
C Y
B Y
C X
B Y
C Z
A Z
C X
A Y
B Y
B Y
C Z
C Z
B Y
B Y
B Z
C Z
C Y
C Z
B X
A Z
C Y
C Y
B Z
B X
B Y
B X
A Z
C Y
B Y
C Z
A Y
B Z
C Y
B X
B X
B Y
B Y
B Z
B X
C Z
C Y
B X
B X
B X
B Y
B X
B X
B Y
B Y
B Y
C Y
A Z
C Z
C Y
B Y
B Y
B Z
C Z
C Y
C X
B Z
A X
C Y
B X
B Y
C Y
A X
C Y
C Y
B Y
B Y
B Y
A Z
C Y
C Y
A X
C Y
A Z
C Z
B X
A Y
C Z
B Z
B Y
B Y
C Y
B Y
C Z
B X
C Z
B X
A Y
C Z
C Y
B X
B Z
B Y
B X
C Y
C Z
C Z
A Z
B Z
B Z
C Z
C Y
C Z
C Y
B Z
B Y
B Y
C Y
C Z
C Y
C Y
C Z
A Y
B Y
A Z
B Z
C Z
B X
A Y
B Y
C Y
C Z
A Y
C Y
B Y
B X
C Y
B Y
C Y
A Y
C Y
B Y
B Z
C Z
B X
B X
C Z
C Y
C Z
B Y
C Y
B Y
B Y
C Z
C Y
A Z
B Z
B X
C Z
C X
C Z
B X
C Z
C Y
B X
B Y
B Y
C Z
C Z
C Z
B Y
B Y
A X
B X
C Z
C Y
C Z
B Y
C Y
B Y
C Y
C Z
C Z
C Y
C Y
B X
B Y
B Y
C Y
B Y
A Y
B Y
B Z
C Z
C Z
A Z
C Z
B Z
B Y
C Z
B Y
B X
B Y
A Y
A Y
B Y
C Y
B Z
B Y
B Y
B Y
B X
B X
B X
B Z
B Z
C Z
A X
C Z
B Y
C Z
A Y
C Z
C Y
A Y
B Z
B Y
C Z
B Y
B X
B Z
C Y
C Z
C Z
C Y
B X
B X
C Y
C Y
A Y
C Y
B Y
C Y
C Y
C Y
B X
C Z
B Y
C Z
B Y
B Y
A Y
B Y
C X
B Y
C Y
B Y
C Z
C Y
B X
B Y
C Y
B Y
B Z
B X
C Z
A X
C Y
C Y
B X
B Z
B X
C Y
C Y
A Y
B Y
C Y
C Z
B Y
B Y
B Z
A Y
B Z
B X
B Z
C Y
B Y
C Y
C Y
B X
B Y
A Y
C Y
C Z
C Y
B X
B X
C Y
B Y
A Z
C X
C Z
B Y
C Z
C Y
C Z
C Y
A Z
B Y
C Y
B Z
B Y
B X
B Y
B X
C Z
C Y
B Y
C Y
C Z
C Z
B Y
B X
C Y
C Y
B Y
B X
C Z
B X
C Z
C Y
B Y
C Y
C Z
C Y
B Y
C Z
A Z
A Y
C Y
A Y
C Y
B Y
B Y
B Y
C Y
C Z
C Y
C Y
B X
B X
C Y
B X
C Y
A Y
B Y
B Y
C Z
C Z
B X
C Z
C Z
B Y
C Z
C Z
B Z
B Z
C Y
A Z
C Z
C Z
B X
C Z
B Z
B Y
A Y
B X
B Z
A Y
B Y
B Y
B X
B Y
C Y
A Z
B Y
C Y
A Y
C Y
B Y
C Y
C Y
A Y
C Y
B Y
B Y
B Z
C Z
C Z
C Y
B Y
C Y
B Z
B X
C Y
C Y
B Y
B Z
B Y
A Y
A Y
A Z
C Y
B Y
B Y
C Z
C Z
C Y
C Z
C Y
B X
C Z
C Y
C Y
A Y
B Z
C Z
A Y
B Z
B Y
B Y
B Y
B Y
C Y
C Y
A Y
C Z
C Z
A Z
B Y
B X
B Z
A Z
C Z
B X
B Y
A X
C Y
B Z
A Y
C Z
C Y
A Y
B X
C Y
B X
C Z
B X
B Y
B X
A Z
B Y
C Z
C Y
B Y
A Y
B X
C Y
B Z
B X
A Z
A Y
C Y
C Z
C Y
B X
C Y
C Z
B Y
A Y
C Y
C Z
C X
B Y
C Y
B X
B Z
B Y
C Z
C Z
C Y
B X
C Y
B Z
C Z
C Y
C Y
C Y
C Z
C Y
B Y
C Y
A Y
C Y
B X
B Y
A X
B Y
B Y
B Y
A Y
B X
B Z
B Z
C Z
A Z
C X
B Z
B Y
C Y
C Z
B Z
B Y
B X
C Y
C X
C Y
C Z
A X
B X
B Y
B Y
C Z
B X
B Z
B X
B X
B Y
C Y
B Y
B Z
C Y
C Y
B Z
B Y
C Y
C Y
C Z
C Z
C Z
B Y
B Z
C Y
A Z
C X
B Y
C Y
C Y
B Y
C X
C Y
B Y
C Y
B Y
B Y
C Y
C Z
C Z
C Z
C Z
B X
C Z
C Z
B Y
C Y
A Z
B X
C Z
B Z
C Y
C Y
B Y
B Y
B Z
C Y
B Z
C Z
B Y
C Z
C Z
B X
B Z
C Y
C Y
C Z
B X
C Z
B X
C Y
C Y
B X
C Z
C Z
B Y
C Z
B Y
B Y
C Y
C Y
B Y
C Y
B Y
A Z
B Y
B Y
B Z
C Y
B Z
B Y
C Y
B X
B Z
B Z
C Y
C Z
C Z
B Z
C Y
B Y
C Z
B X
B X
C Z
B X
C Y
B Y
C Y
C Z
C Z
C Y
C Z
B Z
C Y
C Z
C X
B Z
B Y
A Z
C Z
A Y
C Z
B Z
B X
C Y
B X
C Y
C Z
C Z
B Y
B Y
B X
C Y
C Z
B X
C Y
C X
C Y
C Y
C Z
C Z
B X
C Z
B Y
C Y
B Y
B Y
B Y
B Z
C Z
A Y
B X
A X
A Z
C Z
A Z
B Z
C X
B Z
B X
B Y
B X
C Y
C Z
C Y
B X
B Y
B X
B Y
A Y
C Z
B Y
C X
B Y
B Y
A Z
B Y
C Z
C Z
A Z
C Y
B Z
C Y
B Y
A Y
A Z
B Y
B Z
B X
B Y
B Y
C Y
C Z
A Y
C Z
A Y
C Z
C Y
C Y
B Y
B Z
C Y
C Z
B Y
C Y
C Y
B X
B Y
C Z
C Z
C Y
B Z
B Y
C Z
B X
C Z
B Z
C Y
C Y
C Y
C Z
B Y
C Y
C Y
B Y
C X
C Z
B Y
C Z
A Y
C Y
C Y
C Z
C Y
C Z
B Z
B Y
C Z
C Z
C Y
B X
B Y
C Z
B Y
C Z
C Z
B Y
C Y
B X
B Y
A Y
B X
C Z
B Y
C Z
C Y
C Z
B X
B Y
C Y
C Z
C Y
B Y
B Z
B X
B Y
C Z
C Z
C Z
B Z
C Y
C Z
B Z
C Z
A Y
C Z
B X
B Z
C Y
C Z
C Y
B Z
B Y
C Y
B Z
A Y
B X
C Y
C Y
B Y
B Y
C Y
C X
B Z
B X
C X
C Y
B Z
C Z
A Y
B Z
B Z
B Z
B X
B Y
B X
C Z
C Z
A Z
B Z
C Z
C Z
B X
A Y
C Y
B Y
B Y
B Y
B Y
B Y
C Z
C Y
C X
C Y
B Y
B Y
C Y
C Z
B Y
A X
A Y
B X
A X
C Y
C Z
C Z
B Y
B Z
A Y
A Y
C Y
B Z
C Z
C Y
B Y
C Y
B X
B X
B X
C Z
B Y
C Y
B Z
C Z
A X
A Y
C Y
B Y
B Y
A Z
B X
C Z
C Z
B X
C Z
C Z
C Z
C Y
C Z
B X
B X
C Y
B Z
A Y
C Z
B Y
C Z
C Y
A Y
C Z
A Z
C Z
B Z
A Y
A Y
C Z
B Y
C Y
C Z
C Z
B Y
C Z
C Z
C Z
B Z
C Y
C Y
B Y
C Y
C Z
A X
C Z
C Z
C Y
C Z
B Y
C Y
B Y
A Y
C Y
A Y
B Y
B Y
C Z
C Z
C Z
B X
B Y
B Y
C Y
C Z
C Y
B X
B Y
C Y
C Z
C Z
C Z
A Y
C Y
C Z
B X
C Y
C Z
A Y
B Y
C Y
C Y
A X
C Z
B Z
B X
C Z
C Y
B Y
B Y
C Y
A Y
B Y
B Y
C Y
B X
C Z
C Z
C Y
C Y
B Y
C Z
C Y
C Z
C Z
C Z
B Y
C Z
B Y
B Y
B Y
B X
A Y
C Y
C Y
B X
B X
C Z
B X
C Z
B X
B Y
C Z
B X
B Y
C Z
B X
B Y
C Y
B Y
B Y
C X
B Y
B Y
B X
C Y
C Y
A Z
B Y
C Y
B Z
B X
B X
A Y
A Y
B Z
B X
B X
C Y
C Y
C Y
B Y
C Y
B Y
A Y