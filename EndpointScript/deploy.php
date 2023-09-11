<?php
$data = json_decode(file_get_contents("php://input"), true);
// Validez le webhook si nécessaire (par exemple, vérifiez une signature)
if($data['commits']["message"] === "init") {
    exec("./init.sh");
    return "OK-Init";
}
exec("./deploy.sh");
return "OK-Deploy";