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
      if(length($str)<24){
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
Valve AA has flow rate=0; tunnels lead to valves RZ, QQ, FH, IM, VJ
Valve FE has flow rate=0; tunnels lead to valves TM, TR
Valve QZ has flow rate=19; tunnels lead to valves HH, OY
Valve TU has flow rate=17; tunnels lead to valves NJ, IN, WN
Valve RG has flow rate=0; tunnels lead to valves IK, SZ
Valve TM has flow rate=0; tunnels lead to valves FE, JH
Valve JH has flow rate=4; tunnels lead to valves NW, QQ, TM, VH, AZ
Valve NW has flow rate=0; tunnels lead to valves JH, OB
Valve BZ has flow rate=0; tunnels lead to valves XG, XF
Valve VS has flow rate=0; tunnels lead to valves FF, GC
Valve OI has flow rate=20; tunnel leads to valve SY
Valve IK has flow rate=0; tunnels lead to valves RG, TR
Valve RO has flow rate=0; tunnels lead to valves UZ, YL
Valve LQ has flow rate=0; tunnels lead to valves IZ, PA
Valve GG has flow rate=18; tunnels lead to valves GH, VI
Valve NJ has flow rate=0; tunnels lead to valves TU, UZ
Valve SY has flow rate=0; tunnels lead to valves OI, ZL
Valve HH has flow rate=0; tunnels lead to valves QZ, WN
Valve RZ has flow rate=0; tunnels lead to valves AA, UZ
Valve OF has flow rate=0; tunnels lead to valves YL, IZ
Valve IZ has flow rate=9; tunnels lead to valves OF, FH, VH, JZ, LQ
Valve OB has flow rate=0; tunnels lead to valves UZ, NW
Valve AH has flow rate=0; tunnels lead to valves FF, ZL
Valve ZL has flow rate=11; tunnels lead to valves SY, VI, AH
Valve BF has flow rate=0; tunnels lead to valves PA, YL
Valve OH has flow rate=0; tunnels lead to valves CU, JZ
Valve VH has flow rate=0; tunnels lead to valves IZ, JH
Valve AZ has flow rate=0; tunnels lead to valves JC, JH
Valve XG has flow rate=0; tunnels lead to valves BZ, PA
Valve OY has flow rate=0; tunnels lead to valves PZ, QZ
Valve IM has flow rate=0; tunnels lead to valves FM, AA
Valve GO has flow rate=0; tunnels lead to valves VJ, TR
Valve YL has flow rate=8; tunnels lead to valves JC, RO, OF, BF, FM
Valve TY has flow rate=0; tunnels lead to valves SZ, TS
Valve UZ has flow rate=5; tunnels lead to valves OB, NJ, RO, RZ, GC
Valve XF has flow rate=21; tunnel leads to valve BZ
Valve RY has flow rate=0; tunnels lead to valves TR, FF
Valve QQ has flow rate=0; tunnels lead to valves JH, AA
Valve TS has flow rate=0; tunnels lead to valves TY, FF
Valve GC has flow rate=0; tunnels lead to valves VS, UZ
Valve JC has flow rate=0; tunnels lead to valves AZ, YL
Valve JZ has flow rate=0; tunnels lead to valves IZ, OH
Valve IN has flow rate=0; tunnels lead to valves TH, TU
Valve FM has flow rate=0; tunnels lead to valves IM, YL
Valve FH has flow rate=0; tunnels lead to valves AA, IZ
Valve VJ has flow rate=0; tunnels lead to valves AA, GO
Valve TH has flow rate=0; tunnels lead to valves CU, IN
Valve TR has flow rate=7; tunnels lead to valves FE, IK, RY, GO
Valve GH has flow rate=0; tunnels lead to valves GG, FF
Valve SZ has flow rate=10; tunnels lead to valves RG, TY
Valve PA has flow rate=16; tunnels lead to valves XG, LQ, BF
Valve PZ has flow rate=0; tunnels lead to valves CU, OY
Valve VI has flow rate=0; tunnels lead to valves ZL, GG
Valve CU has flow rate=22; tunnels lead to valves PZ, OH, TH
Valve WN has flow rate=0; tunnels lead to valves TU, HH
Valve FF has flow rate=13; tunnels lead to valves VS, RY, AH, TS, GH