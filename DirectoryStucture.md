#本工程目录结构.

# Introduction #

为了保证大家开发一致，约定本项目的目录结构.

# Details #

1 由于rails支持controller按目录组织（只要在generate时在controller名前加“目录/”)因此，要求app的controller/helper/view各个目录均按功能分开目录，如framework/showconfiguration/changemanange

2 在public中增加pages目录，按功能存放静态网页和网页片段。 与app目录一样，pages/images/javascripts/stylesheets等均按功能分开目录，比如xtreeview/active\_scaffold等

3 插件统一放在vendor\plugins目录下，子目录名就是插件名字，建议目录名包含插件版本。

4 所有测试用例，必须放在test目录，遵从rails约定。 插件的测试用例，放在插件子目录test中。

5 lib目录可以存放不属于model的功能类，如utils/tree.rb等。不同类别的类位于不同的子目录。

6 doc目录专门存放rdoc的输出，其他文档如果放本目录，必须增加子目录放入。

7 db目录是配合migrate功能组织的。本项目的DB部署使用SQL脚本方式，不用migrate功能。因此本目录应存放modeling/procedures/scripts/int\_db等目录。

8 config目录一般不动（第一阶段使用WebRick服务器，连接sql server 2000数据库）。 为防止配置文件冲突，本工程中不包含database.yml文件，而是包含一个database\_fs.yml文件。