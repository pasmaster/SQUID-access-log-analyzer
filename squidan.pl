
# SQUID log analizer
# Version 2015-12-17-10-55

print "SQUID log Analizer\n"; 
print "Version 2015-12-18-11-25\n"; 

$sNameFileIn=$ARGV[0];
$sNameFileOutCounts=$ARGV[1];
$sNameFileOutRecords=$ARGV[2];

%hashCounts = ();
 
open(FIN, $sNameFileIn);
open(my $FOUTCOUNTS, '>', $sNameFileOutCounts);
open(my $FOUTRECORDS, '>', $sNameFileOutRecords);

while(<FIN>)
{

	$str=$_;
	$sIPAdress="";
	$iVolume=0;
	
	$iPositionCount = index($str, "GET");
	if ($iPositionCount>0) {
		@Fields=split(" ", $str);
		$sIPAdress=@Fields[2];
		$iVolume=int(@Fields[4]);
		
		if ($iVolume > 0) {
			print $FOUTRECORDS "$sIPAdress;$iVolume\n"; 
			if(exists($hashCounts{$sIPAdress})){
				$hashCounts {$sIPAdress} = $hashCounts {$sIPAdress} + $iVolume;
			}
			else{			
				$hashCounts {$sIPAdress} = $iVolume;				
			}
		}
	}
}

foreach $key(sort keys %hashCounts){
	print $FOUTCOUNTS "$key;$hashCounts{$key}\n"; 
}

close FIN;
close FOUTCOUNTS;
close FOUTRECORDS;



