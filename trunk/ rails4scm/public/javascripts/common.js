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