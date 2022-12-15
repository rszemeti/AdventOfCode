#!/usr/bin/perl

use warnings;
use strict;

my @map;
my(@line);
my($lineNo)=2000000;

# Offsets lest we have -ve indices
my($o)=[0,0];


my($minX,$minY);
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
    line => $.
  });
  
  if(! defined $minX){
    $minX = $x-$rad;
    $minY = $y-$rad;
  }else{
    $minX=$x-$rad if( $minX > $x-$rad );
    $minY=$y-$rad if( $minY > $y-$rad );
  }
}

$o->[0]= -1*$minX;
$o->[1]= -1*$minY;
$lineNo-=$minY;

foreach(@sensors){
  # Adjust for offsets
  my($s)=$_;

  $s->{x}  += $o->[0];
  $s->{y}  += $o->[1];
  $s->{bx} += $o->[0];
  $s->{by} += $o->[1];

  if($s->{y}==$lineNo){
    $line[$s->{x}]='S';
  }
  if($s->{by}==$lineNo){
    $line[$s->{bx}]='B';
  }
  
  fill($s->{x},$s->{y},$s->{rad},$s->{line});
}

my($count)=0;

foreach(0..$#line){
  if(defined $line[$_]){
    #print $line[$_];
    $count++ if($line[$_] eq '#');
  }else{
    #print ".";
  }
}

print "\n$count\n";

sub fill{
  my($x,$y,$rad,$l)=@_;
  unless((($y-$rad) <= $lineNo) && ( $lineNo <= ($y+$rad))){
    return;
  }
  my($offset)=abs($y-$lineNo);
  my($width)=$rad-$offset;
  for(my $i=$x-$width;$i<=$x+$width;$i++){
    if(! defined($line[$i])){ $line[$i] ='#' }
  }
  return;
  foreach(([1,1],[1,-1],[-1,1],[-1,-1])){
    my($inc)=$_;
    for(my $mx=$x+$inc->[0]*$rad;$mx!=$x-$inc->[0]; $mx -= $inc->[0]){
      for(my $my=$y+$inc->[1]*($rad-abs($mx-$x));$my!=$y-$inc->[1]; $my -= $inc->[1]){
        if($mx < 0 || $my < 0){
          die "negative extents!!";
        }else{
          if(! defined($map[$my][$mx])){ $map[$my][$mx] =$l }
        }
      }
    }
  }
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