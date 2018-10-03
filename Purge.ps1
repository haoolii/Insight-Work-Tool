#v1.6
$files = Get-ChildItem -Path D:\GPK\Theme\Portal\PC001-01.Portal -Include *.jpg,*.gif,*.png -Filter ('*'+$targetString+'*')  -Recurse;
#站台開頭
$siteID = "PC001-01.Portal";
#舊的字串 prg111.png -> pp111.png
$targetString = '*';
foreach ($file in $files) {
    
    
       $targetfileObjecct = ($file.FullName.replace('D:\GPK\Theme\Portal\PC001-01.Portal\',''));    
    
        $allfiles = Get-ChildItem 'D:\GPK\Theme\Portal\PC001-01.Portal\' -Include *.cshtml,*.css -Recurse;
        foreach($a in $allfiles){
            
            $x = Select-String -Path $a.FullName $targetfileObjecct;
            if($x){
                $file
            }else{
                'trush'+$file
            }
        }
    #    foreach($t in $targetfileObjeccts){
    #        $results = Get-ChildItem 'D:\GPK\Theme\Portal\PC001-01.Portal\' -Include *.cshtml,*.css -Recurse ;
    #        $tssss = Select-String -Path $r.FullName -Pattern $targetfileObjeccts;
          
    #    }
       
};
