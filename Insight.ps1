#v1.6
$files = Get-ChildItem -Path D:\GPK\Theme\Portal;
#站台開頭
$siteID = "*";
#舊的字串 prg111.png -> pp111.png
$targetString = 'netent';
#新的字串 
$newtargetString = 'ne';
foreach ($file in $files) {
    if($file.Name -like $siteID){

        #取出該站台所有含的目標字串"prg" object形式
        $targetfiles = (Get-childItem $file.FullName -Include *.jpg,*.gif,*.png -Filter ('*'+$targetString+'*')  -Recurse );
        ('site:'+$file.Name)

        #建立更改目標物件
        foreach($targetfile in $targetfiles){
            $targetfileObjecct = [PSCustomObject]@{
                    #圖片檔名
                    targetName = $targetfile.Name;
                    #圖片路徑完整
                    targetFullPath    = $targetfile.FullName;
                    #原始圖片css路徑
                    targetCssPath    = ($targetfile.FullName.replace(($file.FullName+'\'),'')).replace('\','/');
                    #預計取代後的檔名
                    targetNewName = $targetfile.Name -replace $targetString,$newtargetString;
                    #預計取代後的css路徑             
                    targetNewPath = (($targetfile.FullName.replace(($file.FullName+'\'),'')).replace('\','/')).replace($targetfile.Name,($targetfile.Name -replace $targetString,$newtargetString));
                    #預計取代後的完整路徑
                    targetNewFullPath = $targetfile.FullName.replace($targetfile.Name, ($targetfile.Name -replace $targetString,$newtargetString));
            }   

            #確定更動後是沒有重複命名 如果重複命名 將不會執行該圖片相關的url更新
            if(![System.IO.File]::Exists($targetfileObjecct.targetNewFullPath)){
                'fuck'+$targetfileObjecct.targetNewFullPath;
                'target'+$targetfileObjecct.targetNewFullPath;
                'app'+$newtargetString;
                #檔案更名
                $targetfile | Rename-Item -NewName {$_.name -replace $targetString, $newtargetString };

                #搜尋有用到該圖檔的所有檔案 不包含相對路徑!!! 路徑一定要從Content開始
                $needtomodifyfiles = (Get-ChildItem $file.FullName -Include *.cshtml,*.css -Recurse | 
                Where-Object {($_.FullName -notlike '*\node_modules\*')} | 
                Where-Object {(Get-Content $_.FullName | Select-String $targetfileObjecct.targetCssPath -CaseSensitive -SimpleMatch)});

                #跑那些有使用到的檔案 依序更新有用到的檔案的src            
                foreach($needtomodifyfile in $needtomodifyfiles){
                    $linenumber= Get-Content $needtomodifyfile | select-string $targetfileObjecct.targetCssPath

                    #'File: '+$needtomodifyfile.FullNam;
                    #'Change: '+$linenumber.LineNumber +' '+$linenumber;
                    $logs = ('Image:' + $targetfileObjecct.targetFullPath) + "`n";
                    $logs += ('File: '+$needtomodifyfile.FullName + "`n" +'Change: '+$linenumber.LineNumber +' '+$linenumber) + "`n";
                    (Get-Content $needtomodifyfile) -replace $targetfileObjecct.targetCssPath, $targetfileObjecct.targetNewPath | Set-Content $needtomodifyfile -Encoding UTF8| Add-Content 'logs.txt';

                    $fck =  Get-Content $needtomodifyfile;
                    $logs+= ('TO    : '+($linenumber.LineNumber) +' '+$fck[$linenumber.LineNumber-1]) + "`n";
                    #'TO    : '+($linenumber.LineNumber) +' '+$fck[$linenumber.LineNumber-1];
                    $logs+='===================================='+ "`n";
                    $logs | Add-Content 'logs.txt'; 
                    $needtomodifyfile;
                }
            }
        }
    }
};
