# Getting Started

## 安装和下载

PowerShell3.0集成在了所有的Windows10以上系统中。该文档也是基于Powershell3.0的。但仍然建议安装

- [Windows 终端安装 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/install)
- [在 Windows 上安装 PowerShell - PowerShell | Microsoft Learn](https://learn.microsoft.com/zh-cn/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7.2)

虽然最新的PS已经到达了7.x版本，但是不用担心，因为某种原因，他和PS3.0的差别并不是很大。

> 一个有趣的事情：大多数情况下，软件版本号的管理遵循[semver语义化版本表达](https://semver.org/lang/zh-CN/)。简要来说，一个版本号的格式为`X.Y.Z`。他们分别表示
>
> 1. 主版本号：当你做了不兼容的 API 修改，
> 2. 次版本号：当你做了向下兼容的功能性新增，
> 3. 修订号：当你做了向下兼容的问题修正。
>
> 而主版本号，往往就会体现在软件名上。例如`Python2`和`Python3`并不兼容，所以造成了事实上的社区分裂，他们已经变成了两个语言。
>
> 由于这样的原因，软件主版本号的变更实际上非常罕见。例如`numpy`在2006年发布`v1.0.0`，直到现在，主版本号仍然没有变化，为`1.24.1`（2023年）。
>
> 然而事情总不是一成不变的，有竞争就会有内卷。Chrome带来了“按照时间发布版本”的习惯。不论功能变化如何，每个固定的时间就会发布新的版本。用户潜意识会认为主版本号变化带来了非常多的功能改进，就更愿意升级。于是现在很多大公司的项目也有类似的行为（包括PS）。Chrome的大版本号已经达到了`105`.

## 像在Linux中一样使用命令

就像在Linux中一样，你可以使用诸如`cd` `ls` `mkdir` `cat`等命令进行基本操作，但是并非所有的Linux指令都在PS中得到支持。如下图：PS中的命令往往返回一个二维表格。这与Linux中`ls -l`的行为类似，但是有本质的不同。Linux的命令行是基于文本的，而PS中的命令行是基于对象的。在Linux中，任何命令的输出都是基于文本的，根据对字符串的处理，我们可以做到对命令输出的处理，例如检索、行计数、过滤等等。但是这在某种角度上是低效的，因为数据在不同指令和程序之间流动需要解析字符串来转换格式。

<img src="http://blogoss.qisumi.cn/image-20230114090958229.png" style="zoom:50%;" />

## 命令的基本形式 Cmdlet

在Linux中往往使用缩写作为命令的名称，例如`mkdir = make directory` `cd = change directory`。这个是一个充满geek风格的行为，但是也有一些历史遗留的原因。那个时候的终端还不支持自动补全等功能。在PowerShell中，一般使用成为`Cmdlet`的命令，他的格式为**动词-名词**，例如`Get-Help` `Write-Output`.这样做的好处是，对于初学者来说很容易了解命令的含义，缺点是比较冗长，但这不是问题，因为在PowerShell中由良好的自动补全功能（使用`Tab`键）。

在[Cmdlet Cheatsheet](./CmdletCheatsheet.md)中记录了一些常用的Cmdlet和对应的功能描述。

## 命令的别名

实际上`mkdir`等Linux命令在PS的支持是通过别名来实现的，我们可以给一个很长的命令起一个别名。使用   `*-Alias`系列命令可以查看、增加、修改和删除别名。

## 使用Get-Help和Get-Command命令

`Get-Help`是最重要的命令，因为他可以帮助我们获得一个命令的帮助。一般我们使用这两种命令。

```powershell
# 获得基本帮助，会输出下图信息
Get-Help Set-Location

# 查看使用例子，在下一小节展示
Get-Help Set-Location -Example
```

<img src="http://blogoss.qisumi.cn/image-20230114133001899.png" style="zoom:50%;" />

`Get-Command`命令用来帮助我们发现我们可能需要但还不知道的命令。由于Cmdlet的特殊形式，我们可能会启发式的猜测我们所需要命令的名字。例如我们知道`Set-Location`相当于`cd`，那么`pwd`命令应当可能是`Get-Location`。不论如何，他至少应该是`*-Location`的形式，那么我们查找一并获得如下输出下。

```powershell
Get-Command *-Location

CommandType     Name                       Version    Source
-----------     ----                       -------    ------
Cmdlet          Get-Location               7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Pop-Location               7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Push-Location              7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Set-Location               7.0.0.0    Microsoft.PowerShell.Management
```

不难猜测`Get-Location`是我们所需要的命令，那他具体如何使用的？使用`Get-Help`。

```powershell
Get-Help Get-Location -Example
```

<img src="http://blogoss.qisumi.cn/image-20230114133708722.png" style="zoom: 67%;" />

这样我们就知道了这条命令使用的基本方法（这里有很多例子，但我只截图了最简单的一个）。

## 按顺序运行多个命令

使用`;`分割多个命令

## 使用管道组合多个命令

多个使用`|`分割的命令序列称为管道，管道从上一条命令获得输出，并作为输入传输给下一条命令。下面有一个例子。这个例子中首先使用`Get-Location`获得当前路径对象，通过管道传输给`ls`命令。

```powershell
Get-Location | ls
```

![](http://blogoss.qisumi.cn/image-20230114134323256.png)

## Powershell基于对象

从之前的图中我们不难看出，大多数命令的输出都是二维表格的形式，实际上这是一系列对象。表格的表头是对象的属性。对于`ls`的输出可以这样理解。`ls`输出一系列**文件对象**。这些对象拥有(`Mode, LastWriteTime, Length Name`)这些**属性**。在管道中传输的也是对象。这样做的好处是数据在传输到下一条命令时可以提前校验格式，还可以避免解析字符串带来的性能开销。

## Powershell大小写不敏感

Powershell中所有的**关键字、命令**都是大小写不敏感的。

## 输入输出重定向

Powershell支持输出重定向运算符`>` `>>`。但是不支持输入重定向。但是我们总是可以使用 `Get-Content |`来代替输入重定向，即先获取文件的内容，再通过管道传输给下一条命令。

## 对输出进行处理

我们现在已经知道，PS是基于对象的。那么在这种情况下，我们对输出进行处理，往往使用`*-Object`系列命令。如下有几个简单的例子。

```powershell
# 给输出按照修改时间属性排序
ls | Sort-Object -Property LastWriteTime
# 给输出去重
ls | Sort-Object -Unique

# 按照条件过滤输出，这里选择Length属性大于100的
ls | Where-Object -Property Length -ge 100

# 查看输出了多少条记录, 相当于Linux中的 wc -l
ls | Measure-Object
```

## 使用脚本

PS脚本以`.ps1`为后缀，PS脚本的写法除了可以使用PS命令之外，和正常的编程语言大致相同。可以参考**Docs**部分详细了解。这里介绍一些最简单的特征。

### 使用方法

在PS中先输入`Set-ExecutionPolicy Unrestricted`之后，就开启了使用脚本的权限。然后使用脚本的路径来调用脚本。

### 变量

PS中的变量必须以`$`开头，可以赋值为整数、浮点数、字符串等。字符串使用`'`或`"`包裹。

### 特殊结构

PS中的变量还可以是**数组、哈希表、对象**。具体的使用方法查看**Docs**部分对应章节。

### 函数

PS中可以定义函数，PS中函数的定义可以很复杂，也可以很简单。具体的使用方法查看**Docs**部分对应章节。

### 流程控制

PS中支持`if else elseif` `switch case default` `while for foreach`  `do while` `break continue` `try catch throw`这些在其他语言中也很常用的关键字，用法大致相同。有些许不同的地方主要在`break continue` 查看**Doc/语句/标记语句**小节进行详细了解。

### 运算符

PS中的数值运算符、赋值和其他语言类似，包括`+ - * / += -= *= /= ++ -- = ()` 。但是其他运算符都使用了非符号表示，这样做的好处是可以简化解析，并且可以定义大量的运算符而不用担心特殊符号被用完。这些运算符统一使用 `-name`表示。例如相等`==`用`-eq`表示。所以`if`语句往往是`if($a -gt 10)`的形式，这里表达的是**如果$a变量大于10**.详细的运算符参见**Docs/运算符**章节。这里列出一些常用的运算符。

1. `eq -> equal` 等于

2. `ne -> not equal` 不等于

3. `gt -> greater than`大于

4. `lt -> less then` 小于

5. `ge -> great equal`大于等于

6. `le -> less equal` 小于等于

7. `AND` `OR` `NOT` `XOR` 逻辑运算符

# Docs

## 基本概念

### Cmdlet

Cmdlet是PowerShell环境中实现功能的特殊命令。遵循“动词-名词”模式，例如：`set-childItem`。Cmdlet的输入输出都是对象，而且通过管道输入和输出。Cmdlet处理对象序列和集合时是线性的，同时只处理一个。一些Cmdlet拥有缩写，通常是再Linux中有相同功能的命令。

### 与Linux Shell的不同

PowerShell大部分情况下处理的都是对象。而Linux Shell只处理文本。相对应的，Linux Shell的内置命令的输入输出也都是文本。	

### 基本术语

1. 别名：将较长的命令赋予较短的别名

2. 环境变量：从操作系统环境中获取变量，例如 `$PATH`.

3. 函数：Powershell脚本中可以创建并使用函数

4. 变量：Powershell脚本中可以定义并使用变量

5. 工作位置：在调用命令时，如果没有显示指定路径，往往使用工作位置的路径

6. 项：包括别名、变量、函数、环境变量、或者文件和目录。

7. 路径名：包括绝对路径、相对路径、特殊路径。绝对路径一般是从`C:/`或者`D:/`开始（Linux上则从`/`开始。相对路径相对于工作位置开始。特殊路径见对应章节。

8. 模块：模块作为一个脚本，可以导出变量和函数，供其他脚本或者shell导入使用。

9. 重载和调用解析：函数名相同但函数签名[^1]不同的函数。PowerShell和大多数支持重载的编程语言一样，会自动按照参数解析。

10. 管道：管道是由管道运算符 `|`分隔的一个或多个命令序列，每个命令接受前置任务的输入，并将输出写入到后续任务。管道末尾处的输出默认会输出到控制台，也可以重定向到文件。

    [^1]: 函数签名：函数名称、参数数量、参数类型统一构成了函数签名

### 通配符表达式

Powershell除了支持正则表达式，也在一些地方支持简单通配符，规则如下：

|          元素          |                             描述                             |
| :--------------------: | :----------------------------------------------------------: |
| 除*、? 和 [ 之外的字符 |                         匹配一个字符                         |
|           *            |     与零个或多个字符匹配。 若要匹配 * 字符，请使用 [*]。     |
|           ?            |        匹配任何单字符。 如需匹配 ? 字符，请使用 [?]。        |
|         [set]          | 匹配 set 中的任意一个字符，不能为空如果 set 以 ] 开头，则右方括号被视为 set 的一部分，下一个右方括号终止 set；否则，第一个右方括号终止 set。如果 set 以 - 开头或结尾，则减号连字符被视为 set 的一部分；否则，它指示一系列连续的 Unicode 代码点，连字符减号两边的字符开始包含在内的范围分隔符。 例如，A-Z 指示 26 个大写英文字母，0-9 指示 10 个十进制数字。 |

### 特殊路径名

对于相对路径，有如下规则：

| 符号 | 说明                   | 相对路径           | 完全限定的路径      |
| :--- | :--------------------- | :----------------- | :------------------ |
| `.`  | 当前工作位置           | `.\System`         | `C:\Windows\System` |
| `..` | 当前工作位置的父级     | `..\Program Files` | `C:\Program Files`  |
| `\`  | 当前工作位置的驱动器根 | `\Program Files`   | `C:\Program Files`  |
| 无   | 无特殊字符             | `System`           | `C:\Windows\System` |

## 变量

### 变量基础

变量以`$`开头，不区分大小写，不包含空格和特殊字符。默认情况下变量的值为`$NULL`。特别的，如果需要在变量名称中使用特殊字符，需要将变量名置于大括号中，例如`{my-variable}`。

变量使用`=`赋值，使用`Clear-Variable`删除变量，也可以将其赋值为`$null`。

对于变量的类型，可以使用`GetType()`方法查看。

默认创建的变量都是局部变量，如果需要创建特殊的变量遵循以下规则：`$global: var`创建全局变量。`$script: var`创建脚本变量。

变量根据用户能否修改、由谁创建分为三种。

|    类型    | 创建者 | 用户读写 |
| :--------: | :----: | :------: |
|  用户变量  |  用户  |   读写   |
|  自动变量  |  系统  |   只读   |
| 首选项变量 |  系统  |   读写   |

### 可变修饰符

1. ReadOnly 可访问，不可修改，可删除
2. Constant 可访问，不可修改，不可删除

### 自动变量

自动变量由系统创建和维护，用户可读不可写。常见的自动变量有：

|              变量               |                      描述                      |
| :-----------------------------: | :--------------------------------------------: |
|               $$                |          最后执行的命令中的最后一部分          |
|               $?                |          最后一个操作执行状态是否成功          |
|               $_                |     在管道对象集合的遍历语法中表示当前对象     |
|            $foreach             |            表示ForEach循环的枚举数             |
|      \$true \$false \$null      |                表示布尔值和空值                |
| \$IsLinux \$IsWindows \$IsMacOS |                    查询平台                    |
|             $input              | 枚举传递给函数的所有输入，仅适用于脚本快和功能 |
|              $Home              |                 用户的Home目录                 |

### 首选项变量

常见的首选项变量有

|         变量         |      默认值      |
| :------------------: | :--------------: |
|   $OutputEncoding    | UTF8Encoding对象 |
| $MaximumHistoryCount |       4096       |

## 运算符

任何列出而不加说明的运算符，其作用和常见编程语言中的类似。

> 在 PowerShell 中存在两种运算符，一种使用符号表达，例如 + - * / 。而另外一种是使用单词来表达运算。这样做的好处是可以避免符号不够用的情况，这些运算符的使用方式为 `-op`。以 `eq`为例：`$a -eq $b`.表示 `a==b`

### 算术运算符

`+` `-` `*` `/` `%` `++` `--`

> 特别说明：这里的乘法运算符还用于数组、字符串的复制。加法用于字符串、数组、哈希表的连接

### 比较运算符

`eq` `ne` `gt` `ge` `lt` `le`

> 特别说明：PowerShell 允许一个集合和一个操作数进行比较。但返回的不是一个布尔数组，而是返回集合的子集，其中的项满足在比较中返回了 `$True`

这是一种常用，但是又不太常用的运算符表达方式，如果你熟悉Latex应该会比较熟悉。其简要含义包括：

1. `eq -> equal` 等于

2. `ne -> not equal` 不等于

3. `gt -> greater than, lt -> less then` 大于或小于

4. `ge -> great equal, lt -> less equal` 大于等于或小于等于

### 赋值运算符

`=` `+=` `-=` `*=` `\=`

### 逻辑运算符

`AND` `OR` `NOT` `XOR`

### 位运算符

`BAND` `BOR` `BXOR`

### 一些用于字符串的运算符

   1. `not` 前缀表示否定
   2. `c` 前缀表示大小写敏感（对非字符串运算不起作用）
   3. `i` 前缀表示显示大小写不敏感（对非字符串运算不起作用）

   ```
       -as           -ccontains     -ceq
       -cge          -cgt           -cle
       -clike        -clt           -cmatch
       -cne          -cnotcontains  -cnotlike
       -cnotmatch    -contains      -creplace
       -csplit       -eq            -ge
       -gt           -icontains     -ieq
       -ige          -igt           -ile
       -ilike        -ilt           -imatch
       -in           -ine           -inotcontains
       -inotlike     -inotmatch     -ireplace
       -is           -isnot         -isplit
       -join         -le            -like
       -lt           -match         -ne
       -notcontains  -notin         -notlike
       -notmatch     -replace       -shl
       -shr          -split
   ```

### 其他运算符

1. 管道运算符：`|`

2. 输出重定向运算符：`>` `>>` 

3. 调用、属性访问运算符：`.`

4. 逗号运算符（用于创建数组）：`,`

5. 字符串操作运算符：`split` `join` `replace` 及其前缀变体

6. 强制类型转换运算符：`[type]`

7. 范围运算符（生成一维数组）：`..` 例如 `1..3`表示`1,2,3`

8. 字符串格式化运算符：`{N[,M][:FormatString]}`

9. 包含运算符：`contains` `in` 及其 `not` 前缀变体。他们的区别在于语义，对于`contains`数组为左操作数，对于`in`则相反。

10. 类型测试运算符 ：`is`

11. 模式匹配运算符：`match` `like` 及其前缀变体。其中`match`支持正则表达式，而`like`支持通配符表达式。

    > 对于 match 和 replace 这种可以接受正则表达式的函数来说，还支持子表达式，在返回的结果中按照顺序（从0开始，按左括号出现的顺序）来排列。对于 replace 来说，使用 $1 \$2 来表达。也可以使用?<name>来定义具名匹配项而不是让 \$matches 中的键成为从0开始的索引

## 表达式

表达式是一系列运算符和操作数，它指定方法、函数、可写位置或值；指定值的计算；产生一个或多个副作用；或执行它们的某种组合。例如

- 文本 123 是一个指定 int 值 123 的表达式。

- 表达式 `1,2,3,4` 指定具有所示值的 4 元素数组对象。

- 表达式 `10.4 * $a` 指定计算。

- 表达式 `$a++` 会产生副作用。

- 表达式 `$a[$i--] = $b[++$j]` 执行这些操作的组合。

在PowerShell的表达式中，运算优先级和其他编程语言没有明显区别，包括使用括号改变优先级，不做更多介绍。

> 顶级表达式的值可能会被自动放入管道。如果某个**顶级表达式**包含副作用运算符（例如赋值、自增自减运算符），那么其值不会被放入管道，反之则会。顶级表达式指不属于某个更大表达式的表达式。可以使用括号强制将一个顶级表达式变为非顶级表达式，例如`($a++)`是一个非顶级表达式

### 调用表达式

调用表达式通过`.`或者`::`来完成。例如

```powershell
[math]::Sqrt(2.0)
[char]::IsUpper("a")
$b.ToUpper()
```

> 这里有一种特殊的语法，`[math]::Sqrt` 这实际上是因为PowerShell受`.Net`支持，所以也可以使用`.Net`中的很多特性。

### $(...)表达式

对内部语句列表（使用`;`分割）分别求值，如果得到单个元素，则结果为该元素。没有结果则为 `$null`。否则则为对象数组。并将结果作为一个对象数组写入管道。

```powershell
$j = 20
$($i = 10) # pipeline gets nothing
$(($i = 10)) # pipeline gets int 10
$($i = 10; $j) # pipeline gets int 20
$(($i = 10); $j) # pipeline gets [object[]](10,20)
$(($i = 10); ++$j) # pipeline gets int 10
$(($i = 10); (++$j)) # pipeline gets [object[]](10,22)
$($i = 10; ++$j) # pipeline gets nothing
$(2,4,6) # pipeline gets [object[]](2,4,6)

$a = @(2,4,6)          # result is array of 3
@($a)                  # result is the same array of 3
@(@($a))               # result is the same array of 3
```

### @(...)表达式

与`$(,,,)`表达式类似。区别在于，在没有值时，`@(...)`会得到一个空数组，而`$(...)`会得到`$null`.

### @{...}表达式

用于创建哈希表，详见相关章节。

## 命令

### 命令调用

命令调用包含命令的名称和若干个自变量（参数），合法的命令可以是：

1. 别名
2. 函数
3. cmdlet
4. 外部命令
5. `{}`包裹的合法PowerShell语句

对于重名的命令，也按照上述顺序（优先级）进行查找。

对于命令调用，也有另外一种方式，它允许我们使用字符串来调用。这样我们就可以把命令储存到变量中，例如以下三种调用是等价的。
```powershell
Get-Factorial 5
& Get-Factorial 5
& "Get-Factorial" 5
```

> 和大多数编程语言类似，如果一个命令是函数，那么它支持直接或间接的 **递归 **调用

### 命令参数

调用命令时可以输入若干变量作为参数，参数名以`-`开头，并且后面紧随若干空白符，再绑定一个参数值。常见命令参数有以下三种形式：

- 开关参数：参数的类型为布尔值。

  ```powershell
  Set-MyProcess -Strict
  Set-MyProcess -Strict: $true
  ```

- 普通参数

  ```
  Get-Power -base 5 -exponent 3
  Get-Power -exponent 3 -base 5
  ```

- 位置参数

  ```powershell
  Get-Power 5 3
  ```

- [通用参数](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_commonparameters)：指可以和任何 cmdlet 一起使用的参数。

### 错误处理

命令失败时，将被视为错误，关于错误的信息记录在错误记录中，其类型未指定。

错误属于两个类别之一。 它要么终止运算（终止错误），要么不终止运算（非终止错误）。 对于终止错误，系统会记录错误并停止运算。 对于非终止错误，系统会记录错误并继续运算。

自动变量 `$Error` 包含一组表示最近错误的错误记录，最近的错误在 `$Error[0]` 中。 此集合保留在缓冲区中，这样在添加新记录时会放弃旧记录。 自动变量 `$MaximumErrorCount` 控制可存储的记录数。

`$Error` 包含在同一个集合中混合在一起的所有命令中的所有错误。 若要从特定命令中收集错误，请使用常用参数 `ErrorVariable`，该参数允许指定用户定义的变量来保存集合。

## 管道

管道是由管道运算符 `|`分隔的一个或多个命令序列，每个命令接受前置任务的输入，并将输出写入到后续任务。管道末尾处的输出默认会输出到控制台，也可以重定向到文件。

### 管道语句

管道语句是使用`|`连接的若干个命令或表达式。PowerShell会用如下规则处理这些自变量作为命令的参数。

- 如果不是表达式，担保函任意文本，没有空格，视为保留大小写的字符串。
- 如果使用引号包裹，则视为包含空格的字符串
- 用括号包裹自变量会导致计算该表达式的值
- 如果是参数则进行对应的参数解析

### 管道的流式处理

如果某个命令写入一个对象，则它的后续任务会接收该对象，然后在将其自己的对象写入到其后续对象之后终止。 但是，如果一个命令写入多个对象，则每次将一个对象传递到后续任务命令，该命令对每个对象执行一次。 此行为称为流式处理。 在流处理过程中，对象会在可用时立即写入管道，而不是在整个集合生成后。

## 字符串

Powershell中的字符串可以由单引号或双引号定义。他们都是`System.String`对象（来自`.Net`平台）。

### 字符串常用操作

```powershell
# 串联的三种方法
$s1+$s2
$s1,$s2 -join ".COM" # 输出{$s1}.COM{$s2}
[System.String]::Concat($s1,$s2)
#子串
$s.SubString(begin,len)
# 格式化内插
$s = "{0:n2,10} {1:p1,-10}" -f $s1,$s2 # :n2表示保留2位小数 :p1先保留小数点后一位再转换为百分数，,10 ,-10表示向右(左)对齐并补足10位。
# 替换
$s.Replace(s1,s2) 
$s -replace s1,s2 # 大小写不敏感，使用creplace则大小写敏感
$s -creplace s1,s2
# 包含
$s. -match $s1 # 大小写不敏感, 使用cmatch则大小写敏感
$s.Contains($s1) # 大小写敏感
# 过滤器
$s -like "3.14*" # -like支持通配符
# 分割
$s.Split($s1,[StringSplitOptions]::RemoveEmptyEntries) # 指定删除空的切割结果
# 比较
$s1.CompareTo($s1)
# 长度
$s.Length
# 插入
$s.Insert(begin, $s1)
# 删除
$s.Remove(begin, length)
# join
"10","20","30" -join(",") # 10,20,30
```

### 字符串格式化

```powershell
# 字符串格式化的详细规则
`$i` = 10; $j = 12
"{2} <= {0} + {1}\`n" -f $i,$j,($i+$j)  # 22 <= 10 + 12
">{0,3}<" -f 5                          # > 5<
">{0,-3}<" -f 5                         # >5 <
">{0,3:000}<" -f 5                      # >005<
">{0,5:0.00}<" -f 5.0                   # > 5.00<
">{0:C}<" -f 1234567.888                # >$1,234,567.89<
">{0:C}<" -f -1234.56                   # >($1,234.56)<
">{0,12:e2}<" -f 123.456e2              # > 1.23e+004<
">{0,-12:p}<" -f -0.252                 # >-25.20 % <
$format = ">{0:x8}<"
$format -f 123455                       # >0001e23f<
```

## 语句

### 语句块

和`C/C++` `JAVA`类似，PowerShell使用`{...}`来表示语句块，一个语句块内可以有若干语句。类似`JavaScript`，PowerShell不强制使用`;`作为语句分隔符。

### 语句的值

语句的值是它写入管道的一组累计值。 如果语句写入一个标量值，则该值是语句的值。 如果语句写入多个值，则该语句的值是一组按写入顺序存储在不受约束的一维数组的元素中的值。

```powershell
# 循环没有迭代，也没有向管道写入任何内容。 语句的值为 $null。
$v = for ($i = 10; $i -le 5; ++$i) { }

# 循环迭代了五次，但没有向管道写入任何内容。 语句的值为 $null。
$v = for ($i = 1; $i -le 5; ++$i) { }

# 循环迭代了五次，每次向管道写入 int 值 $i。 语句的值是值为 Length 5 的 object[]。
$v = for ($i = 1; $i -le 5; ++$i) { $i }
```



### 标记语句

和大多数编程编程语言不同的是，PowerShell的`break/continue`可以根据标记跳出若干层循环。这是一个非常好的特性。就像下面这样使用：

```powershell
:go_here while ($j -le 100) {
    # ...
}

:labelA
for ($i = 1; $i -le 5; ++$i) {
    :labelB
    for ($j = 1; $j -le 3; ++$j) {
        :labelC
        for ($k = 1; $k -le 2; ++$k) {
            # ...
        }
    }
}
```



> 实际上，对设计良好的代码，我们不应该需要这个特性，如果我们的代码中有多层循环，并且还有复杂的`break`需求，说明我们需要修改代码的设计，但是有总比没有好。

### IF语句

和大多数语言类似的设计，包含 `if` `elseif` `else` 三个关键字。

### WHILE，DO WHILE语句

和大多数语言类似的设计。

### FOR语句

和大多数语言类似的设计。

### FOREACH语句

通常和 `in` 搭配使用。可遍历对象包括：

- 数组
- 范围
- 数组字面量
- 管道输出的对象集合
- 集合的`Keys` `Values`

示例：

```powershell
# 数组
foreach ($e in $a) {
    ...
}
# 范围
foreach ($e in -5..5) {
    ...
}
# 数组字面量
foreach ($t in [byte], [int], [long]) {
    $t::MaxValue # get static property
}
# 管道的输出
foreach ($f in Get-ChildItem *.txt) {
    ...
}
# 集合的Keys或Values
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
foreach ($e in $h1.Keys) {
    "Key is " + $e + ", Value is " + $h1[$e]
}
```

### 流程控制语句

以下语句和其他语言的设计类似，但有一些区别

- `break` （可以使用标签）
- `continue` （可以使用标签）
- `exit $code`（终止当前脚本）
- `switch default` （可以使用字符串作为值，甚至可以使用正则表达式，不需要使用显性的`break`）

### 异常处理语句

`try` `catch` `finally` `thorw` 和其它语言的设计类似

## 数组

在PowerShell中声明数组，使用逗号分割的多个值给变量赋值。默认情况下数组是多态数组，不要求元素具有相同的类型。*同时，PowerShell中的类型是引用类型，这意味着简单的赋值不会创建新的对象。*

`$var = v1, v2, v3,...,vn`

在PowerSehll中访问数组元素，使用方括号，下标从`0`开始，支持负数、范围。对于多维数组，PowerShell使用类似Python的语法，即`arr[0,0]`这种形式。

### 数组的创建和访问

```powershell
$arr = 1,2,3,4,5 # 创建一维数组
$mat = New-Object 'object[,]' 2,2 # 创建二维数组
# 一般访问
$arr[1]
# 访问范围
$arr[1..4]
# 负数索引
$arr[-1]
```

### 常用操作

```powershell
$a = 1,2,3,4
# 获取数组长度
$a.Length
# 添加元素
$a += 1
# 初始化空数组
$a = @()
# 删除数组元素：PowerShell不直接支持删除数组，需要重新创建
$a = ($a[1] $a[2] $a[3])
# 约束元素类型
$a = [int[]](1,2,3)
# 复制数组
[Array]::Copy($a,$b,2) # 将前2个元素从 a 复制到 b
```

### 负数下标

类似Python，PowerShell接受负数下标。

```powershell
# 负数所以
$arr[-1]
```

### 数组切片

数组切片是集合中若干个元素的副本，可以通过下标运算符创建

```powershell
$arr[1..4]
$arr[1,3,4]
$a[-1..-3]
$a[(0,1),(1,0)] # 二维
```

### 枚举数组

除了使用下标，我们还可以使用`foreach`语句来枚举数组元素。对于多维数组，使用行优先顺序。

```powershell
$a = 10, 53, 16, -43
foreach ($elem in $a) {
    # do something with element via $e
}

foreach ($elem in -5..5) {
    # do something with element via $e
}

$a = New-Object 'int[,]' 3, 2
foreach ($elem in $a) {
    # do something with element via $e
}
```

## 哈希表

在PowerShell中，哈希表分为无序或有序两种。与数组相同，也是作为引用类型存在。

### 哈希表的创建

```powershell
$variable_name = @{ <key1> = <value1> ; < key2> = <value2> ; ..... ; < keyN> = <valueN>;}
$variable_name = [ordered] @{ < key1> = <value1> ; < key2> = <value2> ; ..... ; < keyN> = <valueN>;}
```

### 哈希表的属性

```powershell
$hash.keys
$hash.values
$hash.count
```

### 哈希表的CRUD

```powershell
# 读、改
$hash["key"] = newValue
$hash.Key = newValue
$hash[20.5] = newValue
# 增
$hash.Add(key,value)
# 删
$hash.Remove(key)
# 遍历
$hash.GetEnumerator() | Sort-Object -Property key
# 串联
$h1 += $h2
$h1 = $h1 + $h2
```

## 函数

### 函数定义

PowerShell的函数支持管道，还需要提供一些文档（用来响应Get-Help），还可以支持参数名在PowerShell中的自动补全。所以完整的函数定义是非常复杂的（幸运的是这些都是可选的），我们将逐步的介绍函数的定义规则。一个最简单的函数可以这样定义：

```powershell
# 包含关键字、函数名、参数列表、默认参数和类型定义、返回值的函数
function Get-Power ([long]$base, [int]$exponent = 2) {
    # body
    return $result
}
```

### 函数属性

可以在函数声明时指定一些属性

```powershell
# 该函数在Get-Help中将显示一些帮助信息
[Help('text')]
function Get-Power ([long]$base, [int]$exponent = 2) {}
```



### 筛选器函数

普通函数在管道中运行一次，并通过 `$input` 访问输入集合，而 filter 是一种特殊类型的函数，它针对输入集合中的每个对象执行一次。 当前正在处理的对象可通过变量 `$_` 获取。

```powershell
filter Get-Square2 { # make the function a filter
    $_ * $_ # access current object from the collection
}
-3..3 | Get-Square2 # collection has 7 elements
```

### 参数绑定

参数绑定按如下顺序进行

1. 对所有指定参数名的参数赋值

   > 在没有歧义的情况下，允许使用参数的前若干个字母作为缩写，只需要满足该缩写不是参数的公共前缀即可。

2. 按照剩余的实参和形参顺序一一赋值

3. 如果还有剩余参数，全部放入`$args`变量（如果设置了对应的参数属性）

4. 如果参数不足够，从管道中绑定。

### `switch`类型的参数

`switch`又被称为开关参数，它的值仅有 `$true` `$false`两种。默认值为`$false`。调用时只需要输入对应的参数名，就可以将其设置为`$true`。



### 参数属性

在参数定义时可以指定一些属性。例如：

```powershell
param (
    [Parameter(HelpMessage = "some text")]
    [Alias("CN")]
    [Alias("name", "system")]
    [string[]] $ComputerName
)
```

上述参数定义完成了：

1. 设置在`Get-Help`页面中，该参数会显示帮助信息
2. 拥有三个参数别名
3. 类型为`string[]`

常见的属性及描述如下表：

|                        属性                        |                             描述                             |
| :------------------------------------------------: | :----------------------------------------------------------: |
|                   Alias: string                    |                           参数别名                           |
|                AllowEmptyCollection                |                         允许为空集合                         |
|                  AllowEmptyString                  |                        允许为空字符串                        |
|                     AllowNull                      |                        允许为`$null`                         |
|                  Paramter: object                  |                         定义形参特征                         |
|               ValidateCount: object                |               定义接受参数数组的最小和最大个数               |
|               ValidateNotNullOrEmpty               |  定义参数不能为空字符串、空数组、`$null`或者包含他们的集合   |
|               PSDefaultValue: object               |                     包含帮助信息和默认值                     |
|           ValidatePattern: regex_string            |                       验证模式是否匹配                       |
|               ValidateRange: object                |                     验证参数最小、最大值                     |
|               ValidateScript: 表达式               |               使用逻辑表达式对参数进行复杂验证               |
|                ValidateSet: object                 |                 验证参数是否是某个集合中的值                 |
|            （prama块属性）CmdletBinding            | 此属性在函数的“参数块”的“属性列表”中用于指示该函数的行为类似于 cmdlet 具体来说，它可以让函数使用它可让函数使用 `begin`、`process`和 `end` 命名块通过 `$PsCmdlet` 变量来访问大量方法和属性。但是定义这个属性之后，`$args`将不会接受多于参数。 |
| （prama块属性）OutputType: object(type[],string[]) |             指定返回值的类型、返回类型参数集名称             |
|                       [type]                       |                         定义参数类型                         |

|             Parameter参数             |                             描述                             |
| :-----------------------------------: | :----------------------------------------------------------: |
|          HelpMessage: string          | 如未提供所需参数，运行时会提示用户输入参数值。 提示对话框包含 HelpMessage 文本。(如果设置了`Mandatory=$true`) |
|            Mandatory: bool            |       如果未提供该参数，要求PowerShell请求用户手动输入       |
|       ParameterSetName: string        |                    指定参数所属参数集名称                    |
|             Position: int             |     指定位置，从0开始。如果没有指定则必须指定名称或别名      |
|        ValueFromPipeline: bool        | 是否接受来自管道对象的输入并将对象作为唯一参数，当且仅当参数集内只有一个参数时可以设置为`$true` |
| ValueFromPipelineByPropertyName: bool |  是否接受来自管道对象的输入，且从管道对象的属性名来接受参数  |
|   ValueFromRemainingArguments: bool   |                 是否使用`$args`接受多余参数                  |

| PSDefaultValue参数 |           描述           |
| :----------------: | :----------------------: |
|    Help: string    | 在Get-Help中显示帮助信息 |
|   Value: object    |      指定参数默认值      |

|    ValidateCount参数    |   描述   |
| :---------------------: | :------: |
| MinLength:int（位置 0） | 最小数目 |
| MaxLength:int（位置 1） | 最大数目 |

|   ValidateRange参数    |  描述  |
| :--------------------: | :----: |
| MinRange:int（位置 0） | 最小值 |
| MaxRange:int（位置 1） | 最大值 |

|    ValidateSet参数     |                             用途                             |
| :--------------------: | :----------------------------------------------------------: |
| ValidValues（位置 0）  |                   类型：string[]有效值集。                   |
| IgnoreCase（命名参数） | 类型：bool；默认值：$true指定是否应忽略字符串类型的参数的大小写。 |

### 参数集

可编写能够针对不同方案执行不同操作的单个函数或 cmdlet。 方法是根据所需执行的操作公开相应的参数组。 此类参数分组称为“参数集”。

参数属性`Prameter.ParameterSetName`指定形参所属的参数集。 此行为意味着每个参数集必须具有一个唯一参数，且该参数不存在于任何其他参数集中。

对于属于多个参数集的参数，请为每个参数集添加 `Parameter` 属性。 这将允许以不同方式定义每个参数集中的参数。包含多个位置参数的参数集必须为每个参数定义唯一位置。 两个位置参数不能指定同一位置。如果某个参数未指定有参数集，则该参数属于所有参数集。

```powershell
# 定义了两个参数集 Computer 和 User，参数SharedParam同时属于两个参数集
param ( [Parameter(Mandatory = $true，
ParameterSetName = "Computer")]
[string[]] $ComputerName，

[Parameter(Mandatory = $true，
ParameterSetName = "User")]
[string[]] $UserName，

[Parameter(Mandatory = $true，
ParameterSetName = "Computer")]
[Parameter(ParameterSetName = "User")]
[int] $SharedParam = 5 )

if ($PsCmdlet.ParameterSetName -eq "Computer")
{
	#处理Computer
}

elseif ($PsCmdlet.ParameterSetName -eq "User")
{
	# 处理User
}
```

### 从管道获得参数

使用`$input`可以从管道中获得参数，如下例子：

```powershell
function Get-Square1 {
    foreach ($i in $input) {   # iterate over the collection
        $i * $i
    }
}
-3..3 | Get-Square1
```

### 生命周期块

如果函数从管道中获得参数，并且开启了`CmdletBinding`属性，我们可以使用一些块来在其不同的生命周期执行代码。他们包括

1. `begin`
2. `process`
3. `end`

```powershell
function Get-Square1 {
		begin{
			echo "Begin"
		}
		process{
      $_ = $_ * $_
		}
		
		foreach ($i in $input) {   # iterate over the collection
        echo $i
    }
    
    end{
    	echo "End"
    }
}
```

### 定义参数的另一种方式-Param块和DynamicParam块

示例代码展示了使用方法，首先定义两个静态参数，如果`$str`参数满足条件，`QI`参数及其默认值才是可用的。

```powershell
function fun {
    param ([string]$str, [int]$start_pos = 0);
    DynamicParam{
    	if($srt -eq "*Qisumi"){
    		$paramDictionary.Add("QI",$Default)
    		return $paramDictionary
    	}
    }
}
```

### Param块属性 OutputType

|        参数        |        描述        |
| :----------------: | :----------------: |
|  位置0：string[]   | 返回的值类型的列表 |
| 其余部分：string[] |                    |

```powershell
[OutputType([int])] param ( ... )
[OutputType("double")] param ( ... )
[OutputType("string","string")] param ( ... )
```

### 部分只允许在工作流中使用的块

它们包括`parallel sequence inlinescipt`，参考[工作流](https://learn.microsoft.com/zh-cn/powershell/scripting/lang-spec/chapter-08?view=powershell-7.2#8102-workflow-functions)。

## 基于注释的帮助

PowerShell 为程序员提供了一种机制，可以使用特殊的注释指令来记录其脚本。 使用此类语法的注释称为帮助注释`Get-Help`从这些指令生成文档。

### 简介

帮助注释包含格式为 .name 的帮助指令，后跟一行或多行帮助内容文本 。

帮助主题中的所有行都必须是连续的。 如果帮助主题前面的注释不属于该主题，则两者之间必须至少有一个空白行。指令可以按任意顺序显示，并且某些指令可能会多次出现。记录函数时，帮助主题可能出现在以下三个位置之一：

- 紧接在函数定义之前，在函数帮助的最后一行与包含函数语句的行之间不超过一个空白行。
- 紧接在左大括号之后的函数体内。
- 紧接在右大括号之前的函数体内。

记录脚本文件时，帮助主题可能出现在以下两个位置之一：

- 在脚本文件的开头，可以只在前面加上注释和空白行。 如果帮助后脚本的第一项是函数定义，则脚本帮助的末尾和该函数声明之间必须至少有两个空白行。 否则，帮助将被解释为应用于函数而非脚本文件。
- 在脚本文件的末尾。

```powershell
<#
<help-directive-1>
<help-content-1>
...

<help-directive-n>
<help-content-n>
#>
<#
.DESCRIPTION
Computes Base to the power Exponent. Supports non-negative integer
powers only.
#>
```

### 帮助命令

|          命令名           |                             描述                             |
| :-----------------------: | :----------------------------------------------------------: |
|       .DESCRIPTION        |                    详细描述，只能使用一次                    |
|         .SYNOPSIS         |                    简要描述，只能使用一次                    |
|         .EXAMPLE          |                           用法示例                           |
|          .INPUTS          |                描述管道传输到脚本或函数的对象                |
|           .LINK           | 指定一个http(s)起始的URL，使用Get-Help -Online时会打开这个页面 |
|          .NOTES           |                  其他帮助信息，只能使用一次                  |
|         .OUTPUTS          |                         描述输出对象                         |
| .PARAMETER Parameter-Name |                         描述给定参数                         |
