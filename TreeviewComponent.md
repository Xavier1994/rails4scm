#开发树形展现插件
# Introduction #

使用plugin插件方式，开发树形展现组件，可以使用xtree20展现，也可直接输入table的方式.


# Details #

制作展现的PLUG-INS以便重用：网上文档很少，但好像比较简单

  1. 用 ruby script/plugin install calendar\_helper  可以安装现成的plug-ins

> 2 要创建新组件，只要：ruby script/generate plugin fstreeview 就可以了

> 3 代码一般写在lib目录，一般使用module也就是mixin方式编程。

> 4 在组件根目录下的init.rb中增加 ActionView: :Base.send(:include, FsTreeview)代码，就可以保证在应用启动的时候，自动将FsTreeview模块扩展到ActionView: :Base类中了！类似还可以扩展ActiveRecode和ActionContorller

如此看来，实际上和在应用中直接编程没有什么两样，只是换了一个地方、独立性更强而已。

