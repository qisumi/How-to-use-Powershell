<#
任务，有一个支持以下参数的程序，批量的将一个目录下的压缩文件解压，并且使用该程序处理。

  OPTIONS:

      -h, --help                        HELP MENU
      这些参数表示转换数据的含义，选项之间互斥
        --tec                             转换TEC数据
        --zc                              转换中层数据
        --gc                              转换高层数据
        --foE                             转换重测仪数据
        --foF2                            转换重测仪数据
      这些参数表示输入和输出文件的路径，是必需的选项
        --input_dir=[INPUT]               输入文件路径
        --output_dir=[OUTPUT]             输出文件路径

    Developed by CILab 2022-08-28. Version: 0.0.1
	********Help Message*********
#>

# CONFIGURATIONS
$INPUT_PATH = "."
$OUTPUT_PATH="$INPUT_PATH\output"
$DATA_TYPE_ARG="--foE"
$CONVERTER_PATH = ".\nc_file_converter.exe"

# CREATE DIR IF NOT EXIST
$OUTPUT_EXIST=(Test-Path $OUTPUT_PATH)
Set-Location $INPUT_PATH
if($OUTPUT_EXIST -eq $False)
{
	New-Item -Path $OUTPUT_PATH -ItemType "Directory"
}

# FIND FILES
$ZIPPED_DATA=Get-ChildItem . | where {$_.Name -match "^\d{6}\.\d{2}\.gz$"}
$UNZIPPED_DATA=Get-ChildItem . | where {$_.Name -match "^\d{6}\.\d{2}$"} | Select-Object -ExpandProperty Name

# UNZIP IF NOT UNZIPPED
$ZIPPED_DATA | ForEach {
	$UNZIP_NAME=$_.Name.Remove(9,3)
	if(-not($UNZIPPED_DATA -Contains $UNZIP_NAME)){
		.\gunzip.exe -vkf $_
	}
}

# FIND FILES
$UNZIPPED_DATA=Get-ChildItem . | where {$_.Name -match "^\d{6}\.\d{2}$"}

$TOTAL_FILE_NUM = 0

# CONVERT
$UNZIPPED_DATA | ForEach {
	$EXEC_STR = "$CONVERTER_PATH $DATA_TYPE_ARG --input_dir=$_ --output_dir=$OUTPUT_PATH\$_.txt"
	Invoke-Expression $EXEC_STR
	$TOTAL_FILE_NUM = $TOTAL_FILE_NUM + 1
}

Write-Host "Convert $TOTAL_FILE_NUM files totally"