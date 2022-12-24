#!/usr/bin/perl

use warnings;
use strict;
use Term::ANSIColor;


use Data::Dumper;

my (@map,@rows,@cols);
my(@ins);
my($cubeSize);

while(<>){
 chomp;
 my($line)=$_;
 if($line =~ /[\.\#]/){
   push(@map,[split(//,$line)]);
 }
if($line =~ /[RL]/){
   push(@ins, $line =~ /(\d+[RL]?)/g);
 }
}

# construct the row and col arrays for convenience
my($width)=0;
foreach(0..$#map){
  my($i)=$_;
  my($row)=$map[$_];
  my($start,$finish);
  for(0..$#{$row}){
    if($row->[$_] =~ /[\.\#]/){
      if(!defined $start){
        $start =$_;
      }
    }
  }
  $finish = $#{$row};
  if($finish > $width){ $width = $finish }
  $rows[$i]= { start => $start, finish => $finish };
}

foreach(0..$width){
  my($c)=$_;
  my($start,$finish);
  
  for(0..$#map){
    my($r)=$_;
    if(defined $map[$r][$c] && $map[$r][$c] =~ /[\.\#]/){
      if(!defined $start){
        $start =$r;
      }
    }else{
      if((defined $start) && (! defined ($finish))){
        $finish =$r-1;
      }
    }
  }
  if(! defined $finish){ $finish = $#map }

  $cols[$c]= { start => $start, finish => $finish };
}

my($curDir)=0; #start off right
my($r,$c)=(0,$rows[0]->{start});

$cubeSize=$rows[0]->{start};
print "Starting at $r,$c\n";

my(@tests)=(
  [1,[0,4,0],1,[0,5,0]],
  [2,[0,4,0],2,[0,6,0]],
  [3,[0,4,2],1,[11,0,0]],
  [4,[1,4,2],1,[10,0,0]],
  [4,[0,11,0],1,[11,7,2]],

);

my(@dirs) =( 
  [0,1,">"],  # 0 right, 0
  [1,0,"V"],  # 1 down, increase row count
  [0,-1,"<"], # 2 left
  [-1,0,"^"]  # 3 up
);

# net formation, showing which edges are connected to other edges. 
my(@faces)=(
 [ 
   {},
   { id=>'T' , #01
     edges=>[ 
              [],
              [],
              [[2,0],2],
              [[1,1],2] 
            ]
   },
   { id=>'E', #02
     edges=>[ 
              [[2,1],0],
              [[1,1],0],
              [],
              [[3,0],1] 
            ] 
   } 
 ],
 [ 
   {},
   { id=>'S', #11
     edges=>[ 
              [[0,1],1],
              [],
              [[2,0],3],
              [],
            ] 
   },
   {} 
 ],
 [ 
   { id=>'W', #20
     edges=>[ 
              [],
              [],
              [[0,1],2],
              [[1,1],2] 
            ]
   
   },
   { id=>'B', #21
     edges=>[ 
              [[0,2],0],
              [[3,0],0],
              [],
              [] 
            ]
   },
   {} 
 ],
 [ 
   { id=>'N', #30
     edges=>[ 
              [[2,1],1],
              [[0,2],3],
              [[0,1],3],
              [] 
            ]
   },
   {},
   {} 
 ]
);

# maps the joining edges whether they are in opposite directions
my(@t)=(
 [1,0,0,1],    # non rotated, normal sense
 [-1,0,0,-1],  # non rotated, inverted sense
 [0,1,1,0],    # rotated, normal sense
 [0,-1,-1,0]   # rotated, inverted sense
);

my(@sense)=(
 [$t[1], $t[2], 0    , 0    ],
 [$t[2], 0    , 0    , $t[0]],
 [ 0   , 0    , $t[1], $t[2]],
 [ 0   , $t[0], $t[2], 0    ]
);

runTests();
#procList();

print "$r,$c,$curDir ".$dirs[$curDir][2]."\n";
print "Result: ".(1000*(1+$r) + (4*($c+1))+$curDir);

exit 1;

sub procList{
  foreach(@ins){
    my($dist,$dir)=$_ =~ /(\d+)([RL]?)/;
    if($dist>0){
      move($dist);
    }
    showMap();
    rotate($dir);
    $map[$r][$c] = $dirs[$curDir][2];
  }
}

sub rotate{
  my($dir)=shift;
    if($dir eq 'R'){
    $curDir++;
    if($curDir > 3){ $curDir = 0 }
  }elsif($dir eq 'L'){
    $curDir--;
    if($curDir < 0){ $curDir = 3 }
  }
}

sub move{
  my($dist)=shift;
  for(0..$dist-1){
    my($nr,$nc,$dir)= translateCube($r,$c,$curDir);
    if( $map[$nr][$nc] ne '#'){
      $curDir=$dir;
      $r=$nr;
      $c=$nc;
      $map[$r][$c] = $dirs[$curDir][2];
    }
  }
}

sub runTests{
  foreach(@tests){
    my($test)=$_;
    $r=$test->[1][0];
    $c=$test->[1][1];
    $curDir=$test->[1][2];
    move($test->[2]);
    if($r==$test->[3][0] && $c==$test->[3][1] && $curDir==$test->[3][2]){
      print "Test ".$test->[0]." passed\n";
    }else{
      print "Test ".$test->[0]." failed\n";
      showMap();
      print "expected ".$test->[3][0].",".$test->[3][1].",".$test->[3][2]."  got $r,$c,$curDir\n";
    }
  }
}

sub translateCube{
  my($r,$c,$dir)=@_;
  
  my($nr)= $r+$dirs[$curDir][0];
  my($nc)= $c+$dirs[$curDir][1];
  
  my($cfr,$cfc)= getFace($r,$c);

  my($isEdge)=0;
  if($nr > $cols[$c]->{finish}){
   #print "off the bottom at $r,$c -> $nr,$nc\n";
   $isEdge=1;
  }
  elsif( ($nr < $cols[$c]->{start})){
  # print "off the top at $r,$c -> $nr,$nc\n";
   $isEdge=1;
  }
  elsif($nc > $rows[$r]->{finish}){
   #print "off the right end at $r,$c -> $nr,$nc\n";
   $isEdge=1;
  }
  elsif(($nc < $c) && ($nc < $rows[$r]->{start})){
   #print "off the left end at $r,$c -> $nr,$nc\n";
   $isEdge=1;
  }
  
  if($isEdge){
    print "current face is $cfr,$cfc, position $r,$c with direction $dir\n";
    my($dest)= $faces[$cfr][$cfc]{edges}[$dir];
    my($s)= $sense[$dir][$dest->[1]];
    print "\n\ndest edge: ".$dest->[1]." on face ".$dest->[0][0].",".$dest->[0][1]."\n";
    print "sense: $s->[0],$s->[1],$s->[2],$s->[3]\n";
    # establish coords of top left corner
    my($cr)=$cfr*$cubeSize;
    my($cc)=$cfc*$cubeSize;
    my($ro)=$r-$cr;
    my($co)=$c-$cc;
    print "source corner is $cr,$cc\n";
    print "source position is $r,$c\n";
    print "source offset is $ro,$co\n";
    # translation
    # print Dumper($s);
    my $tro = $ro*$s->[0]+$co*$s->[1];
    if($s->[0]==-1){ $tro += $cubeSize-1 }
    
    my $tco = $ro*$s->[2]+$co*$s->[3];
    if($s->[3]==-1){ $tco += $cubeSize-1 }
    
    #if($tro<0){ $tro += $cubeSize-1}
    #if($tco<0){ $tco += $cubeSize-1}

    my($dr)=$cubeSize*$dest->[0][0];
    my($dc)=$cubeSize*$dest->[0][1];
    print "dest corner is $dr,$dc\n";
    print "translated offset is $tro,$tco\n";
    $nr = $dr + $tro;
    $nc = $dc + $tco;
    $dir = ($dest->[1]+2) % 4;
    print "dest edge: $dest->[1], entry direction: $dir\n";
    print "suggesting move to $nr,$nc,$dir\n";
  }
  
  return($nr,$nc,$dir);
}

sub translateFlat{
  my($r,$c,$dir)=@_;
  
  my($nr)= $r+$dirs[$curDir][0];
  my($nc)= $c+$dirs[$curDir][1];
  
  my($cfr,$cfc)= getFace($r,$c);

  
  if($nr > $cols[$c]->{finish}){
   #print "off the bottom at $r,$c -> $nr,$nc\n";
   $nr = $cols[$c]->{start};
  }
  elsif( ($nr < $cols[$c]->{start})){
  # print "off the top at $r,$c -> $nr,$nc\n";
   $nr = $cols[$c]->{finish};
  }
  elsif($nc > $rows[$r]->{finish}){
   #print "off the right end at $r,$c -> $nr,$nc\n";
   $nc = $rows[$r]->{start};
  }
  elsif(($nc < $c) && ($nc < $rows[$r]->{start})){
   #print "off the left end at $r,$c -> $nr,$nc\n";
   $nc = $rows[$r]->{finish};
  }
  return($nr,$nc,$dir);
}

sub getFace{
  my($r,$c)=@_;
  
  my($i)=int($r/$cubeSize);
  my($j)=int($c/$cubeSize);
 
  return ($i,$j);
}

sub showMap{
  for(0..$#map){
    my($row)=$_;
        printf("%0.3D ",$_);
    for(0..$width){
      if(defined $map[$row][$_]){
        if($row == $r && $c==$_){

          print $map[$row][$_];
          #print "*";

        }else{
          print $map[$row][$_];
        }
      }else{
        print " ";
      }
    }
    print "\n";
  }
  print "\n";
}

__DATA__
