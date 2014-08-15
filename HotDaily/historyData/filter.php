<?php
	$fileNames = array('funinfo.json', 'feeling.json', 'free.json', 'worldlook.json');
	for ($i=0; $i < 4; $i++) { 
		$file = fopen($fileNames[$i], "r");
		$jsondata = fread($file, filesize($fileNames[$i]));
		fclose($file);
		$jsonarray = json_decode($jsondata, true);
		$json = array();
		foreach ($jsonarray["data"]["list"] as $j) {
			$tmp = array('categoryId' => $j["categoryId"],
						 'noteId' => $j["noteId"],
						 'title' => urlencode($j["title"]),
						 'clickCount' => $j["clickCount"]);
			array_push($json, $tmp);
		}
		$file2 = fopen($fileNames[$i], "w");
		fwrite($file2,urldecode(json_encode($json)));
		fclose($file2);
	}	
?>