#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

my(@bl);

my($w,$h);

while(<>){
 chomp;
 next unless $_;
 my(@tks)=(split(//,$_));
 if(!defined $w){
   $w = $#tks+1;
 }
 for(0..$#tks){
   my($c)=$_;
   if($tks[$c] =~ /[<>\^v]/){
     push(@bl,{r=>$h, c=>$c, dir=>$tks[$c]});
   }
 }
 $h++;
}

my($dirs)={
  ">" => [0,1],
  "<" => [0,-1],
  "^" => [-1,0],
  "v" => [1,0]
};

my(@layers);

# Start off with the initial state
push(@layers,makeLayer());

# convenience var for L,R,U,D and stand still as a possible options
my(@edges) = ( 
  [-1, 0],
  [ 1, 0],
  [ 0,-1],
  [ 0, 1],
  [ 0, 0]
);

my($e1)=findRoutes({t=>0,r=>0,c=>1},'F');
print "Reached destination in $e1->{t} minutes\n";
my($e2)=findRoutes($e1,'S');
print "Returned to start in $e2->{t} minutes\n";
my($e3)=findRoutes($e2,'F');
print "Reached destination again in $e3->{t} minutes\n";

exit 1;

# basic BFS, moving forward one layer each cycle, because time always moves forward whether you like it or not.
sub findRoutes{
  my($start)=shift;
  my($goal)=shift;
  my(@q);
  $start->{distance}=0;
  unshift(@q,$start);
  while($#q >=0){
    my($v)=shift(@q);
    foreach(@edges){
      my($edge)=$_;
      my($w)={};
      $w->{r}=$v->{r}+$edge->[0];
      $w->{c}=$v->{c}+$edge->[1];
      $w->{t}=$v->{t}+1;
      # add another layer to the time stack iff needed
      if($w->{t} >= $#layers-1){
        moveBlizzards();
        push(@layers,makeLayer());
      }
      if($w->{t}<$#layers && $w->{r}>=0 && $w->{r}<$h && $w->{c}>0 && $w->{c}<$w ) {
        if( defined $layers[$w->{t}][$w->{r}][$w->{c}] &&  $layers[$w->{t}][$w->{r}][$w->{c}] eq $goal){
          return $w
        }
        unless(defined $layers[$w->{t}][$w->{r}][$w->{c}] && $layers[$w->{t}][$w->{r}][$w->{c}] eq "#"){
            $layers[$w->{t}][$w->{r}][$w->{c}]='#';
            $w->{distance}=$v->{distance}+1;
            push(@q,$w);
        }
      }
    }
  }
}

sub moveBlizzards{
  foreach(@bl){
    my($b)=$_;
    
    #move
    my($dir)=$dirs->{$b->{dir}};
    $b->{r} += $dir->[0];
    $b->{c} += $dir->[1];
  
    # reanimate off opposite walls
    if($b->{r}>=$h-1){ $b->{r}=1 }
    if($b->{r}<1 ){ $b->{r}=$h-2 }
    if($b->{c}>=$w-1 ){ $b->{c}=1 }
    if($b->{c}<1 ){ $b->{c}=$w-2 }
  }
}

sub makeLayer{
  my(@l);
  for(0..$h-1){
    my($r)=$_;
    $l[$r][0]='#';
    $l[$r][$w-1]='#';
  }
  for(0..$w-1){
    my($c)=$_;
    $l[0][$c]='#';
    $l[$h-1][$c]='#';
  }
  
  foreach(@bl){
    my($b)=$_;
    $l[$b->{r}][$b->{c}]='#';
  }
  
  $l[0][1]='S';
  $l[$h-1][$w-2]='F';
  
  return \@l;
}

sub showMap{
  my($ly)=shift;
  print "== MAP == \n";
  for(0..$h-1){
    my($r)=$_;
    for(0..$w-1){
      my($c)=$_;
      if(defined($ly->[$r][$c])){
        print $ly->[$r][$c];
      }else{
        print ".";
      }
    }
    print "\n";
  }
}

