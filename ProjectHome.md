基于Ruby on Rail的SCM(软件配置管理）WEB应用。为软件企业、开发团队提供对软件代码、文档、数据等所有配置项的高效管理。

SCM是比版本控制更高一级的管理工具，比如不同项目之间共享产品，产品之间共享程序模块等。SCM的关键是变更控制：比如一个现场的问题、一个改进建议（Issue,事件）会触发哪些变更， 而这个变更又涉及了哪些程序单元（配置项，一组文件）的哪个版本，影响到了哪些现场项目，其他产品会不会受到影响？这些任务的管理需要由系统来支持，仅靠CVS等版本控制系统是不够的。

SCM之所以重要，可以从许多公司和团队发生的下列问题来看出：

● 找不到软件："我知道我写完了，但是不知道把它放在那了"；

● 相互覆盖代码：开发人员对相同的代码做不同的修改，互相覆盖，必然至少有一个人很郁闷；

● 无法返回：新的修改比原来的代码还差劲，不能返回原来的版本；

● 版本混乱：那份程序应该给用户呢；出错了，应该打那个版本的补丁呢；

● 管理和归档意识混乱：

－客户打电话："出问题了"；

－程序员解决了问题，但是没有进行变更登记；

－在没有修改包含在内的情况下进行联编软件；

－把未修改的软件交付用户；

－客户打电话："还有问题"；

－操作员："我的确已经修改了"  等等


本SCM系统已经开发完成C/S版本,已经实际应用并产生很好的效果。现在将扩展基于WEB的查询和变更管理功能，并逐步将整个产品移植到rails平台。


本项目讨论组（论坛）网址: http://groups.google.com/group/rails4scm?hl=zh-CN

讨论组（论坛）的邮件地址: rails4scm@googlegroups.com


为了成为开发成员，你需要用自己的邮箱注册一个googlecode帐号（sign in那里），然后把帐号告诉任意一个project owner，由他将你作为新用户加入到项目成员中（是否项目成员的区别只是能否提交代码和编辑wiki，其他不受影响）。


源码下载和提交应使用SVN客户端（建议用tortoisewin32svn.msi这个explore插件，或者NETBEANS集成环境）。代码reposity的地址是：

# Project members authenticate over HTTPS to allow committing changes.

svn checkout https://rails4scm.googlecode.com/svn/trunk/ rails4scm --username xxxx@yyyy.com

When prompted, enter your generated googlecode.com password. 这个密码在setting那个菜单里可以看到并可重新生成。

# Non-members may check out a read-only working copy anonymously over HTTP.

svn checkout http://rails4scm.googlecode.com/svn/trunk/ rails4scm

有任何疑问，可以通过邮件或者电话与project owners联系。