#!/usr/bin/perl

use warnings;
use strict;

my($start)= time;

my($search)=4000000; # max search in X or Y

my(@sensors);

while(<DATA>){
  my($x,$y,$bx,$by) = $_ =~ /(\d+)/g;
  my($rad)= abs($x-$bx)+abs($y-$by);
  push(@sensors, {
    x => $x,
    y => $y,
    bx => $bx,
    by => $by,
    rad => $rad,
  });
}

# Walk round the edge of each diamond, the beacon must lie on the edge of a diamond and not be covered by any diamond
foreach(@sensors){
  my($s)=$_;
    for(my $i=0;$i<=($s->{rad}+1);$i++){
      # these are the vertices, duplication at the corners, but don't really care
      check($s->{x}+$i, $s->{y}-($s->{rad}-$i+1));
      check($s->{x}-$i, $s->{y}-($s->{rad}-$i+1));
      check($s->{x}+$i, $s->{y}+($s->{rad}-$i+1));
      check($s->{x}-$i, $s->{y}+($s->{rad}-$i+1));
    }
}

sub check{
  my($x,$y)=@_;
  if($x>$search || $y>$search || $x<=0 || $y<=0){
    return;
  }
  if(notCovered($x,$y)){
    #check the surrounding pixels
    my($adjacent)=0;
    foreach(([0,1],[0,-1],[1,0],[-1,0])){
      my($inc)=$_;
      my($bx)=$x+$inc->[0];
      my($by)=$y+$inc->[1];
      $adjacent += notCovered($bx,$by);
      last if $adjacent;
    }
    if($adjacent==0){
      print "Found!  $x,$y\n";
      print "Freq is: ". ($x*$search+$y)."\n";
      my $duration = time - $start;
      print "Execution time: $duration s\n";
      exit 1;
    }
  }
}

sub notCovered{
  my($x,$y)=@_;
  foreach(@sensors){
    my($s)=$_;
    my($rad)= abs($x-$s->{x})+abs($y-$s->{y});
    if($rad <= $s->{rad}){
      return 0;
    }
  }
  return 1;
}

__DATA__
Sensor at x=2983166, y=2813277: closest beacon is at x=3152133, y=2932891
Sensor at x=2507490, y=122751: closest beacon is at x=1515109, y=970092
Sensor at x=3273116, y=2510538: closest beacon is at x=3152133, y=2932891
Sensor at x=1429671, y=995389: closest beacon is at x=1515109, y=970092
Sensor at x=2465994, y=2260162: closest beacon is at x=2734551, y=2960647
Sensor at x=2926899, y=3191882: closest beacon is at x=2734551, y=2960647
Sensor at x=1022491, y=1021177: closest beacon is at x=1515109, y=970092
Sensor at x=1353273, y=1130973: closest beacon is at x=1515109, y=970092
Sensor at x=1565476, y=2081049: closest beacon is at x=1597979, y=2000000
Sensor at x=1841125, y=1893566: closest beacon is at x=1597979, y=2000000
Sensor at x=99988, y=71317: closest beacon is at x=86583, y=-1649857
Sensor at x=3080600, y=3984582: closest beacon is at x=3175561, y=4138060
Sensor at x=3942770, y=3002123: closest beacon is at x=3724687, y=3294321
Sensor at x=1572920, y=2031447: closest beacon is at x=1597979, y=2000000
Sensor at x=218329, y=1882777: closest beacon is at x=1597979, y=2000000
Sensor at x=1401723, y=1460526: closest beacon is at x=1515109, y=970092
Sensor at x=2114094, y=985978: closest beacon is at x=1515109, y=970092
Sensor at x=3358586, y=3171857: closest beacon is at x=3152133, y=2932891
Sensor at x=1226284, y=3662922: closest beacon is at x=2514367, y=3218259
Sensor at x=3486366, y=3717867: closest beacon is at x=3724687, y=3294321
Sensor at x=1271873, y=831354: closest beacon is at x=1515109, y=970092
Sensor at x=3568311, y=1566400: closest beacon is at x=3152133, y=2932891
Sensor at x=3831960, y=3146611: closest beacon is at x=3724687, y=3294321
Sensor at x=2505534, y=3196726: closest beacon is at x=2514367, y=3218259
Sensor at x=2736967, y=3632098: closest beacon is at x=2514367, y=3218259
Sensor at x=3963402, y=3944423: closest beacon is at x=3724687, y=3294321
Sensor at x=1483115, y=2119639: closest beacon is at x=1597979, y=2000000