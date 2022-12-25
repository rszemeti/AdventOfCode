#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

my(%vals)=(
  2=>2,
  1=>1,
  0=>0,
  "-"=>-1,
  "="=>-2
);

my(%rvals);
foreach(keys %vals){
  $rvals{$vals{$_}}=$_;
}

my($total)=0;

while(<>){
  chomp;
  $total+=snafuToDecimal($_);
}

print decimalToSnafu($total);

exit 1;

sub snafuToDecimal{
  my($t)=shift;
  my($n,$p)=(0,1);
  map{
    $n+= $p*$vals{$_};
    $p *=5;
  } reverse split(//,$_);
  return $n;
}

sub decimalToSnafu{
  my($n)=shift;
  my($str)='';
  while($n>0){
    my($r)=$n % 5;
    $n = int($n/5);
    if($r>2){
      $r-=5;
      $n++;
    }
    $str = $rvals{$r}."$str"; 
  }
  return $str;
}

