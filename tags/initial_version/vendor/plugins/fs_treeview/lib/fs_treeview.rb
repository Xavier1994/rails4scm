require 'fs_tree_model'

module FsTreeview
private 
   def gen_item(subtree,parentName,count)
       tree_html = "var #{parentName}_#{count} = new WebFXTreeItem(\'#{subtree.label}\',\'#{subtree.url}\'," \
          +"\'#{subtree.target}\', \'#{subtree.icon}\', \'#{subtree.openIcon}\' );\r\n"
       tree_html += "#{parentName}.add(#{parentName}_#{count});\r\n"
       if not subtree.leaf? 
           subcount=1
           subtree.each do |subsub|
              tree_html+=gen_item(subsub,"#{parentName}_#{count}",subcount)
              subcount +=1
           end
       end
       return tree_html
    end
    
    def gen_tree(tree)
      tree_html = "<LINK href='/stylesheets/xtree20.css' rel='stylesheet' type='text/css'>"    
      tree_html += "<script script type='text/javascript' src='/javascripts/xtree20.js'> </script> "
      
      tree_html += "<script type='text/javascript'>\r\n"
      tree_html += "var root = new WebFXTree('#{tree.label}','#{tree.url}',"\
                       +"'classic', \'#{tree.icon}\',  \'#{tree.openIcon}\' );\r\n"
      tree.each do |subtree|
        tree_html += gen_item(subtree,'root',1)
      end
      tree_html +="root.setBehavior('classic');\r\n"
      tree_html +="document.write(root);\r\n"
      tree_html +="</script>\r\n"
    end

public

     def js_treeview_tag(treeview)
        if not treeview.is_a?(FsTreeModel::Treeview)
            return "tree generation not support for type #{treeview.class}"
        end
        return gen_tree(treeview)
      end
      
     def treeview_tag(treeviewModel,callBackObj=nil)
          return "tree generation not support yet"
            
#          约定 可以是任何类型的对象，但必须接受回调方法: onTreeStateChanged(TreeviewEvent) 否则不产生回调动作

     end
end