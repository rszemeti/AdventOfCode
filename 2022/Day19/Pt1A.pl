#!/usr/bin/perl

use warnings;
use strict;
use POSIX qw/ceil/;

use Data::Dumper;

my(@plans);


while(<DATA>){
  chomp;
  if($_){
    my(@r) = $_ =~ /(\d+)/g;
    my($plan)={
      id => $r[0],
      ore_ore => $r[1],
      clay_ore => $r[2],
      obs_ore => $r[3],
      obs_clay => $r[4],
      geode_ore => $r[5],
      geode_obs => $r[6]
    };
    push(@plans,$plan);
  }
}

foreach(@plans){
  my($plan)=$_;
  my($score)=getScore($plan);
  print "$score\n";
}

sub getScore{
  my($plan)=shift;
  
  my($t)=0;
  
  my(@minutes);
  my($m)={
      ore => 0,
      ore_r => 1,
      clay => 0,
      clay_r =>0,
      obs => 0,
      obs_r => 0,
      geode => 0,
      geode_r =>0,
    };
  $minutes[0]=$m;
  
  my($changed)=1;
  while($changed){
    $changed=0;
    print "loop\n";
    for(1..24){
      my($min)=$_;
       # copy in from previous minute
       $minutes[$min]->{ore}=$minutes[$min-1]->{ore};
       $minutes[$min]->{ore_r}=$minutes[$min-1]->{ore_r};
       $minutes[$min]->{clay}=$minutes[$min-1]->{clay};
       $minutes[$min]->{clay_r}=$minutes[$min-1]->{clay_r};
       $minutes[$min]->{obs}=$minutes[$min-1]->{obs};
       $minutes[$min]->{obs_r}=$minutes[$min-1]->{obs_r};
       $minutes[$min]->{geode}=$minutes[$min-1]->{geode};
       $minutes[$min]->{geode_r}=$minutes[$min-1]->{geode_r};
       my(@q);
       
       # spend ores
       my($oreSpent)=0;
        if(($minutes[$min]->{ore} >= $plan->{geode_ore})&&($minutes[$min]->{obs} >= $plan->{geode_obs})){
          $minutes[$min]->{ore} -= $plan->{geode_ore};
          $minutes[$min]->{obs} -= $plan->{geode_obs};
          $oreSpent+= $plan->{geode_ore};
          push(@q,{geode_r=>1});
        }
        
        if($minutes[$min]->{clay} >= $plan->{obs_clay}){
          if($minutes[$min]->{ore} >= $plan->{obs_ore}){
            print "adding an obsidian\n";
            $minutes[$min]->{ore} -= $plan->{obs_ore};
            $minutes[$min]->{clay} -= $plan->{obs_clay};
            $oreSpent+= $plan->{obs_ore};
            push(@q,{obs_r=>1});
          }else{
            my($needed)= $minutes[$min]->{ore} - $plan->{obs_ore};
            print "Enough clay, but not enough ore ($needed), bugger!\n";
          }
        }
        if($minutes[$min]->{ore} >= $plan->{clay_ore}){
            #  time to next obsidian
            if($minutes[$min]->{clay_r}>0){
              my($tto) = ceil(($plan->{obs_clay} -$minutes[$min]->{clay})/$minutes[$min]->{clay_r});
              my($expected) = $minutes[$min]->{ore} + ($tto * $minutes[$min]->{ore_r})- $plan->{clay_ore};
              
              print " $min .. next obsidian in $tto minutes and expect to have $expected, need ".$plan->{clay_ore}."\n";

            }
 
            $minutes[$min]->{ore} -= $plan->{clay_ore};
            $oreSpent+= $plan->{clay_ore};
            push(@q,{clay_r=>1});
        }
       $minutes[$min]->{ore_spent}=$oreSpent;
       # run the factory
       $minutes[$min]->{ore} += $minutes[$min]->{ore_r};
       $minutes[$min]->{clay} += $minutes[$min]->{clay_r};
       $minutes[$min]->{obs} += $minutes[$min]->{obs_r};
       $minutes[$min]->{geode} += $minutes[$min]->{geode_r};
    
       # put newly built bots to work
       foreach(@q){
         if(defined($_->{clay_r})){
           $minutes[$min]->{clay_r} += $_->{clay_r};
         }
         if(defined($_->{obs_r})){
           $minutes[$min]->{obs_r} += $_->{obs_r};
         }
         if(defined($_->{geode_r})){
           $minutes[$min]->{geode_r} += $_->{geode_r};
         }
       }
    }
  }
  
  print Dumper($minutes[24]);
  
  return $plan->{id}*$minutes[24]->{geode};
}



__DATA__
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.