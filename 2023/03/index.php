<style>body {font-family: "Courier New";}</style>
<h1>Advent of Code 2023-12-03</h1>
<?php
$input = file_get_contents('training.txt');
$arr = explode("\n", $input);

$sum = 0;

foreach($arr as $i=>$line) {
	if(strlen($line) == 0) {continue;}
	// echo "$line<br>";
	
	preg_match_all("/\d+/", $line, $matches, PREG_OFFSET_CAPTURE);
	
	$matches = $matches[0]; // this is the real array
	if(count($matches) == 0) {continue;}

	foreach($matches as $m) {
		$num = $m[0];
		$start = $m[1];
		$len = strlen($num);
		
		$surroundings = "";
		$leftEdge = $start-1;
		$lenEdge = $len+2;
		if($leftEdge < 0) {
			$leftEdge = 0;
			$lenEdge -= 1;
		}
		// upper surroundings
		if($i > 0) {
			$surroundings .= substr($arr[$i-1], $leftEdge, $lenEdge);
		}
		// side surroundings
		if($start > 1) {$surroundings .= substr($line, $start-1, 1);}
		$surroundings .= substr($line, $start+$len, 1);
		// bottom surroundings
		if($i != count($arr) && strlen($arr[$i+1]) > 0) {
			$surroundings .= substr($arr[$i+1], $leftEdge, $lenEdge);
		}
		// echo "$num<br>$surroundings<br><br>";
		if(preg_match("/[^\d\.]/", $surroundings)) {
			$sum += $num;
		}
	}
}

echo "<h2>First task: sum = $sum</h2>";
?>
