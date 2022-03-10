<?php

if (file_get_contents("php://input")) {
    $imageData = file_get_contents("php://input");
    $filteredData = substr($imageData, strpos($imageData, ",") + 1);
    // Need to decode before saving since the data we received is already base64 encoded
    $unencodedData = base64_decode($filteredData);
    $path = "output/img_" . microtime(1) . ".png";
    file_put_contents($path, $unencodedData);
    echo $path;
}
