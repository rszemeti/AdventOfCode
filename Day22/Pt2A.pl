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
  [5,[0,11,0],1,[11,7,2]],
  [6,[3,11,0],1,[8,7,2]],
  [7,[3,8,1],1,[4,7,2]],
  [8,[3,11,1],1,[7,7,2]],
  [9,[4,7,0],1,[3,8,3]],
  [10,[7,7,0],1,[3,11,3]],
  [11,[8,7,0],1,[3,11,2]],
  [12,[11,7,0],1,[0,11,2]],
  [13,[0,4,3],1,[12,0,0]],
  [14,[0,7,3],1,[15,0,0]],

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
              [[3,0],2] 
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
              [[0,2],1],
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
 [-1, 1, 0, 0],
 [ 1, 0, 0, 1],
 [ 0, 0,-1, 1],
 [ 0, 1, 1, 0]
);

if($cubeSize==4){
  runTests();
}else{
  procList();
}

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
  my($failed)=0;
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
      $failed++;
    }
  }
  print "Failed: $failed\n";
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
    print "sense: $s\n";
    # establish coords of top left corner
    my($cr)=$cfr*$cubeSize;
    my($cc)=$cfc*$cubeSize;
    my($co)= $c % $cubeSize;
    my($ro) = $r % $cubeSize;
    
    print "ro $ro, co $co, current direction $curDir\n";
    my($o)=($r % $cubeSize)*(($curDir+1) % 2)+($c % $cubeSize)*($curDir % 2);
    print "source corner is $cr,$cc\n";
    print "source position is $r,$c\n";
    print "source offset is $o\n";
    # translation

    my($dr)=$cubeSize*$dest->[0][0];
    my($dc)=$cubeSize*$dest->[0][1];
    print "dest corner is $dr,$dc\n";

    $dir = ($dest->[1]+2) % 4;
    print "dest edge: $dest->[1], entry direction: $dir\n";
    if($dest->[1] == 0){
      $dc += $cubeSize-1;
      print "dc is $dc\n";
      if($s==1){
        $dr = $dr+$o;
      }else{
        $dr = $dr+$cubeSize-1-$o;
      }
    }elsif($dest->[1] == 1){
      $dr += $cubeSize-1;
      print "dr is $dr\n";
      if($s==1){
        $dc = $dc+$o;
      }else{
        $dc = $dc+$cubeSize-1-$o;
      }
    }elsif($dest->[1] == 2){
      print "dc is $dc\n";
      if($s==1){
        $dr = $dr+$o;
      }else{
        $dr = $dr+$cubeSize-1-$o;
      }
    }elsif($dest->[1] == 3){
      print "dr is $dr\n";
      if($s==1){
        $dc = $dc+$o;
      }else{
        $dc = $dc+$cubeSize-1-$o;
      }
    }
    $nr=$dr;
    $nc=$dc;
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
return if ($cubeSize==50);
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
