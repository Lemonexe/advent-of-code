<style>body {font-family: "Courier New";}</style>
<h1>Advent of Code 2023-12-03</h1>
<?php
$input = file_get_contents('input.txt');
$arr = explode("\n", $input);

$sum1 = 0;
$sum2 = 0;

// log of all found gears as array of [row, col, num]
$gears = [];

// log a gear if not logged already, otherwise add the product
function log_gear($row, $col, $num) {
	global $gears;
	global $sum2;
	foreach($gears as $g) {
		if($g[0] == $row && $g[1] == $col) {
			$sum2 += $num * $g[2];
			$gears[] = [$row, $col, $num];
			return;
		}
	}
	$gears[] = [$row, $col, $num];
}

// iterate through file
foreach($arr as $i=>$line) {
	if(strlen($line) == 0) {continue;}
	
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
			$upper = substr($arr[$i-1], $leftEdge, $lenEdge);
			$surroundings .= $upper;
			// task 2
			$gear_pos = strpos($upper, "*");
			if($gear_pos !== false) log_gear($i-1, $leftEdge+$gear_pos, $num);
		}
		
		// left surroundings
		if($start > 1) {
			$left = substr($line, $start-1, 1);
			$surroundings .= $left;
			// task 2
			if($left == "*") log_gear($i, $start-1, $num);
		}

		// right surroundings
		$right = substr($line, $start+$len, 1);
		$surroundings .= $right;
		// task 2
		if($right == "*") log_gear($i, $start+$len, $num);
		
		// bottom surroundings
		if($i != count($arr) && strlen($arr[$i+1]) > 0) {
			$bottom = substr($arr[$i+1], $leftEdge, $lenEdge);
			$surroundings .= $bottom;
			// task 2
			$gear_pos = strpos($bottom, "*");
			if($gear_pos !== false) log_gear($i+1, $leftEdge+$gear_pos, $num);
		}

		if(preg_match("/[^\d\.]/", $surroundings)) {
			$sum1 += $num;
		}
	}
}
// echo json_encode($gears);

echo "<h2>1st task: sum = $sum1</h2>";
echo "<h2>2nd task: sum = $sum2</h2>";

// debug stars that are in file, but not logged in gears
foreach($arr as $i=>$line) {
	preg_match_all("/\*/", $line, $matches, PREG_OFFSET_CAPTURE);
	$matches = $matches[0];
	foreach($matches as $m) {
		$is_found = false;
		foreach($gears as $g) {
			if($g[0] == $i && $g[1] == $m[1]) {
				$is_found = true;
				break;
			}
		}
		if(!$is_found) echo "WTF ".$i." ".$m[1]."<br>";
	}
}
?>
