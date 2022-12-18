#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

my(%g);

my(@pos);

my($start);

while(<DATA>){
  my($v,$r,$vs) = $_ =~ /Valve\s([A-Z]{2}).+=(\d+).+valve.?\s(.*)/;
  $start = $v unless defined $start;
  my(@routes)=split(', ',$vs);
  my($point)={
    id => $v,
    rate =>$r,
    state => 0,
    routes =>\@routes,
    visited => 0
  };

  $g{$v}=$point;
  if($r>0){
    push(@pos,$v);
  }
}

push(@pos,$start);

my(%distances);

# build an N x N dict of the distances between possible valves

foreach(@pos){
  my($r)=$_;
  $distances{$r}={};
  foreach(@pos){
    my($c)=$_;
    my($d)= findRoutes($r,$c);
    $distances{$r}{$c}=$g{$c}->{distance};
    $distances{$c}{$r}=$g{$c}->{distance};
  }
}

print "lenght $#pos\n";
my($strlength)=3*$#pos;

my($max)=0;
add(pop @pos );

my(%used);

# hacky brute force ... but gets there in about 10 minutes.
sub add{
  my($str)=shift;
  foreach(@pos){
    my($k)=$_;
    if(! exists $used{$k}){
      $str .=",$k";
      $used{$k}=1;
      if(length($str)<$strlength){
        add($str);
      }else{
        my(@s)=split(/,/,$str);
        my($s,$t)=totalise(\@s);
        if($s>$max){
          print "$s , $t,  $str\n";
          $max = $s;
        }
      }
      delete $used{$k};
      $str = substr($str, 0, -3);
    }
  }
}

sub totalise{
  my($a)=shift;
  my($start)=shift @{$a};
  my($t)=1;
  my($l)=0;
  my($total)=0;

  while($t<=30){
  if($#{$a} >= 0){
    my($to)=shift @{$a};
    my($dist) = $distances{$start}{$to};
    my($score) = (30-$t-$dist)*$g{$to}->{rate};
    $t += $dist;
    $l = $t;
    $total += $score;
    $start = $to;
  }
  $t++;
 }
 return ($total,$l);
}

#BFS shortest path
sub findRoutes{
  my($start,$to)=@_;
  my(@q);
  $g{$start}->{distance}=0;
  foreach(keys %g){
   $g{$_}->{visited}=0;
  }
  unshift(@q,$start);
  while($#q >=0){
    my($v)=shift(@q);
    if($v eq $to){
       return $v;
    }else{;
      foreach(@{$g{$v}->{routes}}){
        my($w)=$_;
        # check we didn;t process this location already
        unless($g{$w}->{visited}){
              $g{$w}->{visited} = 1;
              $g{$w}->{distance}=$g{$v}->{distance}+1;
              push(@q,$w);
        }
      }
    }
  }
}


__DATA__
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II