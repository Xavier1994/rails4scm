# FsTabpanel

require 'log4r'

module FsTabPanel
 
public

#tab ��ǩ��blocks ��һ���ṹ���飬�ṹ��ԪΪ������ʽ����ʾ���ƣ���Ƭҳdiv�����Ƿ���ʾ(true,false)
#              selectedTab ��ѡ�п�Ƭ��div��
#              callBackObj �������κ����͵Ķ��󣬵�������ܻص�����: onTabChange(blockName) ���򲻲����ص����� 
#��tab_begin��tab_end��ǩ֮�䣬ʹ�� tabpage_begin��tabpage_end��ǩ�������ÿ��tabpageҳ��ʹ��div��ʽ����һ�����ɼ�

    def tab_begin(blocks,selectedTab=nil,callBackObj=nil, borderColor="#00CC33")
      model=TabPanelModel.new(blocks, selectedTab)  #ʹ��ģ���࣬�Ա��ڼӹ�������Ϣ
   
      result_html = "<LINK href='#{getTabPanelCSS()}' rel='stylesheet' type='text/css'>\r\n"
      #JAVAscript�����л�������Ƭ�Ŀɼ���
      result_html += model.getJavascript()

      #�����table  ���� ��right01.gif�� ���� ��tb.gif   ���濨Ƭ�������rightb01.gif��
      result_html+="<table width='100%' cellpadding='0' cellspacing='0' border='0' height='100%'>\r\n"
      result_html+="	<tr>\r\n"
      result_html+="		<td width='14'><img border='0' src='/images/tabimage/right01.gif' width='14' height='40'></td>\r\n"
      result_html+="		<td height=26 valign='bottom' background='/images/tabimage/tb.gif'>\r\n"
      result_html+="			<table cellpadding='0'  cellspacing='0'  border='0' width='100%'>\r\n"
      result_html+="				<tr>\r\n"
      result_html+="					<td>\r\n"
      
      #���ؿ�Ƭҳ����
      head = model.renderTabHeads(selectedTab);
      if(head != nil) then
        result_html+=head
      end
      
      result_html+="					</td>\r\n"
      result_html+="				</tr>\r\n"
      result_html+="				<tr>\r\n"
      result_html+="					<td background='/images/tabimage/rightb01.gif' height='6'></td>\r\n"
      result_html+="				</tr>\r\n"
      result_html+="			</table>\r\n"
      result_html+="		</td>\r\n"
      result_html+="		<td width='15'><img border='0' src='/images/tabimage/right02.gif' width='15' height='40'></td>\r\n"
      result_html+="	</tr>\r\n"
      result_html+="	<tr>\r\n"
      result_html+="		<td  width='14' background='/images/tabimage/right01b.gif' height='100%'>&nbsp;</td>\r\n"
      result_html+="		<td align=left valign=top  height='100%' bgcolor='#ffffff'>\r\n"
      
      return result_html
    end

    #tab��ǩ����
    def tab_end()
      result_html ="		</td>\r\n"
      result_html+="		<td  width='15' background='/images/tabimage/right02b.gif' height='100%'>&nbsp;</td>\r\n"
      result_html+="	</tr>\r\n"
      result_html+="	<tr>\r\n"
      result_html+="		<td  width='14' background='/images/tabimage/right01d.gif' height='8'></td>\r\n"
      result_html+="		<td background='/images/tabimage/rightb02.gif' height='8'></td>\r\n"
      result_html+="		<td  width='15' background='/images/tabimage/right02d.gif' height='8'></td>\r\n"
      result_html+="	</tr>\r\n"
      result_html+="</table>\r\n" 
      
      return result_html
    end

    #tabpage��ǩ��ʼ�����divͷ��blockName����Ϊ��div��ID�������ǰҳѡ�������֮��������������
    def tabpage_begin(blockName,isSelected=false)
        dispStyle=(isSelected ? "block" : "none")
        result_html="		<div id=#{blockName} style='overflow:auto;vertical-align:top;display:#{dispStyle}'> "
        # result_html+="			Page 1 content here'    �����rhtml�����֮
        return result_html
    end

    def tabpage_end()
        return "		</div>"
    end

    def getTabPanelCSS() 
      #context=this.getPage().getRequestCycle().getRequestContext().getRequest().getContextPath();
      return  "/stylesheets/common_style.css"; 
    end

protected

   include Log4r
 
   class TabPanelModel
     
      attr_accessor :borderColor,:selectedColor,:unselectedColor
      attr_writer :blockLabels,:blockNames,:selectedBlockName
      
     #���캯���� selectedTab�ǿ�Ƭ��name
     def initialize(blockDefs, selectedTab=nil)  
          setBlocksValue(blockDefs);
          if selectedTab==nil
             @selectedBlockName =@blockNames[0];
          else
             @selectedBlockName =selectedTab;
           end
      end

     #�������������Ƭ�ı���
     def renderTabHeads(selectedTab)
       begin
         result_html="                                        <div id='fs_tabpanel_head_div' align='left'>\r\n"
         result_html+="						<table cellpadding='0'  cellspacing='0'  border='0'>\r\n" 
         result_html+="							<tr>\r\n" 
         #���ж��ǵڼ�����ѡ��
         j = 0;
         if(selectedTab == nil) then
           selectedTab = @blockNames[0]
         end
         for i in (0 .. @blockNames.size-1) 
           name = @blockNames[i]
           if name == selectedTab then
             j = i
             break
           end
         end
         
         for i in (0 .. @blockNames.size-1) 
            name = @blockNames[i]
            lbnm = @blockLabels[i]
            #linkstyle= self.isSelected?(i)  ?  "title_menu":"title_menu_uncur";
            if i == 0 then
                if j == i then
                  result_html+="								<td><img border='0' src='/images/tabimage/card_l_l_01.gif' width='27' height='27'></td>\r\n"
                else
                  result_html+="								<td><img border='0' src='/images/tabimage/card_h_l_01.gif' width='27' height='27'></td>\r\n"
                end
            end
                
            if i == j then
               result_html+="								<td background='/images/tabimage/card_l_m.gif' nowrap align='center'>\r\n"
            else
               result_html+="								<td background='/images/tabimage/card_h_m.gif' nowrap align='center'>\r\n"
            end
            result_html+="								   <font color='#7CA48F'><b><a onclick=\"javascript:selectTab('#{name}')\">#{lbnm}</a></b></font>\r\n"
            if i != @blockNames.size-1 then
                if j == 0 and i == 0 then
                   result_html+="								<td><img border='0' src='/images/tabimage/card_l_r_01.gif' width='27' height='27'></td>\r\n"
                else
                   if (i+1) == j then
                     result_html+="								<td><img border='0' src='/images/tabimage/card_l_l_02.gif' width='27' height='27'></td>\r\n"
                   else
                     if i == j then
                        result_html+="								<td><img border='0' src='/images/tabimage/card_l_r_01.gif' width='27' height='27'></td>\r\n"
                     else
                        result_html+="								<td><img border='0' src='/images/tabimage/card_h_l_02.gif' width='27' height='27'></td>\r\n"
                     end
                   end
                end
            end

            if i == @blockNames.size-1 then
                if i == j then
                  result_html+="								<td><img border='0' src='/images/tabimage/card_l_r_02.gif' width='27' height='27'></td>\r\n"
                else
                  result_html+="								<td><img border='0' src='/images/tabimage/card_h_r_02.gif' width='27' height='27'></td>\r\n"
                end
            end
         end

         result_html+="							</tr>\r\n"
         result_html+="						</table>\r\n"
         result_html+="                                        </div>"
         return result_html
       rescue Exception
         return nil
       end 
      end # of renderTabHeads()
      
     #����javascript�ű������ڵ����Ƭҳ��ʾ���ǲ���ʾ
     def getJavascript()
       result_html="<script language=\"Javascript\">\r\n"
       
       result_html+="   blockNames  = new Array();\r\n"
       result_html+="   blockLabels = new Array();\r\n"
       result_html+="   selectIndex = 0;\r\n"
       for i in (0 .. @blockNames.size-1) 
           result_html+="   blockNames[#{i}]  = \"#{@blockNames[i]}\";\r\n"
           result_html+="   blockLabels[#{i}] = \"#{@blockLabels[i]}\";\r\n"
       end
       
       result_html+=" function selectTab(tabName)\r\n"
       result_html+=" {\r\n"
       result_html+="   for(i=0;i<blockNames.length;i++){ \r\n"
       result_html+="     tab = document.getElementById(blockNames[i]);\r\n"
       result_html+="     if(blockNames[i] == tabName){\r\n"
       result_html+="     selectIndex = i;\r\n"
       result_html+="       try{\r\n"
       result_html+="         tab.style.display=\"block\";\r\n"
       result_html+="       }catch(e) {\r\n"
       result_html+="         continue;\r\n"
       result_html+="       }\r\n"
       result_html+="     }else {\r\n"
       result_html+="       try{\r\n"
       result_html+="         tab.style.display=\"none\";\r\n"
       result_html+="       }catch(e) {\r\n"
       result_html+="         continue;\r\n"
       result_html+="       }\r\n"
       result_html+="     } \r\n"
       result_html+="   } \r\n"
       result_html+="   fstabpanelheaddiv = document.getElementById(\"fs_tabpanel_head_div\");\r\n"
       result_html+="   fstabpanelheaddiv.innerHTML = fs_tabpanel_callback(selectIndex);\r\n" 
       result_html+=" }\r\n"
       result_html+=" \r\n"
       result_html+= fs_tabpanel_callback()
       result_html+=" \r\n"
       result_html+="</script>\r\n"
       
       return result_html;
     end
     
     #ѡ��ĳ����Ƭ��ʱ��
     def fs_tabpanel_callback()
             result_html="  function fs_tabpanel_callback(selectIndex) {\r\n"
             result_html+="    text = '';\r\n"
             result_html+="    text+= \"                                     <div id='fs_tabpanel_head_div' align='left'>\";\r\n"
             result_html+="    text+= \" 				       <table cellpadding='0'  cellspacing='0'  border='0'>\";\r\n" 
             result_html+="    text+= \"						<tr>\";\r\n"
             result_html+="    if (selectIndex == ''){\r\n"
             result_html+="      selectIndex=0; \r\n"
             result_html+="    }\r\n"
             result_html+="    var j = 0;\r\n"              
             result_html+="    for (i=0;i< blockNames.length;i++){ \r\n"
             result_html+="       name = blockNames[i];\r\n"
             result_html+="       lbnm = blockLabels[i];\r\n"
             #linkstyle= self.isSelected?(i)  ?  "title_menu":"title_menu_uncur";
             result_html+="       if (i == 0){\r\n"
             result_html+="          if (selectIndex == i){\r\n"
             result_html+="    text+= \"								<td><img border='0' src='/images/tabimage/card_l_l_01.gif' width='27' height='27'></td>\";\r\n"
             result_html+="          }else{\r\n"
             result_html+="    text+= \"								<td><img border='0' src='/images/tabimage/card_h_l_01.gif' width='27' height='27'></td>\";\r\n"
             result_html+="          }\r\n"
             result_html+="        }\r\n"
             result_html+="       if (i == selectIndex){\r\n"
             result_html+="    text+= \"								<td background='/images/tabimage/card_l_m.gif' nowrap align='center'>\";\r\n"
             result_html+="       }else{\r\n"
             result_html+="    text+= \"								<td background='/images/tabimage/card_h_m.gif' nowrap align='center'>\";\r\n"
             result_html+="       }\r\n"
             result_html+="    text+=\" 							   <font color='#7CA48F'><b><a onclick=javascript:selectTab('\" + name + \"')>\" + lbnm + \"</a></b></font>\";\r\n"
             result_html+="       if (i != blockNames.length-1){\r\n"
             result_html+="          if (i == 0 && selectIndex == 0){\r\n"
             result_html+="		text+= \"						<td><img border='0' src='/images/tabimage/card_l_r_01.gif' width='27' height='27'></td>\";\r\n"
             result_html+="          }else {\r\n"
             result_html+="             if ((i+1) == selectIndex){\r\n"
             result_html+="			text+= \"					<td><img border='0' src='/images/tabimage/card_l_l_02.gif' width='27' height='27'></td>\";\r\n"
             result_html+="             }else{\r\n"
             result_html+="                if (i == selectIndex){\r\n"
             result_html+="			text+= \"					<td><img border='0' src='/images/tabimage/card_l_r_01.gif' width='27' height='27'></td>\";\r\n"
             result_html+="                }else{\r\n"
             result_html+="			text+= \"					<td><img border='0' src='/images/tabimage/card_h_l_02.gif' width='27' height='27'></td>\";\r\n"
             result_html+="                }\r\n"
             result_html+="             }\r\n"
             result_html+="          }\r\n"
             result_html+="       }\r\n"
             result_html+="       if (i == blockNames.length-1){\r\n"
             result_html+="          if (i == selectIndex){\r\n"
             result_html+="		text+= \"						<td><img border='0' src='/images/tabimage/card_l_r_02.gif' width='27' height='27'></td>\";\r\n"
             result_html+="          }else{\r\n"
             result_html+="		text+= \"						<td><img border='0' src='/images/tabimage/card_h_r_02.gif' width='27' height='27'></td>\";\r\n"
             result_html+="          }\r\n"
             result_html+="       }\r\n"
             result_html+="    }\r\n"

             result_html+="    text += \"							</tr>\";\r\n"
             result_html+="    text += \"						</table>\";\r\n"
             result_html+="    text += \"                                        </div>\";\r\n"
             result_html+="    return text\r\n"
             result_html+="  }\r\n"
             
             return result_html
     end
  
     def setBlocksValue(blockDefs)
        num = blockDefs.size/3;
        names =[];
        labels = [];
        for  j in (0 .. num-1)
            label = blockDefs[j*3];
            name = blockDefs[j*3+1];
            isVisible = blockDefs[j*3+2];
            if isVisible then
                @selectedBlockName =name;
            end
            names[j]=name
            labels[j]=label
        end
        
        @blockNames=names;
        @blockLabels=labels;
        Log4r::Logger["USER"].debug("++++TabPanel ��ֲ�����ϣ�++++names size=#{names.size} andlabelsize=#{labels.size}");
    end # of fuction setBlocksValue

    def isStringEqual?(str1,str2)
        if str1==nil then str1='--NULL--'; end
        if str2==nil then str1='--NULL--'; end
        return str1.upcase()==str2.upcase();
      end 
      
    #�жϵ�ǰtab�Ƿ�ѡ��
     def isSelected?(index)
        if @blockLabels==nil||@blockNames==nil
            Log4r::Logger["USER"].warn("[tabPanel���]�޷���ȡ��Ƭҳ����in ����isSelected?(index)");
            return false;
        end
        if index<0||index>=@blockNames.size then
             Log4r::Logger["USER"].warn 'erro calling isSelected ()method for tabPanel component: index out of bound!'
             return false 
        end
        if @selectedBlockName==nil 
            @selectedBlockName=@blockNames[0];
        end

        return isStringEqual?(@blockNames[index],@selectedBlockName);
    end # of fcntion isSelected?(blockLabel)
      
#�ж�ѡ�е��Ƿ��ǵ�һ��block
    def selectedIsFirstBlock?()
        if @selectedBlockName==nil 
            @selectedBlockName= @blockNames[0];
        end

        firstBlockName = @blockNames[0];
        return isStringEqual?(@selectedBlockName,firstBlockName);
    end
    
#�ж��Ƿ������һ��block
    def isLastBlock?(index)
         return index == @blockNames.size-1;
    end 
    
# ����������һ��block���ж���һ��block�Ƿ���selected
    def nextIsSelected?(index)
         if @selectedBlockName==nil 
            @selectedBlockName=@blockNames[0];
         end

        if index<0||index>@blockNames.size|| isLastBlock?(index) 
            return false;
        else
            return isStringEqual?(@blockNames[index+1],@selectedBlockName);
        end
    end #of fuction nextIsSelected
    
          
    def getBeginImg()
        if selectedIsFirstBlock?()
            '/images/tabimage0/tab_cur_bg.gif'   # selectedBeginImage;
        else 
            '/images/tabimage0/tab_bg.gif'        #unSelectedBeginImage;
        end
    end 
   
    def getMidImg(index)
        if isSelected?(index) 
            '/images/tabimage0/card_l_m.gif'    #selectedMidImage;
        else 
            '/images/tabimage0/card_h_m.gif'   #unSelectedMidImage;
        end
     end
    
    def getRightImg(index)
        if isSelected?(index)
            if isLastBlock?(index) 
                return '/images/tabimage0/tab_hlrt_end.gif'  #SelectedRightImage;
            else
                return '/images/tabimage0/tab_hlrt.gif'        #selectedToUnselectedRightImage;
            end
        else 
            if isLastBlock?(index) 
                  return '/images/tabimage0/tab_dmrt_end.gif'  #unSelectedRightImage;
            elsif  !nextIsSelected?(index) #��һ��blockҲ�Ƿ�ѡ�е�
                  return '/images/tabimage0/tab_dmrt.gif'        # unselectedToUnselectedRightImage;
            else #��һ��block��ѡ�е�
                   return '/images/tabimage0/tab_hllt.gif'     #unselectedToSelectedRightImage;
            end 
        end # of if selected?
    end #of getRightImage

  end #of class TabPanelModel classdef

end # of module FsTabPanel
