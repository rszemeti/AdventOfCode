#!/usr/bin/perl

use warnings;
use strict;



use Data::Dumper;

my (@map);
my(@bl);

my($r)=0;
my($w,$h);

while(<>){
 chomp;
 my(@tks)=(split(//,$_));
 if(!defined $w){
   $w = $#tks+1;
 }
 #print Dumper(\@tks);
 for(0..$#tks){
   my($c)=$_;
   if($tks[$c] =~ /[<>\^v]/){
     push(@bl,{r=>$r, c=>$c, dir=>$tks[$c]});
   }
 }
 push(@map,[split(//,$_)]);
 $r++;
}

$h =$r;

print "Dimesnions are $w x $h\n";

my($dirs)={
  ">" => [0,1],
  "<" => [0,-1],
  "^" => [-1,0],
  "v" => [1,0]
};

my(@layers);

foreach(0..1000){
  push(@layers,makeLayer());
  moveBlizzards();
}


# convenience var for L,R,U,D
my(@edges) = ( 
  [-1, 0],
  [ 1, 0],
  [ 0,-1],
  [ 0, 1],
  [ 0, 0]
);

my($e1)=findRoutes({t=>0,r=>0,c=>1},'F');
print Dumper($e1);
my($e2)=findRoutes($e1,'S');
print Dumper($e2);
my($e3)=findRoutes($e2,'F');
print Dumper($e3);


sub findRoutes{
  my($start)=shift;
  my($goal)=shift;
  my(@q);
  $start->{distance}=0;
  unshift(@q,$start);
  while($#q >=0){
    my($v)=shift(@q);
    if($layers[$v->{t}][$v->{r}][$v->{c}] eq $goal){
      print "found it";
      exit 0;
       return $v;
    }else{
      foreach(@edges){
        my($edge)=$_;
        my($w)={};
        $w->{r}=$v->{r}+$edge->[0];
        $w->{c}=$v->{c}+$edge->[1];
        $w->{t}=$v->{t}+1;
        if($w->{t}<$#layers && $w->{r}>=0 && $w->{r}<$h && $w->{c}>0 && $w->{c}<$w ) {
          # check we didn;t process this location already
          #print "$w->{t}, $w->{r}, $w->{c} ".$layers[$w->{t}][$w->{r}][$w->{c}]."\n";
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
}


#for(0..17){
#  showMap($layers[$_]);
#}

sub moveBlizzards{
  foreach(@bl){
    my($b)=$_;
    my($dir)=$dirs->{$b->{dir}};
    my($nr)=$b->{r} + $dir->[0];
    my($nc)=$b->{c} + $dir->[1];
    
    if($nr>=$h-1){ $nr=1 }
    if($nr<1 ){ $nr=$h-2 }
    if($nc>=$w-1 ){ $nc=1 }
    if($nc<1 ){ $nc=$w-2 }
    
    $b->{r}=$nr;
    $b->{c}=$nc;
    $map[$nr][$nc]=$b->{dir};
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
  $l[0][1]='S';
  $l[$h-1][$w-2]='F';
  
  foreach(@bl){
    my($b)=$_;
    $l[$b->{r}][$b->{c}]='#';
  }
  
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

