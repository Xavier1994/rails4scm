//��ʾ
function show(o,obj,obj1){
  var m=document.getElementById(obj);
  m.style.pixelLeft=getL(o);
  m.style.pixelTop=getT(o); 
  m.style.visibility='';
  var m1=document.getElementById(obj1);
  m1.style.visibility='hidden';
}
//����
function hide(obj,obj1){
    document.getElementById(obj).style.visibility='hidden';
    document.getElementById(obj1).style.visibility='';
}   
//ȡ����ߵ�λ��
function getL(e){
  var l=e.offsetLeft;
  while(e=e.offsetParent){
    l+=e.offsetLeft;
  }
  return l;
}
//ȡ�ö�����λ��
function getT(e){
  var t=e.offsetTop;
  while(e=e.offsetParent){
    t+=e.offsetTop;
  }
  return t;
} 

 //ȥ���ո�
function jsTrim(strText){ 
   return strText.replace(/(^\s*|\s*$)/g,"")
}