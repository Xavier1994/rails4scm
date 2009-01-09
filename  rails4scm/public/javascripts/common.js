//显示
function show(o,obj,obj1){
  var m=document.getElementById(obj);
  m.style.pixelLeft=getL(o);
  m.style.pixelTop=getT(o); 
  m.style.visibility='';
  
  var m1=document.getElementById(obj1);
  m1.style.visibility='hidden';
}
//隐藏
function hide(obj,obj1){
    document.getElementById(obj).style.visibility='hidden';
    document.getElementById(obj1).style.visibility='';
}   
//取得左边的位移
function getL(e){
  var l=e.offsetLeft;
  while(e=e.offsetParent){
    l+=e.offsetLeft;
  }
  return l;
}
//取得顶部的位移
function getT(e){
  var t=e.offsetTop;
  while(e=e.offsetParent){
    t+=e.offsetTop;
  }
  return t;
} 

//去处空格
function jsTrim(strText){ 
   return strText.replace(/(^\s*|\s*$)/g,"")
}

/*
用途：检查数字
*/
function isNumber( s ){   	
    var regu = "^[0-9]+$";
    var re = new RegExp(regu);
    if (s.search(re) != -1) {
            return true;
    } else { 
            return false;
    }
}

/*
用途：检查输入对象的值是否符合整数格式
输入：str 输入的字符串
返回：如果通过验证返回true,否则返回false
*/
function isInteger( str ){  
        if(str.indexOf(".") > -1) {
                return 1;
        }
        if(str.indexOf("-") > -1) {
                return 2;
        }
        if(str.indexOf("+") > -1) {
                return 3;
        }  
        if(isNumber(str) == false) {
                return 5;    
        } 
        if(isNaN(str)) {    
                return 4;
        }else {
                return 0;
        } 
}