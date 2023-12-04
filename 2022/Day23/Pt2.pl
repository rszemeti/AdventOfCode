#!/usr/bin/perl

use warnings;
use strict;



use Data::Dumper;

my (@map,@rows,@cols);

my($r)=0;
while(<>){
 chomp;
 push(@map,[split(//,$_)]);
}


my($subIndex)=0;

my(@subs)=(\&check1, \&check2, \&check3, \&check4);

my(%req);
my(@reqList);

my(@search)=(
  [1,0],
  [1,-1],
  [1,1],
  [0, 1],
  [0,-1],
  [-1,-1],
  [-1,0],
  [-1,1],
);

my($round)=0;
my($minR,$maxR,$minC,$maxC)=($#map,0,$#map,0);

for(0..9){
   #reset our extents
  ($minR,$maxR,$minC,$maxC)=($#map,0,$#map,0);
  
  $round ++;
  %req=();
  @reqList=();

  for(0..$#map){
    my($r)=$_;
    for(0..$#{$map[$r]}){
      my($c)=$_;
      if(defined $map[$r][$c] && $map[$r][$c] eq "#"){
        checkElf($r,$c);
      }
    }
  }

  my $need = $#reqList+1;
  #print "$need need to move\n";
  foreach(@reqList){
    my($e)=$_;

    #print "From $e->[0],$e->[1] to $e->[2],$e->[3]\n";
    if($req{$e->[2]}{$e->[3]} < 2){
      $map[$e->[0]][$e->[1]]='.';
      $map[$e->[2]][$e->[3]]='#';
    }else{
     # print "$e->[0],$e->[1] to $e->[2],$e->[3] aborted due to contention\n";
    }
  }

  if($minR<2){
    # add a row to the top
    unshift(@map,[split(//,"."x($#{$map[0]}+1))]);
  }
  
  if(($#map - $maxR)<=1){
    # add a row to the bottom
    push(@map,[split(//,"."x($#{$map[0]}+1))]);
  }
  
  if($minC<=2){
    for(0..$#map){
      unshift(@{$map[$_]},".");
    }
  }
  
  if($#{$map[0]}-$maxC <= 2){
    for(0..$#map){
      push(@{$map[$_]},".");
    }
  }

  $subIndex++;
  last unless($need > 0);

}

print "$round\n";

showMap();

sub checkElf{
  my($r,$c)=@_;
  if($r< $minR){ $minR =$r }
  if($c< $minC){ $minC =$c }
  if($r> $maxR){ $maxR =$r }
  if($c> $maxC){ $maxC =$c }
  if(needMove($r,$c)){
    for(0..3){
      my($sub)=$subs[($subIndex+$_)%4];
      last if &$sub($r,$c);
    }
  }else{
    # print "$r,$c doesnt need to move\n";
  }
}

sub needMove{
  my($r,$c)=@_;
  foreach(@search){
    return 1 if (defined $map[$r+$_->[0]][$c+$_->[1]] && $map[$r+$_->[0]][$c+$_->[1]] eq "#");
  }
  return 0;
}

#print Dumper(\@map);

sub check1{
  my($r,$c)=@_;
  unless(
    ($map[$r-1][$c] eq '#')   ||
    ($map[$r-1][$c-1] eq '#') ||
    ($map[$r-1][$c+1] eq '#')
  ){
    $req{$r-1}{$c}++;
    push(@reqList,[$r,$c,$r-1,$c]);
   # print "moving $r,$c north\n";
    return 1;
  }
  return 0;
}

sub check2{
  my($r,$c)=@_;
  unless(
    ($map[$r+1][$c] eq '#')   ||
    ($map[$r+1][$c-1] eq '#') ||
    ($map[$r+1][$c+1] eq '#')
  ){
    $req{$r+1}{$c}++;
    push(@reqList,[$r,$c,$r+1,$c]);
    #print "moving $r,$c south\n";
    return 1;
  }
  #print "refusing to move $r,$c south\n";
  return 0;
}

sub check3{
  my($r,$c)=@_;
  unless(
    ($map[$r][$c-1] eq '#')   ||
    ($map[$r-1][$c-1] eq '#') ||
    ($map[$r+1][$c-1] eq '#')
  ){
    $req{$r}{$c-1}++;
    push(@reqList,[$r,$c,$r,$c-1]);
    return 1;
  }
  return 0;
}


sub check4{
  my($r,$c)=@_;
  unless(
    ($map[$r][$c+1]   eq '#') ||
    ($map[$r-1][$c+1] eq '#') ||
    ($map[$r+1][$c+1] eq '#')
  ){
    $req{$r}{$c+1}++;
    push(@reqList,[$r,$c,$r,$c+1]);
    return 1;
  }
  return 0;
}

sub showMap{

  
  my($count)=0;
  for(0..$#map){
    my($r)=$_;
    for(0..$#{$map[$r]}){
    my($c)=$_;
      if(defined($map[$r][$c])&& ($map[$r][$c] eq '#')){
        if($r< $minR){ $minR =$r}
        if($c< $minC){ $minC =$c}
        if($r> $maxR){ $maxR =$r}
        if($c> $maxC){ $maxC =$c}
        $count++;
        print "#";
      }else{
        print ".";
      }
    }
    print "\n";
  }
  print "$count\n";
  my($score)=($maxR-$minR+1)*($maxC-$minC+1)-$count;
  print "Score: $score\n";
}

