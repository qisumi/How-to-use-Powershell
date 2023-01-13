| cmdlet(alias) | Description |
| :---------: | :---------: |
|            #(<#...#>)            |                          单行注释/                           |
| Set-ExecutionPolicy Unrestricted |                   设置脚本执行策略为不限制                   |
|          Get-Help(man)           |                         查询帮助文档                         |
|  |  |
|          Get-Alias(gal)          |                        查询cmdlet别名                        |
| Set-Alias | 新增或设置别名 |
| New-Alias | 创建别名 |
| Export-Alias | 导出别名 |
|                                  |                                                              |
|        Clear-Host(clear)         |                           清空终端                           |
|            Write-Host            |             向终端写入输出，可以指定颜色和背景色             |
|           Out-File(>)            |                 将输出发送到特定文件(重定向)                 |
|        Write-Output(echo)        |       向管道写入输出，如果没有接收命令，则会显示到终端       |
|                                  |                                                              |
|             Get-Date             |                 显示时间，或返回DateTIme对象                 |
|                                  |                                                              |
|          Foreach-Object          |                   对输入对象集合执行语句块                   |
|           Sort-Object            |                     根据属性值对对象排序                     |
|           Where-Object           |                 按照语句从集合中选择（过滤）对象                 |
| Select-Object | 以不同方式选取对象子集，或者对对象选取属性子集，也可以为对象添加计算属性 |
| Create-Object | 创建对象 |
| Measure-Object | 计算对象的数值属性，例如计数、度量 |
| | |
|        Get-Childitem(ls)         |                        查看目录下文件                        |
|             Get-Item             |           查看该目录或文件(区别在于对于目录的处理)           |
|        Get-Location(pwd)         |                         查看当前目录                         |
|         Get-Location(cd)         |                         进入指定目录                         |
|                                  |                                                              |
|        Clear-Content(clc)        |                         清空文件内容                         |
|         Add-Content(ac)          |                       向文件中追加内容                       |
|         Get-Content(cat)         |                         读取文件内容                         |
|         Set-Content(sc)          |                         覆盖文件内容                         |
|                                  |                                                              |
|      New-Item(mkdir, touch)      |                        创建文件或目录                        |
|          Copy-Item(cp)           |                        复制文件或目录                        |
|         Remove-Item(rm)          |                        删除文件或目录                        |
|          Move-Item(mv)           |                        移动文件或目录                        |
|        Rename-Iteam(rni)         |                       重命名文件或目录                       |
|            Test-Path             |                 检查指定的目录或文件是否存在                 |
|                                  |                                                              |
|       Start-Process(start)       | 启动进程，可以指定参数列表和工作目录，以及是否打开新窗口、重定向等 |
|  Invoke-WebRequest(curl, wget)   | 下载网络资源，执行网络请求 |
|  |  |
| Import-Module | 导入模块 |
| Export-ModuleMember | 导出模块 |
| Get-Module | 查看已导入模块 |
| Remove-Module | 删除已导入模块 |

