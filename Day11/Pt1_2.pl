#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

my (@monkeys);

# autobots assemble!
my($monkeyId);
my($monkey);

while(<DATA>){
  my($line)=$_;
  chomp;
  if($line=~/Monkey\s+(\d+)/){
     $monkeyId=$1; 
     $monkey={ count => 0 };
  }elsif($line=~/Starting\s+items:\s+(.*)/){
    my(@items) = split(/,\s/, $1);
    $monkey->{items} = \@items; 
  }elsif($line=~/Operation: (.*)/){
    $monkey->{operation} = $1;   
    #modify the operation to be a valid Perl instruction by adding $ to vars
    $monkey->{operation} =~ s/(\w{3})/\$$1/g;
  }elsif($line=~/Test:.*\s(\d+)/){
    $monkey->{test} = $1;   
  }elsif($line=~/true.*\s(\d+)/){
    $monkey->{true} = $1;   
  }elsif($line=~/false.*\s(\d+)/){
    $monkey->{false} = $1;   
  }else{
    $monkeys[$monkeyId]=$monkey;
  }
}

# we can use a worry level of mod (product of test values) ... 
my($prod)=1;
map {$prod *= $_->{test}} @monkeys;

# 1 to 20 for Pt1, 1 to 10,000 for Pt2
for(1..10000){
  foreach my $monkey (@monkeys){
    while(scalar(@{$monkey->{items}})){
      $monkey->{count}++;
      my($old)=shift @{$monkey->{items}};
      my($new);
      eval $monkey->{operation};
      # $new = int($new/3); #  comment out for Pt2
      $new = $new % $prod;
      if($new % $monkey->{test}){
        push @{$monkeys[$monkey->{false}]->{items}},$new;
      }else{
        push @{$monkeys[$monkey->{true}]->{items}},$new;
      }
    }
  }
}

my(@topTwo) =( reverse sort { $a->{count} <=> $b->{count} } @monkeys)[0..1];
print $topTwo[0]->{count} * $topTwo[1]->{count};

__DATA__
Monkey 0:
  Starting items: 98, 89, 52
  Operation: new = old * 2
  Test: divisible by 5
    If true: throw to monkey 6
    If false: throw to monkey 1

Monkey 1:
  Starting items: 57, 95, 80, 92, 57, 78
  Operation: new = old * 13
  Test: divisible by 2
    If true: throw to monkey 2
    If false: throw to monkey 6

Monkey 2:
  Starting items: 82, 74, 97, 75, 51, 92, 83
  Operation: new = old + 5
  Test: divisible by 19
    If true: throw to monkey 7
    If false: throw to monkey 5

Monkey 3:
  Starting items: 97, 88, 51, 68, 76
  Operation: new = old + 6
  Test: divisible by 7
    If true: throw to monkey 0
    If false: throw to monkey 4

Monkey 4:
  Starting items: 63
  Operation: new = old + 1
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1

Monkey 5:
  Starting items: 94, 91, 51, 63
  Operation: new = old + 4
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 3

Monkey 6:
  Starting items: 61, 54, 94, 71, 74, 68, 98, 83
  Operation: new = old + 2
  Test: divisible by 3
    If true: throw to monkey 2
    If false: throw to monkey 7

Monkey 7:
  Starting items: 90, 56
  Operation: new = old * old
  Test: divisible by 11
    If true: throw to monkey 3
    If false: throw to monkey 5



