#!/usr/bin/perl -w

#Author: Arvin Wiyono
#Student ID: 24282588
#Since: 26 May 2015
#Preprocessing data for Rice coding: Adaptive de-rank with swap next and swap to front algorithms
#Program usage: adaptive_de-rank.pl [-swap_next | -swap2front] < input > output

#Declare STDIN and STDOUT
$OUTPUT = STDOUT;
$INPUT = STDIN;

#Declare and initialize necessary global variables
@symbolTable = (0..255);
@rankTable = (0..255);
$number_of_symbols = 0;

#NOTE: filename goes to $0
#If number of arguments is 1
if($#ARGV+1 == 1){
	#If first argument is valid
	if($0 eq "adaptive_de-rank.pl"){
		if($ARGV[0] eq "-swap_next"){
			#perform swap next algorithm by entering pref = 1
			runDeRank(1);
			
		}
		elsif($ARGV[0] eq "-swap2front"){
			#perform swap to front algorithm by entering pref = 2
			runDeRank(2);
		}
		else{
			
			print "Program usage: adaptive_de-rank.pl [-swap_next | -swap2front]\n";
		}
	}
	else{
		print "Program usage: adaptive_de-rank.pl [-swap_next | -swap2front]\n";
	}
}
else{
	print "Program usage: adaptive_de-rank.pl [-swap_next | -swap2front]\n";
}


#runReRank(preference)
#pref = 1 -> run swap next
#pref = 2 -> run swap to front

sub runDeRank{
	my($pref) = @_;
	while(defined (my $char = getc($INPUT))){
		if($pref == 1){
			swapNext($char);
		}
		else{
			swapToFront($char);
		}
	}
}

#Generic function to swap items in a table
#Usage: swap(from, to, table)
sub swap{
	my $from = shift;
	my $to = shift;
	my $temp = $_[$from];
	$_[$from] = $_[$to];
	$_[$to] = $temp;
}

sub swapNext{
	my ($char) = @_;
	#Char is a rank here, not symbol
	$rankC = ord($char);
	#Get the symbol of rank
	my $symbolC = chr($rankTable[$rankC]);
	#print the symbol to the output stream
	print $OUTPUT $symbolC;
	if($rankC > 0){
		my $symbolSwap = chr($rankTable[$rankC - 1]);
		swap(ord($symbolC), ord($symbolSwap), @symbolTable);
		swap($rankC, $rankC-1, @rankTable);
	}
}

sub swapToFront{
	my ($char) = @_;
	#Char is a rank here, not symbol
	$rankC = ord($char);
	#Get the symbol of rank
	my $symbolC = chr($rankTable[$rankC]);
	#print the symbol to the output stream
	print $OUTPUT $symbolC;
	
	my $symbolSwap;
	if($rankC < $number_of_symbols){
		#Do normal swap next
		if($rankC > 0){
			$symbolSwap = chr($rankTable[$rankC - 1]);
			swap(ord($symbolC), ord($symbolSwap), @symbolTable);
			swap($rankC, $rankC-1, @rankTable);
		}
	}
	else{
		$symbolSwap = chr($rankTable[$number_of_symbols]);
		swap(ord($symbolC), ord($symbolSwap), @symbolTable);
		swap($rankC, $number_of_symbols, @rankTable);
		$number_of_symbols++;
	}
}





