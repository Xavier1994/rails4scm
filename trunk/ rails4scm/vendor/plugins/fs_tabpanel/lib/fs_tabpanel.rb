# FsTabpanel

require 'log4r'

module FsTabPanel

public

#tab 标签，blocks 是一个结构数组，结构单元为以下形式：显示名称，卡片页div名，是否显示(true,false)
#              selectedTab 是选中卡片的div名
#              callBackObj 可以是任何类型的对象，但必须接受回调方法: onTabChange(blockName) 否则不产生回调动作 
#在tab_begin和tab_end标签之间，使用 tabpage_begin和tabpage_end标签依次输出每个tabpage页，使用div形式，不一定都可见

    def tab_begin(blocks,selectedTab=nil,callBackObj=nil, borderColor="#00CC33")
      result_html = "<LINK href='#{getTabPanelCSS()}' rel='stylesheet' type='text/css'>\r\n"    
#JAVAscript用于切换各个卡片的可见性
      result_html+="<script type='text/javascript'>\r\n"
      result_html+=" function selectTab(tabName)\r\n"
      result_html+=" {\r\n"
      result_html+="   alert(tabName); \r\n"     #todo:将tabLabel记录到selectedTabIndx隐藏列中，同时设置各个DIV的可见性
      result_html+=" }\r\n"
      result_html+="</script>\r\n"

      model=TabPanelModel.new(blockNames, selectedTab)  #使用模型类，以便于加工各类信息
      
      result_html+="<input type='hidden', id='selectedTabIndx' value=#{selectedTab}> </input>\r\n"   #使用hidden字段保存选中的卡片

      result_html+="<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"#{style}\"> \r\n"
      result_html+="<tr>"
			result_html+='<td height="26" colspan="3" bgcolor="#F5F5F5">\r\n'
 #输出卡片标题      
      model.renderTabHeads()
      
 			result_html+='</td>\r\n'
  		result_html+='</tr>\r\n'

      result_html+=' <tr>'
      result_html+='	   <td height="2" bgcolor="#7CA48F" colspan="3"></td>'
      result_html+=' <tr>'
      result_html+=' </tr>'
      result_html+='	  <td height="3" bgcolor="#7CA48F" colspan="3" ></td>'
      result_html+=' </tr>\r\n'
      
#  DIV块的左侧包围框
      result_html+='<tr>\r\n'
      result_html+='	 <td width="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+='	 <td align="left" id="--leftComposer--" valign="top">\r\n'
    
#在tab_begin和tab_end标签之间，使用 tabpage_begin和tabpage_end标签依次输出每个tabpage页，使用div形式，不一定都可见。代码类似如下：
#代码类似如下：
		# result_html+="		<div id=#{model.lable} style='overflow:auto;vertical-align:top'> "
		# result_html+='			Page 1 content here'
		# result_html+='		</div>'
      
    return result_html
  end

#tab标签结束
    def tab_end()
   #  DIV块的右侧包围框
      result_html+='	</td>\r\n'
      result_html+='	<td id="--rightComposer--" width="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+= '</tr>\r\n'   #卡片页内容结束
   # 输出底线    
      result_html+='<tr>\r\n'
      result_html+='	<td colspan="3" height="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+='</table> \r\n'
    end

#tabpage标签开始，输出div头，blockName将作为此div的ID，如果当前页选中则输出之，否则隐藏起来
    def tabpage_begin(blockName,selected=false)
        dispStyle=selected?"block":"none"
        result_html="		<div id=#{blockName} style='overflow:auto;vertical-align:top;display:#{dispStyle}'> "
        # result_html+='			Page 1 content here'    这个在rhtml中输出之
        return result_html
    end

    def tabpage_end()
        return '		</div>'
    end

    def getTabPanelCSS()
        #context=this.getPage().getRequestCycle().getRequestContext().getRequest().getContextPath();
        return  "/stylesheets/tabpage_style.css";  
   end

protected

   include Log4r
   class TabPanelModel
      attr_accessor :borderColor,:selectedColor,:unselectedColor
      attr_accessor :blockLabels,:blockNames,:selectedBlockName
      
#构造函数。 selectedTab是卡片的name
     def initialize(blockDefs, selectedTab=nil)  
          setBlocksValue(blockDefs);
          if selectedTab==nil
             setSelectedBlockName(getBlockNames()[0]);
          else
             setSelectedBlockName(selectedTab);
           end
      end

#依次输出各个卡片的标题
     def renderTabHeads()
        result_html+='	<table border="0" cellspacing="0" cellpadding="0" class=tablink>\r\n'
        result_html+='		<tr>\r\n'
        result_html+='			<td align="left" width="12">\r\n'
        result_html+="				<img src=\"#{getBeginImg()}\" height='27' width='12' />\r\n"
        result_html+="   </td>\r\n"
  #依次输出卡片标题 ,每个都有前导和后续位图     
        for i in(0..blockLabels.size) 
          result_html="	    <td background='#{getMidImg(i)}' height='27'>"
          linkstyle= isSelected?(i) ? "title_menu":"title_menu_uncur";
          result_html+="				<a class='#{linkStyle}'  onclick='javascript:selectTab(#{blockNames[i]})'> "
          result_html+="				    #{blockLabels[i]}  "
          result_html+='				</a>'
          result_html+='			</td>'

          result_html+='			<td width="30" align="right">\r\n'
          result_html+="				<img src='#{getRightImg(i)}' height='27' width='30' />\r\n"
          result_html+='			</td>\r\n'
          result_html+='		</tr>\r\n'
          result_html+='		</table>\r\n'
        end      
      end # of renderTabHeads()

     def setBlocksValue(blockDefs)
        num = blockDefs.size/3;
        names =[];
        labels = [];
       for  j in (0..num)
            label = blockDefs.get(j*3);
            name = blockDefs.get(j*3+1);
            visible = blockDefs.get(j*3+2);
            
            if downcase(visible)=="true" 
                setSelectedBlockName(name);
            end
            names[j]=name
            labels[j]=label
        end
        
        setBlockNames(names);
        setBlockLabels(labels);
        Logger["USER"].trace("++++TabPanel 拆分参数完毕！++++names size=#{names.size},labelsize=#{labels.size}");
    end # of fuction setBlocksValue

#判断当前tab是否被选中
     def isSelected?(index)
        if getBlockLabels()==nil||getBlockNames()==nil
             Logger["USER"].warn("[tabPanel组件]无法获取卡片页定义in 函数isSelected?(index)");
            return false;
        end
        if index<0||index>=getBlockNames().size then
             Logger["USER"].warn("[tabPanel组件]调用函数isSelected?(index), 数组越界");
             return false;
        end
        if getSelectedBlockName()==nil 
            setSelectedBlockName(getBlockNames()[0]);
        end

        return upcase(getBlockNames()[index]) ==upcase(getSelectedBlockName());
    end # of fcntion isSelected?(blockLabel)
      
#判断选中的是否是第一个block
    def selectedIsFirstBlock?()
        if getSelectedBlockName()==nil 
            setSelectedBlockName(getBlockNames()[0]);
        end

        selectedBlockName = getSelectedBlockName();
        firstBlockName = getBlockNames()[0];
        return upcase(selectedBlockName)==upcase(firstBlockName);
    end
    
#判断是否是最后一个block
    def isLastBlock?(index)
         return index == blockLabels.size-1;
    end 
    
# 如果不是最后一个block，判断下一个block是否是selected
     def nextIsSelected(index)
         if getSelectedBlockName()==nil 
            setSelectedBlockName(getBlockNames()[0]);
         end

        if index<0||index>getBlockNames.size|| isLastBlock(index) 
            return false;
        else
            return upcase(getBlockNames()[index+1])==upcase(getSelectedBlockName());
        end
    end #of fuction nextIsSelected
    
     #~ <context-asset name="selectedBeginImage" path="/images/tabimage/tab_cur_bg.gif"/>
     #~ <context-asset name="unSelectedBeginImage" path="/images/tabimage/tab_bg.gif"/>
    
    #~ <context-asset name="selectedMidImage" path="/images/tabimage/card_l_m.gif"/>
    #~ <context-asset name="unSelectedMidImage" path="/images/tabimage/card_h_m.gif"/>
    
    #~ <context-asset name="selectedToUnselectedRightImage" path="/images/tabimage/tab_hlrt.gif"/>
    #~ <context-asset name="unselectedToSelectedRightImage" path="/images/tabimage/tab_hllt.gif"/>
    #~ <context-asset name="unselectedToUnselectedRightImage" path="/images/tabimage/tab_dmrt.gif"/>
    
    #~ <context-asset name="SelectedRightImage" path="/images/tabimage/tab_hlrt_end.gif"/>
	  #~ <context-asset name="unSelectedRightImage" path="/images/tabimage/tab_dmrt_end.gif"/>
            
    def getBeginImage()
        if selectedIsFirstBlock?()
            return "/images/tabimage0/tab_cur_bg.gif"  # "selectedBeginImage");
        else 
            return "/images/tabimage0/tab_bg.gif"        #"unSelectedBeginImage");
        end
    end 
   
    def getMidImage(index)
        if isSelected?(index) 
            return "/images/tabimage0/card_l_m.gif"    # ("selectedMidImage");
        else 
             return "/images/tabimage0/card_h_m.gif"   #("unSelectedMidImage");
        end
     end
    
    def getRightImage(index)
        if isSelected?(index)
            if isLastBlock(index) 
                return "/images/tabimage0/tab_hlrt_end.gif"  #("SelectedRightImage");
            else
                return "/images/tabimage0/tab_hlrt.gif"        #("selectedToUnselectedRightImage");
            end
        else 
            if isLastBlock(index) 
                  return "/images/tabimage0/tab_dmrt_end.gif"  # ("unSelectedRightImage");
            elsif  !nextIsSelected(index) #下一个block也是非选中的
                  return "/images/tabimage0/tab_dmrt.gif"    # ("unselectedToUnselectedRightImage");
            else #下一个block是选中的
                   return "/images/tabimage0/tab_hllt.gif"     #("unselectedToSelectedRightImage");
            end 
        end # of if selected?
    end #of getRightImage

  end #of class TabPanelModel classdef

end # of module FsTabPanel
