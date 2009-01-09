

--配置项管理菜单


--一级菜单
insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('10','web综合查询','0','1','N','18000'); 

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('11','web事件记录','0','2','N','18001'); 

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('12','web配置项变更','0','3','N','18002'); 

--二级菜单
insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1001','配置项清单','10','1','N','18003');

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1002','产品信息','10','2','N','18004');

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1101','事件处理','11','1','N','18005');

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1102','事件记录查询','11','2','N','18006');

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1201','配置项变更处理','12','1','N','18007');

insert into RT_FUNCTION_GROUP 
(FUNC_GROUP_ID,FUNC_GROUP_NAME,UP_GROUP_ID,ORDER_COL,DEL_FLAG,ID) 
values('1202','配置项变更查询','12','2','N','18008');

--功能菜单_功能参数维护
insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('100101','1001','配置项分类查询','','/scm','N','1','','','','N','/collquery/query/config_query',24000);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('100201','1002','软件产品配置信息查询一','','/scm','N','1','','','','N','/collquery/query/product_query_one',24001);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('100202','1002','软件产品配置信息查询二','','/scm','N','2','','','','N','/collquery/query/product_query_two',24002);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('110101','1101','事件记录录入及处理','','/scm','N','1','','','','N','/event/note/event_note',24003);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('110201','1102','事件记录查询','','/scm','N','1','','','','N','/event/query/note_query?flag=1',24004);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('120101','1201','配置项变更处理','','/scm','N','1','','','','N','/item/query/item_change',24005);

insert into RT_SYSTEM_FUNCTION 
(FUNC_ID,FUNC_GROUP_ID,FUNC_NAME,DATASOURCE,TARGET,ISHAVECHILD,ORDER_COL,FILTER_COL,IS_FILTER,IS_DEPT,DEL_FLAG,FUNC_PARAM,ID)
values
('120201','1202','配置项变更查询','','/scm','N','1','','','','N','/item/query/item_query',24006);


--配置项管理授权

insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2000,100101,'SA',null,'N','3',100);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2001,100201,'SA',null,'N','3',101);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2002,100202,'SA',null,'N','3',102);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2003,110101,'SA',null,'N','3',103);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2004,110201,'SA',null,'N','3',104);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2005,120101,'SA',null,'N','3',105);
insert into RT_POSITION_RIGHT_ITEM (ROW_ID,FUNC_ID,PERSON_CLASS_CODE,RIGHT_ITEM_ID,FLAG,GRANT_TYPE,ID) values(2006,120201,'SA',null,'N','3',106);
