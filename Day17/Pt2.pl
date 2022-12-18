#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

my(@rocks);
my($rockCounter)=0;
my($rockPointer)=0;
my($jetPointer)=0;
my(@jets);
my(@chamber)=[];

my(@cycles);

my($runTo)=shift @ARGV;

while(<DATA>){
  chomp;
  my($line)=$_;
  if($line =~ /\#/){
    $rocks[$rockCounter]=[] unless (defined $rocks[$rockCounter]);
    push(@{$rocks[$rockCounter]},$line);
  }elsif($line =~ /[\>\<]/){
    push(@jets,split(//,$line));
  }else{
   $rockCounter++;
  }
}

my($add);

my($pileTop)=-1;
my($dropped)=0;
# drop rocks
for(0..$runTo){
$dropped++;
  $pileTop += addRock($pileTop+4);
 # showChamber();
  # keep moving the rock down until it reports it is stopped.
  while(! moveDown()){
    #showChamber();
  }
  $pileTop= findTop();
  if(defined($cycles[$rockPointer][$jetPointer])){
    my($data)=$cycles[$rockPointer][$jetPointer];
    #print Dumper($data);
    my($loop)=$dropped-$data->{dropped};
    my($height)=$pileTop-$data->{pile};
    print "loop offset is ".$data->{dropped}.", and initial height is ".$data->{pile}."\n";
    print "loop is $loop, height gain is $height\n";
    my($target)=1000000000000;
    $target = $target-$data->{dropped};
    print (($target % $loop)+$data->{dropped});
    print "\n";
    my($add) = int($target / $loop)*$height;
    print 1514285714288 - $add;
    print "\n";
    
  }
  $cycles[$rockPointer][$jetPointer]={ pile=> $pileTop, dropped =>$dropped};
  # print "Round $dropped. top rock: ".($pileTop+1)."\n";
}

showChamber();

sub findTop{
  for(reverse 0..$#chamber){
    my($r)=$_;
    for(0..6){
      if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '#'){
        return $r;
      }
    }
  }
  return -1;
}

sub addRock{
  my($base)=@_;
  my($height)=0;
  my($rock)=$rocks[$rockPointer];
  foreach(reverse @{$rock}){
    my(@chips) = split(//,$_);
    for(0..$#chips){
      if($chips[$_] eq '#'){
        $chamber[$base][$_+2]='@';
      }
    }  
    $height++;
    $base++;
  }
  $rockPointer++;
  if($rockPointer>$#rocks){
    $rockPointer=0;
  }
  return $height;
}

sub moveDown{
  my($t,$b);
  #locate the bottom of the rock
  my($rockFound)=0;
  for( reverse 0..($pileTop+5)){
    my($r)=$_;
    my($p)=1;
    for(0..6){
      if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
        $rockFound=1;
        $p=0;
        if(! defined($t)){
          $t=$r;
        }
      }
    }
    if(defined($t)&&$p){
      $b=$r+1;
      last;
    }
  }
  if($t==0){ $b=0; }
  
  applyJets($t,$b);
    
  #check if can move down;
  my($stopped)=0;
  if($b>0){
    for($b..$t){
    my($r)=$_;
      for(0..6){
        if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
          if(defined $chamber[$r-1][$_] && $chamber[$r-1][$_] eq '#'){
            $stopped =1;
            last;
          }
        }
      }
    }
  }else{
    $stopped=1;
  }

  if($stopped){
   #convert @ to #
   for($b..$t){
    my($r)=$_;
      for(0..6){
        if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
          $chamber[$r][$_]='#';
        }
      }
    }
  }else{
    # move down
    for($b..$t){
    my($r)=$_;
      for(0..6){
        if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
          $chamber[$r-1][$_]=$chamber[$r][$_];
          $chamber[$r][$_]=$chamber[$r+1][$_];
        }
      }
    }
  }
  return $stopped;
}



sub applyJets{
  my($t,$b)=@_;
  
  my($j)=getJet();

  if($j eq ">"){
    my($canMove)=1;
    foreach($b..$t){
      my($r)=$_;
      for (reverse 0..6){
        if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
          if(defined $chamber[$r][$_+1] || $_==6){
            $canMove=0;
            last;
          }
          last;
        }
      }
    }
    if($canMove){
      #print "Jet of gas pushes rock right:\n";
      foreach($b..$t){
        my($r)=$_;
        for (reverse 0..5){
          if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
              $chamber[$r][$_+1]='@';
              $chamber[$r][$_]=undef;
          }
        }
      }
    }else{
      #print "Jet of gas pushes rock right, but nothing happens:\n";
    }
  }else{
    #blow left
    my($canMove)=1;
    foreach($b..$t){
      my($r)=$_;
      for (0..6){
        if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
          if((($_>0)&& defined $chamber[$r][$_-1]) || $_==0){
            $canMove=0;
            last;
          }
          last;
        }
      }
    }
    if($canMove){
      #print "Jet of gas pushes rock left\n";
      foreach($b..$t){
        my($r)=$_;
        for (1..6){
          if(defined $chamber[$r][$_] && $chamber[$r][$_] eq '@'){
              $chamber[$r][$_-1]='@';
              $chamber[$r][$_]=undef;
          }
        }
      }
    }else{
      #print "Jet of gas pushes rock left, but nothing happens:\n";
    }
  }
}

sub showChamber{
  for(reverse (0..20)){
    my($r)=$_;
    printf("%0.2d",$r+1);
    print "|";
    for(0..6){
     if(defined $chamber[$r][$_]){
       print $chamber[$r][$_];
     }else{
       print "."
     }
    }
    print "|\n";
  }
  print "  +-------+\n\n";
}


sub getJet{
  my($jet)=$jets[$jetPointer];
  $jetPointer++;
  if($jetPointer > $#jets){
    $jetPointer=0;
  }
  return $jet;
}

__DATA__
####

.#.
###
.#.

..#
..#
###

#
#
#
#

##
##
>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>