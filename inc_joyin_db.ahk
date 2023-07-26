#IfWinActive ahk_class TPLSQLDevForm
	::@cp::
		send, select * from tprod_design_info_pro t where t.prod_ocode = '';
    	send {left}
		send {left}
	return
	

	::@yh::
		send, select * from tuser_info t where t.o_code = '';
    	send {left}
		send {left}
	return

	::@jzjc::
		send, select * from tfund_jzjc t where t.prod_code = '';
    	send {left}
		send {left}
	return

	; 枚举
	::@mj::
		send,
		( 
select t.* from ttab_col_define_enum t where t.col_code = 'PROSTATE';

select *
  from ttab_enum_param_child t
 where t.param_code =
       (select t.param_code
          from (select t.col_format param_code, t.*

                  from ttab_col_define t
                 where t.tab_code = 'INFO_00000003'
                   and t.col_code = 'PROSTATE') t);
    	)
	return
	
	::@bdy::
		send select * from ttab_define t where t.tab_engname = '';
		send {left}
		send {left}
	return

	::$mj::
		send select * from sys_ml_model_option t where t.tab_code = '';
		sleep 500
		send {enter}
		send select col_code, enum_label, enum_value from sys_ml_model_option t where t.tab_code = (select tab_code from sys_ml_model_table tt where tt.tab_name = upper(''));
		sleep 500

		send {enter}
		send select * from SYS_ML_MODEL_ENUM_ITEM t where t.enum_code = (select COLE_DATA_FROM from sys_ml_model_column t where t.col_code = '' and t.tab_code = '');{left 3}
		sleep 500
		^!l
	return



	; 功能列表
	::$gnlb::
		send select * from trpt_define t where t.name like '`%`%';
		send {left}
		send {left}
		send {left}
	return

	; 单据
	::$dj::
		send select regexp_substr(cfg_json, '"fileName":.*docm"'), cfg_json  from sys_inv t where t.name like '`%`%';
		send {left}
		send {left}
		send {left}
	return

	; 列定义
	::$ldy::
		send select * from sys_ml_model_column t where t.tab_code = '';
		send {Enter}
		send select * from sys_ml_model_column t where t.col_name like '`%`%';
		send {left}
		send {left}
		send {left}
	return

	; 表定义
	::$bdy::
		send select * from sys_ml_model_table t where t.tab_chsname like '`%`%';
		send {left}
		send {left}
		send {left}
	return

	; 代理
	::$dl::
		if not WinExist("ahk_class SoPY_Comp") {
			send select t.*, rowid from sys_wf_mp_proxy t where t.proxy_name like '`%`%';
			send {left}
			send {left}
			send {left}
		}
	return

	::$cp::
		send select * from dw_prd_base_info t where t.prd_o_name like '`%`%';
		send {left 3}
	return

	::$jb1::
		send select * from tobject_step_script t where t.otype = '';
		send {left}
		send {left}
	return

	::$bdy+::
		send select * from sys_ml_model_object t where t.o_type = '';
		send {enter}
		send select * from sys_ml_model_table t where t.o_type = '';
		send {enter}
		send select * from sys_ml_model_table t where t.tab_code = '';
		send {enter}
		send select * from sys_ml_model_column t where t.tab_code = '';
	return

	::$bj::
		send select * from sys_ml_layout_rule_object t where t.o_type = '';
		send {left}
		send {left}
	return

	::$yy::
		send select t.*, t.rowid from SYS_APP_CA_USE_SEAL_TYPE t;
		send {enter}
		send select t.*, t.rowid from sys_app_ca_use_seal_strategy t;
		send {enter}
		send select t.*, t.rowid from sys_app_ca_annex_use_seal t;
	return
	
	::$lcmb::
		if not WinExist("ahk_class SoPY_Comp") {
			send select * from sys_wf_template t where t.tmpl_name like '`%`%';
			send {enter}
			send select * from sys_wf_task_base t where t.tmpl_id = '';
		}
	return
	
	::$soh::
		send select t.*, t.rowid from sys_ca_mp_boost t;
		send {enter}
		send select t.*, t.rowid from sys_tp_table_mp_boost t;
	return

	::$pp::
		send select * from sys_task_mp_type for update;
		send {enter}
		send select * from sys_task_schedule for update;
		send {enter}
		send select * from sys_task_log;
	return

	::$ldgz::
		send select * from sys_ml_layout_rule_linkage t where t.tab_code = '';
		send {left}
		send {left}
	return


	
	::$lc::
		if not WinExist("ahk_class SoPY_Comp") {
			send select t.*, t.rowid from sys_app_wf_instance t where t.instance_id = 1844;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_activity t where t.instance_id = 1844 order by t.activity_id asc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_act_permission t where t.instance_id = 1844 order by t.r_id desc;
			send {enter}
			send --sth wtf?
		}
	return
	
	::$lc+::
		if not WinExist("ahk_class SoPY_Comp") {
			send select t.*, t.rowid from sys_app_wf_instance t where t.instance_id = 1844;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_activity t where t.instance_id = 1844 order by t.activity_id asc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_act_permission t where t.instance_id = 1844 order by t.r_id desc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_act_suggestion t where t.instance_id = 1724 order by r_id asc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_act_consult t where t.instance_id = 1844 order by r_id asc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_act_reply t where t.instance_id = 1844 order by r_id asc;
			send {enter}
			send select t.*, t.rowid from sys_app_wf_run_param t where t.master_id = 1844;
			send {enter}
			send --sth wtf?
		}
	return

	::$zlc::

		send select t.*, t.rowid from sys_app_wf_join t where t.r_id = 756;
		send {enter}
		send select t.*, t.rowid from sys_app_wf_join t where t.tmpl_id = '';
		send {left 2}
	return
	
	::$zlc+::
		send select t.*, t.rowid from sys_app_wf_act_join t where t.instance_id = 0;
		send {enter}
		send select t.*, t.rowid from sys_app_wf_join t where t.r_id = 756;
		send {enter}
		send select t.*, t.rowid from sys_app_wf_join_permission t ;
	return
	
	::$wd::
		send select * from sys_app_ca_annex_v2;
		send {enter}
		send select * from sys_app_ca_archive_relate_v2;
		send {enter}
		send select * from sys_ca_catalog_v2;
		send {enter}
	return


	::$yh+::
		send,
		( 
select *
  from sys_rbac_user t
 where t.user_o_code in
       (select tt.r_code1
          from sys_rbac_role_relate tt
         where tt.role_code in
               (select ttt.role_o_code
                  from sys_rbac_role ttt
                 where ttt.role_o_code = 'CPJL'));
    	)
	return

	::$yh::
		send, select * from sys_rbac_user t where t.user_o_name like '`%`%';
		send {left}
		send {left}
		send {left}
	return

	::$cd1::
		send select * from sys_rbac_menu_page t where t.page_name like '`%`%';
		send {enter}
		send select * from sys_rbac_role_relate t where t.r_code1 in (select tt.r_id from sys_rbac_menu_page tt where tt.page_name like '`%`%') and r_type like '`%MENU_PAGE`%';

	return

#IfWinActive