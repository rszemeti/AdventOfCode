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
      ore_r => $r[1],
      clay_r => $r[2],
      obs_r_ore => $r[3],
      obs_r_clay => $r[4],
      geode_r_ore => $r[5],
      geode_r_obs => $r[6]
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
  
  my($ore_r,$clay_r,$obs_r,$geode_r)=(1,0,0,0);
  my($ore,$clay,$obs,$geode)=(0,0,0,0);
  
  while($t<=24){
    $t++;
    print "== Minute $t ==\n";
    
    #spend
    my(%q);
    my($wait_ore)=0;
    my($needed_ore)=0;
    
    my($surplus_ore)=0;
    if($obs_r > 0){
      my($minutes_to_next_geode)=ceil(($plan->{geode_r_obs}-$obs)/$obs_r);
      print "In $minutes_to_next_geode minutes we'll need to build an geode robot\n";
      if($minutes_to_next_geode >= 0){
        my($expected_ore) =$minutes_to_next_geode * $ore_r+$ore;
        $surplus_ore += $expected_ore - $plan->{geode_r_ore};
      }
    }
    
    if($clay_r > 0){
      my($minutes_to_next_obsidian)=ceil(($plan->{obs_r_clay}-$clay)/$clay_r);
      print "In $minutes_to_next_obsidian minutes we'll need to build an obsidian robot\n";
      if($minutes_to_next_obsidian >= 0){
        my($expected_ore)=$minutes_to_next_obsidian * $ore_r+$ore;
        $surplus_ore += $expected_ore - $plan->{obs_r_ore};
      }
    }

    if($surplus_ore >= 0){
        print "we expect to have sufficient ore\n";
    }else{
        print "we need to stop consuming ore for a while\n";  
        $wait_ore=1;
    }
    
    #start building
    while(($ore >= $plan->{geode_r_ore})&&($obs >= $plan->{geode_r_obs})){
      print "adding an geode robot\n";
      $q{geode_r}++;
      $ore -= $plan->{geode_r_ore};
      $obs -= $plan->{geode_r_obs};
    }
    while(($ore >= $plan->{obs_r_ore})&& ($clay >= $plan->{obs_r_clay})){
      print "adding an obs robot\n";
      $q{obs_r}++;
      $ore -= $plan->{obs_r_ore};
      $clay -= $plan->{obs_r_clay};
    }
    if(! $wait_ore){
        while($ore >= $plan->{clay_r}){
          print "adding an clay robot\n";
          $q{clay_r}++;
          $ore -= $plan->{clay_r};
        }
    }
      
    #mine  
    $ore += $ore_r;
    $clay+=$clay_r;
    $obs+=$obs_r;
    $geode+=$geode_r;
    
    #finish building
    if(defined $q{ore_r}){
      $ore_r += $q{ore_r};
    }
    if(defined $q{clay_r}){
      $clay_r += $q{clay_r};
    }
    if(defined $q{obs_r}){
      $obs_r += $q{obs_r};
    }
    if(defined $q{geode_r}){
      $geode_r += $q{geode_r};
    }

  print "Ore_r: $ore_r, Clay_r: $clay_r, Obs_r: $obs_r, Geode_r: $geode_r\n";
  print "Ore: $ore, Clay: $clay, Obs: $obs, Geode: $geode\n";
  
  
  }
  
  print "\n##############\n";
  
  return $plan->{id}*$geode;
}



__DATA__
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.