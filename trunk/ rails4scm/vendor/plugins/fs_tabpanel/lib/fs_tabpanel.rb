# FsTabpanel

require 'log4r'

module FsTabPanel

public

#tab ��ǩ��blocks ��һ���ṹ���飬�ṹ��ԪΪ������ʽ����ʾ���ƣ���Ƭҳdiv�����Ƿ���ʾ(true,false)
#              selectedTab ��ѡ�п�Ƭ��div��
#              callBackObj �������κ����͵Ķ��󣬵�������ܻص�����: onTabChange(blockName) ���򲻲����ص����� 
#��tab_begin��tab_end��ǩ֮�䣬ʹ�� tabpage_begin��tabpage_end��ǩ�������ÿ��tabpageҳ��ʹ��div��ʽ����һ�����ɼ�

    def tab_begin(blocks,selectedTab=nil,callBackObj=nil, borderColor="#00CC33")
      result_html = "<LINK href='#{getTabPanelCSS()}' rel='stylesheet' type='text/css'>\r\n"    
#JAVAscript�����л�������Ƭ�Ŀɼ���
      result_html+="<script type='text/javascript'>\r\n"
      result_html+=" function selectTab(tabName)\r\n"
      result_html+=" {\r\n"
      result_html+="   alert(tabName); \r\n"     #todo:��tabLabel��¼��selectedTabIndx�������У�ͬʱ���ø���DIV�Ŀɼ���
      result_html+=" }\r\n"
      result_html+="</script>\r\n"

      model=TabPanelModel.new(blockNames, selectedTab)  #ʹ��ģ���࣬�Ա��ڼӹ�������Ϣ
      
      result_html+="<input type='hidden', id='selectedTabIndx' value=#{selectedTab}> </input>\r\n"   #ʹ��hidden�ֶα���ѡ�еĿ�Ƭ

      result_html+="<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"#{style}\"> \r\n"
      result_html+="<tr>"
			result_html+='<td height="26" colspan="3" bgcolor="#F5F5F5">\r\n'
 #�����Ƭ����      
      model.renderTabHeads()
      
 			result_html+='</td>\r\n'
  		result_html+='</tr>\r\n'

      result_html+=' <tr>'
      result_html+='	   <td height="2" bgcolor="#7CA48F" colspan="3"></td>'
      result_html+=' <tr>'
      result_html+=' </tr>'
      result_html+='	  <td height="3" bgcolor="#7CA48F" colspan="3" ></td>'
      result_html+=' </tr>\r\n'
      
#  DIV�������Χ��
      result_html+='<tr>\r\n'
      result_html+='	 <td width="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+='	 <td align="left" id="--leftComposer--" valign="top">\r\n'
    
#��tab_begin��tab_end��ǩ֮�䣬ʹ�� tabpage_begin��tabpage_end��ǩ�������ÿ��tabpageҳ��ʹ��div��ʽ����һ�����ɼ��������������£�
#�����������£�
		# result_html+="		<div id=#{model.lable} style='overflow:auto;vertical-align:top'> "
		# result_html+='			Page 1 content here'
		# result_html+='		</div>'
      
    return result_html
  end

#tab��ǩ����
    def tab_end()
   #  DIV����Ҳ��Χ��
      result_html+='	</td>\r\n'
      result_html+='	<td id="--rightComposer--" width="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+= '</tr>\r\n'   #��Ƭҳ���ݽ���
   # �������    
      result_html+='<tr>\r\n'
      result_html+='	<td colspan="3" height="5" bgcolor="#7CA48F"></td>\r\n'
      result_html+='</table> \r\n'
    end

#tabpage��ǩ��ʼ�����divͷ��blockName����Ϊ��div��ID�������ǰҳѡ�������֮��������������
    def tabpage_begin(blockName,selected=false)
        dispStyle=selected?"block":"none"
        result_html="		<div id=#{blockName} style='overflow:auto;vertical-align:top;display:#{dispStyle}'> "
        # result_html+='			Page 1 content here'    �����rhtml�����֮
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
      
#���캯���� selectedTab�ǿ�Ƭ��name
     def initialize(blockDefs, selectedTab=nil)  
          setBlocksValue(blockDefs);
          if selectedTab==nil
             setSelectedBlockName(getBlockNames()[0]);
          else
             setSelectedBlockName(selectedTab);
           end
      end

#�������������Ƭ�ı���
     def renderTabHeads()
        result_html+='	<table border="0" cellspacing="0" cellpadding="0" class=tablink>\r\n'
        result_html+='		<tr>\r\n'
        result_html+='			<td align="left" width="12">\r\n'
        result_html+="				<img src=\"#{getBeginImg()}\" height='27' width='12' />\r\n"
        result_html+="   </td>\r\n"
  #���������Ƭ���� ,ÿ������ǰ���ͺ���λͼ     
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
        Logger["USER"].trace("++++TabPanel ��ֲ�����ϣ�++++names size=#{names.size},labelsize=#{labels.size}");
    end # of fuction setBlocksValue

#�жϵ�ǰtab�Ƿ�ѡ��
     def isSelected?(index)
        if getBlockLabels()==nil||getBlockNames()==nil
             Logger["USER"].warn("[tabPanel���]�޷���ȡ��Ƭҳ����in ����isSelected?(index)");
            return false;
        end
        if index<0||index>=getBlockNames().size then
             Logger["USER"].warn("[tabPanel���]���ú���isSelected?(index), ����Խ��");
             return false;
        end
        if getSelectedBlockName()==nil 
            setSelectedBlockName(getBlockNames()[0]);
        end

        return upcase(getBlockNames()[index]) ==upcase(getSelectedBlockName());
    end # of fcntion isSelected?(blockLabel)
      
#�ж�ѡ�е��Ƿ��ǵ�һ��block
    def selectedIsFirstBlock?()
        if getSelectedBlockName()==nil 
            setSelectedBlockName(getBlockNames()[0]);
        end

        selectedBlockName = getSelectedBlockName();
        firstBlockName = getBlockNames()[0];
        return upcase(selectedBlockName)==upcase(firstBlockName);
    end
    
#�ж��Ƿ������һ��block
    def isLastBlock?(index)
         return index == blockLabels.size-1;
    end 
    
# ����������һ��block���ж���һ��block�Ƿ���selected
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
            elsif  !nextIsSelected(index) #��һ��blockҲ�Ƿ�ѡ�е�
                  return "/images/tabimage0/tab_dmrt.gif"    # ("unselectedToUnselectedRightImage");
            else #��һ��block��ѡ�е�
                   return "/images/tabimage0/tab_hllt.gif"     #("unselectedToSelectedRightImage");
            end 
        end # of if selected?
    end #of getRightImage

  end #of class TabPanelModel classdef

end # of module FsTabPanel
