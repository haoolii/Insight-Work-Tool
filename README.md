# Insight-Work-Tool
更改圖片名稱並修正CSS、HTML圖片路徑

## 使用方法
1. 設定權限
	用管理者模式開啟 powershell 執行以下 script
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

2. 開啟 powershell 執行以下 script
	powershell.exe Insight.ps1

	執行完畢會產生log檔 參考即可

注意事項：
1. 檔案類型
	預設僅處理 *.jpg *.png *.gif

2. 並無更新game-box、資料夾 

## 延伸計畫
Purge清除廢圖片的還沒做，因為Powershell判斷是否為NUll有點問題，還沒特別研究怎麼解決。
