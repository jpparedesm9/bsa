use cob_credito
go
IF OBJECT_ID ('dbo.cr_cliente_calif_137064') IS NOT NULL
begin
	if exists (SELECT 1 FROM sys.indexes WHERE Name = N'idxclientes1' AND object_id = OBJECT_ID(N'cr_cliente_calif_137064')) begin 
	   drop index idxclientes1 ON cr_cliente_calif_137064
	END 
	DROP TABLE cr_cliente_calif_137064
end

create table cr_cliente_calif_137064 
(ente int, cal_ant varchar(50) null, cal_des varchar(50) null, validado char(1) null)
create index idxclientes1 on cr_cliente_calif_137064(ente)
/*************************************************************/
/*   ARCHIVO:         	sp_regla_matriz_riesgo_137064.sp            */
/*   NOMBRE LOGICO:   	sp_regla_matriz_riesgo_137064               */
/*   PRODUCTO:        	credito                              */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento permite los datos del xml            */
/*   de Interfactura  							             */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   08-Marz-2018  PXSG                Emision Inicial.      */
/*************************************************************/


IF OBJECT_ID ('dbo.sp_regla_matriz_riesgo_137064') IS NOT NULL
	DROP PROCEDURE dbo.sp_regla_matriz_riesgo_137064
GO

CREATE PROCEDURE sp_regla_matriz_riesgo_137064 (
	@t_debug                   char(1) 	     = 'N',
	@t_file                    varchar(14)   = null,
	@t_from                    varchar(32)   = null,
	@i_operacion               char(1)       = null,
	@i_ente              	   int           = null,
	@o_error_mens              varchar(255)  = null out
)
as 

DECLARE
@w_sp_name           		varchar(32),
@w_codigo            		int,
@w_num_error         		int,
@w_catalogo_cre_des_riesgo  int,
@w_actividad_economica      varchar(200),
@w_provincia                smallint,
@w_cuidad                   int,
@w_nacionalidad             varchar(64),
@w_valor_variable_regla     varchar(250),
@w_segmento                 varchar(10),
@w_pep                      char(1),
@w_origen_recursos_var      varchar(10),
@w_origen_recursos          varchar(64),
@w_destino_credito_var      varchar(10),
@w_destino_credito          varchar(64),
@w_producto                 varchar(64),
@w_sub_producto             varchar(64),
@w_trans_internacionales     varchar(250),
@w_trans_internacionales_sum varchar(250),
@w_trans_nacionales          varchar(250),
@w_trans_nacionales_sum      varchar(250),
@w_deposito	                 varchar(250),
@w_deposito_sum              varchar(250),	
@w_retiro	                 varchar(250),
@w_retiro_sum                varchar(250),
@w_cv_divisas                varchar(120),
@w_cv_divisas_sum            varchar(120),
@w_transaccionalidad_sum     varchar(120),
@w_mensaje_fallo_regla       varchar(100),
@w_ejecutar_regla            char(1) = 'S',
@w_variables                 varchar(255),
@w_result_values             varchar(255),
@w_error                     int,
@w_parent                    int,
@w_nivel_obtenido            varchar(30),
@w_resultado_riesgo          varchar(30),
@w_nivel_anterior			 varchar(30),
@w_resul_niv_riesgo          varchar(30),
@w_resul_rango_calif         int,
@w_resul_numero_env          varchar(30), 
@w_resul_numero_rec          varchar(30), 
@w_resul_monto_env           varchar(30), 
@w_resul_monto_rec           varchar(30), 
@w_resul_numero_dep_efec     varchar(30), 
@w_resul_numero_dep_noefec   varchar(30), 
@w_resul_monto_dep_efec      varchar(30), 
@w_resul_monto_dep_noefec    varchar(30),
@w_es_pep                    varchar(10) ,
@w_puesto                    varchar(200),
@w_msm_advertencia           varchar(200),
@w_cli_a3ccc                 varchar(30),
@w_cli_a3bloq				 varchar(30),
@w_cli_a3dr                  varchar(30),
@w_cli_condicionado          varchar(30),
@w_msm_ea_nivel_riesgo       varchar(50),
@w_rule_id                   int,
@w_acronym                   varchar(30),
@w_tramite                   INT,
@w_ea_cta_banco              varchar(45),
@w_en_banco                  varchar(20),
@w_colectivo                 varchar(4),
@w_num_contrapartes			 varchar(30),
@w_canal_contratacion		 varchar(30),
@w_cal_fecha_nacimiento		 varchar(30),
@w_edad						 tinyint,
@w_fecha_proceso			 datetime,
@w_fecha_nac				 datetime,
@w_total					 int
    

declare @w_monto_num_riesgo table(
   mnr_ente                 int,
   mnr_num_op_env           varchar(30),
   mnr_mont_op_env          varchar(30),
   mnr_num_op_rec           varchar(30),
   mnr_mont_op_rec          varchar(30),
   mnr_num_dep_efec         varchar(30),
   mnr_mont_dep_efec        varchar(30),
   mnr_num_dep_noefec       varchar(30),
   mnr_mont_dep_noefec      varchar(30)   
)

declare @w_regla_MONOPMES table(
   variable_1     varchar(255),
   variable_2     varchar(255),
   result_1       varchar(255),
   UNIQUE NONCLUSTERED (variable_1,variable_2)
)

declare @w_regla_ACECO
table(
   variable_1     varchar(255),   
   result_1       varchar(255) ,
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
)
declare @w_regla_ENTFEDE1 table (
   variable_1     varchar(255) ,   
   variable_2     varchar(255) , 
   result_1       varchar(255),
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1, variable_2)
)

declare @w_regla_ENTFEDE2 table(
   variable_1     varchar(255),   
   variable_2     varchar(255), 
   result_1       varchar(255),
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1, variable_2)
)

declare @w_regla_NACIONAL table(
   variable_1     varchar(255),   
   result_1       varchar(255),
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
 )
   
declare @w_regla_PRODRIESG table (
   variable_1     varchar(255),   
   variable_2     varchar(255),
   variable_3     varchar(255),
   result_1       varchar(255),
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
)

declare @w_regla_SEGRIES table (
   variable_1     varchar(255),
   variable_2     varchar(255),   
   variable_3     varchar(255),   
   result_1       varchar(255),
   result_2       varchar(255),
   UNIQUE NONCLUSTERED (variable_1, variable_2,variable_3)
)
   
declare @w_regla_PEPRIESG table (
   variable_1     varchar(255),   
   result_1       varchar(255),
   result_2      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
)

declare @w_regla_ORIRECU table (
   variable_1     varchar(255),   
   result_1       varchar(255),
   result_2      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
)

declare @w_regla_DESRECU table (
   variable_1     varchar(255),   
   result_1       varchar(255),
   result_2      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)
)

declare @w_regla_NUMOPMES table (
   variable_1     varchar(255),   
   variable_2     varchar(255),
   result_1      varchar(255),
   UNIQUE NONCLUSTERED (variable_1, variable_2)
)

declare @w_regla_TRANSINTER table (
   max_value    varchar(255),
   operator_1   varchar(255),
   min_value    varchar(255),
   result_1     varchar(255),
   UNIQUE NONCLUSTERED (max_value,operator_1,min_value)   
)

declare @w_regla_COMVENTDIV table (
   max_value    varchar(255),
   operator_1   varchar(255),
   min_value    varchar(255),
   result_1     varchar(255),
   UNIQUE NONCLUSTERED (max_value,operator_1,min_value)
   
)

declare @w_regla_TRANSDAD table (
   max_value    varchar(255),
   operator_1   varchar(255),
   min_value    varchar(255),
   result_1     varchar(255),
   UNIQUE NONCLUSTERED (max_value,operator_1,min_value)   
)

declare @w_regla_CALFRISK table (
   max_value    varchar(255),
   operator_1   varchar(255),
   min_value    varchar(255),
   result_1     varchar(255),
   UNIQUE NONCLUSTERED (max_value,operator_1,min_value)   
)

declare @w_regla_NUMCONTRAP table (
   variable_1    varchar(255),
   variable_2	 varchar(255),
   variable_3    varchar(255),
   variable_4    varchar(255),
   result_1      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)   
)

declare @w_regla_CANCONTRAT table (
   variable_1    varchar(255),
   variable_2	 varchar(255),
   variable_3    varchar(255),
   result_1      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)   
)

declare @w_regla_FECNACONS  table (
   variable_1    varchar(255),
   variable_2	 varchar(255),
   variable_3    varchar(255),
   variable_4    varchar(255),
   result_1      varchar(255),
   UNIQUE NONCLUSTERED (variable_1)   
)


/*  Inicializacion de Variables  */
select @w_sp_name = 'sp_regla_matriz_riesgo_137064'
select @w_mensaje_fallo_regla = 'Fallo Ejecuci?n Regla'
select @w_catalogo_cre_des_riesgo = (select codigo from cobis..cl_tabla where tabla = 'cre_des_riesgo')
select @o_error_mens = '---' -- para validacion
SET    @w_msm_advertencia='ADVERTENCIA: Hubo un problema al generar la Matriz de Riesgo' 
if @i_operacion = 'I'
begin
	truncate table cr_cliente_calif_137064
    
    ---OBTENER UNIVERSO DE CLIENTES
	insert into cr_cliente_calif_137064 (ente) --OBTENER GRUPALES
	SELECT DISTINCT(dc_cliente) FROM cob_cartera..ca_det_ciclo 
	ORDER BY dc_cliente

	insert into cr_cliente_calif_137064 (ente) --OBTENER INDIVIDUALES Y REVOLVENTES
	SELECT DISTINCT(op_cliente) FROM cob_cartera..ca_operacion 
	WHERE op_toperacion <>'GRUPAL' 
	and op_cliente  not in (select ente from cr_cliente_calif_137064)
	ORDER BY op_cliente
	
	if exists (select 1 from cr_cliente_calif_137064) begin
	   --1. Tabla temporal regla MONOPMES
	   select @w_acronym = 'MONOPMES'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   	
	   if @@rowcount > 0 begin		   
          insert into @w_regla_MONOPMES	
	      select cr1.cr_max_value as variable_1, cr2.cr_max_value as variable_2, cr3.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_rule_id 
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
          and cr3.cr_is_last_son = 'true'  	   
	      
	   end
	   	
	   --2. Tabla temporal regla ACECO
	   select @w_acronym = 'ACECO'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin		     	 
          insert into @w_regla_ACECO
	      select cr1.cr_max_value as variable_1, cr2.cr_max_value as result_2, cr3.cr_max_value as result_1
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_rule_id 
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr2.cr_is_last_son = 'true'
          and cr3.cr_is_last_son = 'true'         				 
	      
	   end
	
	   --3.Tabla temporal regla ENTFEDE1
	   select @w_acronym = 'ENTFEDE1'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin		
	   
	         insert into @w_regla_ENTFEDE1
	         select cr1.cr_max_value as variable_1, 
	                cr2.cr_max_value as variable_2, 
	   		        cr3.cr_max_value as result_1,
	   		        cr4.cr_max_value as result_2
             from  cob_pac..bpl_condition_rule cr1
             inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
             inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
	         inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
             where cr1.rv_id = (select max(rv_id) 
                             from cob_pac..bpl_rule_version 
                             where rl_id = @w_rule_id 
                             and rv_status = 'PRO')
             and cr1.cr_parent is null
	         and cr3.cr_is_last_son = 'true'
             and cr4.cr_is_last_son = 'true'  	   
	    
	   end
	   	
	   --4.Tabla temporal regla ENTFEDE2
	   select @w_acronym = 'ENTFEDE2'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin		
	   
	      insert into @w_regla_ENTFEDE2
          select cr1.cr_max_value as variable_1, 
	             cr2.cr_max_value as variable_2, 
	   		     cr3.cr_max_value as result_1,
	   		     cr4.cr_max_value as result_2
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
	      inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                             from cob_pac..bpl_rule_version 
                             where rl_id = @w_rule_id 
                             and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr3.cr_is_last_son = 'true'
          and cr4.cr_is_last_son = 'true'  	   
	      
	   end
	   	
	   --5.Tabla temporal regla NACIONAL
	   select @w_acronym = 'NACIONAL'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin	
	       insert into @w_regla_NACIONAL
	      select cr1.cr_max_value as variable_1, 
	           cr2.cr_max_value as result_1, 
	             cr3.cr_max_value as result_2       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_rule_id 
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr3.cr_is_last_son = 'true'  	   
	      
	   end
	   
	   --6.Tabla temporal regla SEGRIES
	   select @w_acronym = 'SEGRIES'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin		         
          insert into @w_regla_SEGRIES
	      select cr1.cr_max_value as variable_1, 
	             cr2.cr_max_value as variable_2, 
	   		     cr3.cr_max_value as variable_3,
	             cr4.cr_max_value as result_1,
	             cr5.cr_max_value as result_2       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
	      inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
	      inner join cob_pac..bpl_condition_rule cr5 on cr4.cr_id = cr5.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_rule_id 
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr4.cr_is_last_son = 'true'  	
          and cr5.cr_is_last_son = 'true'  			  
	      
	   end	
	   
	   --7.Tabla temporal regla PRODRIESG
	   select @w_acronym = 'PRODRIESG'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin		
	      insert into @w_regla_PRODRIESG
			select cr1.cr_max_value as variable_1,
	             cr2.cr_max_value as variable_2,
	             cr3.cr_max_value as variable_3,
	             cr4.cr_max_value AS result_1,
	             cr5.cr_max_value AS result_2
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
		  inner join cob_pac..bpl_condition_rule cr5 on cr4.cr_id = cr5.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_rule_id 
                          and rv_status = 'PRO')
          and cr1.cr_parent is null  			  
	      	      
	   end
	   
       --8.Tabla temporal regla PEPRIESG
	   select @w_acronym = 'PEPRIESG'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin	
          insert into @w_regla_PEPRIESG	
	      select cr1.cr_max_value as variable_1,
	             cr2.cr_max_value as result_1,
	             cr3.cr_max_value as result_2       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr2.cr_is_last_son = 'true'  	
          and cr3.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   
	   --9.Tabla temporal regla ORIRECU
	   select @w_acronym ='ORIRECU'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	      	
	   if @@rowcount > 0 begin	
          insert into @w_regla_ORIRECU	
	 select cr1.cr_max_value as variable_1,
	             cr2.cr_max_value as result_1,
	             cr3.cr_max_value as result_2       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr2.cr_is_last_son = 'true'  	
          and cr3.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --10.Tabla temporal regla DESRECU
	   select @w_acronym = 'DESRECU'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin		   
          insert into @w_regla_DESRECU	
	      select cr1.cr_max_value as variable_1,
	             cr2.cr_max_value as result_1,
	             cr3.cr_max_value as result_2       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null
	      and cr2.cr_is_last_son = 'true'  	
          and cr3.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --11.Tabla temporal regla NUMOPMES
	   select @w_acronym = 'NUMOPMES'
       select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin		
          insert into @w_regla_NUMOPMES	
	      select cr1.cr_max_value as variable_1,
	             cr2.cr_max_value as variable_2,
	             cr3.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null	
          and cr3.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --12.Tabla temporal regla TRANSINTER
	   select @w_acronym = 'TRANSINTER'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin		 
          insert into @w_regla_TRANSINTER	
	      select cr1.cr_max_value as max_value,
	             cr1.cr_operator  as operator_1,
                 cr1.cr_min_value as min_value,
	             cr2.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null	
          and cr2.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --13.Tabla temporal regla COMVENTDIV
	   select @w_acronym = 'COMVENTDIV'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin
          insert into @w_regla_COMVENTDIV	
	      select cr1.cr_max_value as max_value,
	             cr1.cr_operator  as operator_1,
                 cr1.cr_min_value as min_value,
	   cr2.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null	
          and cr2.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --14.Tabla temporal regla TRANSDAD
	   select @w_acronym = 'TRANSDAD'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin	
          insert into @w_regla_TRANSDAD	
	      select cr1.cr_max_value as max_value,
	             cr1.cr_operator  as operator_1,
                 cr1.cr_min_value as min_value,
	             cr2.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null	
          and cr2.cr_is_last_son = 'true'  			  
	   	      
	   end
	
	
	   --15.Tabla temporal regla CALFRISK
	   select @w_acronym = 'CALFRISK'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin	
       
          insert into @w_regla_CALFRISK	
	      select cr1.cr_max_value as max_value,
                 cr1.cr_operator  as operator_1,
                 cr1.cr_min_value as min_value,
	             cr2.cr_max_value as result_1       
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent 
          where cr1.rv_id = (select max(rv_id) 
                                       from cob_pac..bpl_rule_version 
                                       where rl_id = @w_rule_id 
                                       and rv_status = 'PRO')
          and cr1.cr_parent is null	
          and cr2.cr_is_last_son = 'true'  			  
	      	      
	   end
	   
	   --16.Tabla temporal regla NUMCONTRAP NUMERO DE CONTRAPARTES
	   select @w_acronym = 'NUMCONTRAP'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin       
          insert into @w_regla_NUMCONTRAP	
	      select 	cr1.cr_max_value as variable_1, 
					cr2.cr_max_value as variable_2,
					cr3.cr_max_value as variable_3,
					cr4.cr_max_value as variable_4,
					cr5.cr_max_value as result_1      
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
          inner join cob_pac..bpl_condition_rule cr5 on cr4.cr_id = cr5.cr_parent
          where cr1.rv_id = (select max(rv_id)
                          from cob_pac..bpl_rule_version
                          where rl_id = @w_rule_id
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
          and cr5.cr_is_last_son = 'true' 
	   end
	   
	   --17.Tabla temporal regla CANCONTRAT CANAL DE CONTRATACION
	   select @w_acronym = 'CANCONTRAT'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin       
          insert into @w_regla_CANCONTRAT	
	      select 	cr1.cr_max_value as variable_1, 
					cr2.cr_max_value as variable_2,
					cr3.cr_max_value as variable_3,
					cr4.cr_max_value as result_1
           from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
          where cr1.rv_id = (select max(rv_id)
                          from cob_pac..bpl_rule_version
                          where rl_id = @w_rule_id
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
          and cr4.cr_is_last_son = 'true'          
	   end
	   
	   --18.Tabla temporal regla FECNACONS FECHA NACIMIENTO
	   select @w_acronym = 'FECNACONS'
	   select @w_rule_id =  rl_id from cob_pac..bpl_rule where rl_acronym = @w_acronym
	   
	   if @@rowcount > 0 begin       
          insert into @w_regla_FECNACONS
	      select 	cr1.cr_max_value as variable_1, 
					cr2.cr_max_value as variable_2,
					cr3.cr_max_value as variable_3,
					cr4.cr_max_value as variable_4,
					cr5.cr_max_value as result_1      
          from  cob_pac..bpl_condition_rule cr1
          inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent
          inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent
          inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent
          inner join cob_pac..bpl_condition_rule cr5 on cr4.cr_id = cr5.cr_parent
          where cr1.rv_id = (select max(rv_id)
                          from cob_pac..bpl_rule_version
                          where rl_id = @w_rule_id
                          and rv_status = 'PRO')
          and cr1.cr_parent is null
          and cr5.cr_is_last_son = 'true'        
	   end
	   
	    
       select @i_ente = 0
	   
	   print 'INICIA CICLO'
	   while (1 = 1) begin
	
		 select @w_ejecutar_regla = 'S'
         select top 1 @i_ente = ente 
	     from cr_cliente_calif_137064 WITH (NOLOCK)
	     where ente > @i_ente 
	     order by ente asc
		 
         if @@rowcount = 0 break
		 
		 select @w_colectivo = ea_colectivo 
		 from cobis..cl_ente_aux 
		 where ea_ente       = @i_ente
		 
		 /*Validar informacion de datos completos*/
		 select @w_colectivo = case when @w_colectivo is null or ltrim(rtrim(@w_colectivo)) = '' then 'I' else @w_colectivo end
		 
         if @w_colectivo = 'I' begin
             if exists (select 1 from cobis..cl_seccion_validar where sv_ente = @i_ente and sv_completado = 'N')
             begin
				print 'FALTA COMPLETAR INFO'
             	select @w_ejecutar_regla = 'N'
             	--select @o_error_mens = mensaje from cobis..cl_errores where numero = 103164
             end
         end else begin		    
            
            exec @w_num_error = cobis..sp_seccion_validar
            @i_operacion = 'F',
            @i_modo      = 1,
            @i_ente      = @i_ente 
            
            if @w_num_error <> 0 begin
				print 'ERROR COMPLETAR INFO'
               select @w_ejecutar_regla = 'N'
            end
         end    
         
	     /* Validar que el cliente haya consultado Santander para generar la matriz*/
	     SELECT	@w_ea_cta_banco  = ea_cta_banco
         FROM cobis..cl_ente_aux WITH (NOLOCK)
		 WHERE ea_ente = @i_ente
	
	     SELECT	@w_en_banco 		= en_banco
	     FROM cobis..cl_ente WITH (NOLOCK)
		 WHERE en_ente = @i_ente
	     		    

	     
	     if @w_ejecutar_regla = 'S' AND ( @w_ea_cta_banco IS NULL or @w_en_banco is NULL)
         BEGIN
			print 'NO TIENE CUENTA'
	     	select @w_ejecutar_regla = 'N'
	     END
		 
		PRINT'Ente en Matriz----> '+convert(VARCHAR(50),@i_ente)
	    PRINT '@w_ejecutar_regla..'+@w_ejecutar_regla
       
         
	     /*Validar sub producto que trae la orquestacion de buro*/
	     /* se comenta ya que para los clientes antiguos se va a poner en el nivel obtenido Bajo y puntaje de 80*/
         /*  if @w_ejecutar_regla = 'S' and not exists (select 1 from   cobis..cl_ente_aux e inner join cobis..cl_producto_santander p on e.ea_ente = p.pr_ente
                        and e.ea_cta_banco = p.pr_numero_contrato
                        and e.ea_ente = @i_ente) 
         begin
	     	select @w_ejecutar_regla = 'N'
	     	select @o_error_mens = mensaje from cobis..cl_errores where numero = 103165
	     end	 
	     */			   
         
         /*Ejecucion regla*/	
         if (@w_ejecutar_regla = 'S')
         begin
		    delete from cob_credito..cr_matriz_riesgo_cli where mr_cliente = @i_ente

        
		    -------------------------------------------------------------
            -- EJECUCION Transferencias Internacionales Monto Enviadas --
            -------------------------------------------------------------
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_internacionales = 'TRANSFERENCIAS NACIONALES ENVIADAS'
            
	        select @w_resul_monto_env = result_1 
	        from   @w_regla_MONOPMES
	        where variable_2 = @w_nivel_obtenido
            and   variable_1 = @w_trans_internacionales     
       
              
              
            --------------------------------------------------------------
            -- EJECUCION Transferencias Internacionales Monto Recibidas --
            --------------------------------------------------------------
            
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_internacionales = 'TRANSFERENCIAS NACIONALES RECIBIDAS'
	        
	        select @w_resul_monto_rec = result_1 
	        from   @w_regla_MONOPMES
	        where variable_2 = @w_nivel_obtenido
            and   variable_1 = @w_trans_internacionales
              
            -------------------------------------------
            -- EJECUCION Depositos en Efectivo Monto --
            -------------------------------------------
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_internacionales = 'DEPOSITOS EN EFECTIVO'
            
	        select @w_resul_monto_dep_efec = result_1 
	        from   @w_regla_MONOPMES
	        where variable_2 = @w_nivel_obtenido
            and   variable_1 = @w_trans_internacionales   
            
              
            -------------------------------------------
            -- EJECUCION Depositos No Efectivo Monto --
            -------------------------------------------
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_internacionales = 'DEPOSITOS NO EFECTIVO'        
  	        
            
	        select @w_resul_monto_dep_noefec = result_1 
	        from   @w_regla_MONOPMES
	        where variable_2 = @w_nivel_obtenido
            and   variable_1 = @w_trans_internacionales
       
            -------------------------------------------
            -- EJECUCION REGLA ACTIVIDAD ECONOMICA
			-------------------------------------------
       	    select TOP 1 @w_actividad_economica = nc_actividad_ec 
            from   cobis..cl_ente, cobis..cl_negocio_cliente
            where  en_ente         = @i_ente
       	    and    en_ente         = nc_ente
            and    nc_estado_reg   = 'V'   	
	   	       	
	   	    
	   	    select @w_nivel_obtenido   = result_1,  
	   	           @w_resultado_riesgo = result_2
	   	    from   @w_regla_ACECO
	   	    where  variable_1 = @w_actividad_economica
	   	    
	   	    if @@rowcount = 0 begin
	   	       select @w_nivel_obtenido   = 'BAJO',  
	   	              @w_resultado_riesgo = '0'
	   	    end
               
            insert into cob_credito..cr_matriz_riesgo_cli 
	   	    (mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
               values
	   	    (@i_ente,    '001',       @w_nivel_obtenido, @w_resultado_riesgo)
       										   
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA ENTIDAD FEDERATIVA - ZONA GEOGRAFICA
            set @w_valor_variable_regla=' '
            if exists(select 1 from   cobis..cl_direccion where  di_tipo ='RE' and  di_ente = @i_ente)         begin
                select top 1 @w_provincia = di_provincia, 
                             @w_cuidad    = di_ciudad
                from   cobis..cl_direccion 
                where  di_tipo ='RE' 
                and    di_ente = @i_ente
            end
            else begin
                select top 1 @w_provincia = di_provincia, 
                             @w_cuidad    = di_ciudad
                   from   cobis..cl_direccion 
                   where  di_tipo ='AE' 
                   and    di_ente = @i_ente
            end   
	   	   
	   	    
            select @w_nivel_obtenido   = result_1,  
	   	           @w_resultado_riesgo = result_2
	   	    from   @w_regla_ENTFEDE1
	   	    where variable_1 = @w_provincia
	   	    and   variable_2 = @w_cuidad
	   	    
	   	    if @@rowcount = 0 begin
	   	    
	   	          select @w_nivel_obtenido   = result_1,  
	   	                 @w_resultado_riesgo = result_2
	   	          from @w_regla_ENTFEDE2
	   	          where variable_1 = @w_provincia
	   	          and variable_2   = @w_cuidad
	   	       
	   	          if @@rowcount = 0 begin
	   	             select @w_nivel_obtenido   = 'MEDIO',  
	   	                    @w_resultado_riesgo =  '440'
	   	          end
	   	       
	   	    END
   	         
               
            insert into cr_matriz_riesgo_cli 
	       	( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values 
	       	( @i_ente,    '002',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
			
            --------------------------------------------------------
            -- EJECUCION REGLA NACIONAL
			--------------------------------------------------------
			
            set	@w_nacionalidad='MEXICANA'
            select @w_nivel_obtenido   = result_1,  
	               @w_resultado_riesgo = result_2
	        from   @w_regla_NACIONAL
	        where variable_1 = @w_nacionalidad
       		
            if @@rowcount = 0 begin
               select @w_nivel_obtenido     = 'BAJO',
			          @w_resultado_riesgo   = 0
            end 			
              
            insert into cob_credito..cr_matriz_riesgo_cli 
	        ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
             values 
	        ( @i_ente,    '003',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA SEGMENTO RIESGO - SEGMENTO -- Vicky
 	        
            select @w_sub_producto = p.pr_codigo_subproducto 
            from   cobis..cl_ente_aux e
            inner join cobis..cl_producto_santander p
            on e.ea_ente = p.pr_ente
            and e.ea_cta_banco = p.pr_numero_contrato
            and e.ea_ente = @i_ente
	        
	        if @@rowcount = 0 begin
	           select @w_nivel_obtenido = 'BAJO', @w_resultado_riesgo = '91'
	        end
            else begin           
	        	  
               select    @w_nivel_obtenido   = result_1,  
	        	         @w_resultado_riesgo = result_2
	        	  from   @w_regla_SEGRIES
	        	  where variable_1 = 'INDIVIDUOS'
	        	  and variable_2 = 'PARTICULARES'
	        	  and variable_3 = @w_sub_producto
	        	  
	        	  if @@rowcount =0 begin 
	        	     select @w_nivel_obtenido   = '0',  
	        	            @w_resultado_riesgo = '0'
	        	  end
	        
            end    

       	   	
            insert into cob_credito..cr_matriz_riesgo_cli 
	   	    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)  
	   	    values ( @i_ente,    '004',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA PRODUCTO
            
			if(@w_tramite is not null)
			begin
				select @w_producto = 'CRÉDITOS GRUPALES'	
			end
			else
			begin
				select @w_producto = 'LÍNEA DE CRÉDITO REVOLVENTE'
			end
		
	   
            select @w_nivel_obtenido   = result_1,  
	               @w_resultado_riesgo = result_2
	        from   @w_regla_PRODRIESG
	        where variable_2 = isnull(@w_producto,'CRÉDITOS GRUPALES')
			
	        if @@rowcount = 0 begin 
	           select @w_nivel_obtenido      = '0',  
	                  @w_resultado_riesgo    = '0'
	        end		

            insert into cob_credito..cr_matriz_riesgo_cli 
	   	    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values ( @i_ente,    '005',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA PEP
            select @w_pep = en_persona_pep 
            from   cobis..cl_ente 
            where  en_ente = @i_ente
            		   	     
		    if @w_pep is null begin
			   
                exec cob_credito..sp_valida_pep
                @i_ente   = @i_ente,
                @o_es_pep = @w_es_pep OUTPUT,
                @o_puesto = @w_puesto OUTPUT   	  
                
                update cobis..cl_ente 
				set en_persona_pep = @w_es_pep,
				    p_carg_pub     = @w_puesto
                where en_ente=@i_ente
         
                SET @w_pep=@w_es_pep
			end 
			
            select @w_nivel_obtenido   = result_1,  
	        	   @w_resultado_riesgo = result_2
	        from   @w_regla_PEPRIESG
	        where  variable_1 = @w_pep
	        	
	        if @@rowcount = 0 begin 
	           select @w_nivel_obtenido   = 'BAJO',  
	                  @w_resultado_riesgo = '0'
	        end   
        
       	
            insert into cob_credito..cr_matriz_riesgo_cli ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values ( @i_ente,    '006',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
       											
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA Origen de Recursos
            select TOP 1 @w_origen_recursos_var = nc_recurso, 
                         @w_origen_recursos     = valor 
            from  cobis..cl_negocio_cliente, cobis..cl_tabla,cobis..cl_catalogo
            where cl_tabla.tabla in ('cl_recursos_credito') 
            and   cl_tabla.codigo    = cl_catalogo.tabla 
            and   cl_catalogo.codigo = nc_recurso 
            and   nc_estado_reg      = 'V' 
            and   nc_ente            = @i_ente  
		
		
            select @w_nivel_obtenido   = result_1,  
	   	           @w_resultado_riesgo = result_2
	   	    from   @w_regla_ORIRECU
	   	    where variable_1 = @w_origen_recursos_var 
	   	    
	   	    if @@rowcount = 0 begin 
	   	       select @w_nivel_obtenido   = 'BAJO',  
	   	              @w_resultado_riesgo = '0'
	   	    end
       	
            insert into cob_credito..cr_matriz_riesgo_cli ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values ( @i_ente,    '007',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
			
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION REGLA Destino Recursos Catalogo = cl_destino_credito
            select TOP 1 @w_destino_credito_var = nc_destino_credito
            from  cobis..cl_negocio_cliente
            where nc_estado_reg      = 'V' 
       	    and   nc_ente            = @i_ente 
            
	        
            select @w_nivel_obtenido   = result_1,  
	   	           @w_resultado_riesgo = result_2
	   	    from   @w_regla_DESRECU
	   	    where variable_1 = @w_destino_credito_var 
				   	    
	   	    if @@rowcount = 0 begin 
	   	       select @w_nivel_obtenido   = 'BAJO',  
	   	              @w_resultado_riesgo = '0'
	   	    end
	   	    
       	    
            insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values ( @i_ente,    '008',       @w_nivel_obtenido, convert(INT ,@w_resultado_riesgo))
       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION Transferencias Internacionales
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_internacionales = 'TRANSFERENCIAS INTERNACIONALES ENVIADAS'
            
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_trans_internacionales
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end
	   	    
	   	    
		    --select @w_resultado_riesgo   = replace(convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values) - 1)),'|','')
       	    select @w_trans_internacionales_sum = @w_resultado_riesgo
	   	    
       	    --Se reasigna para insertar en tabla
       	   /* select @w_resul_numero_env = @w_resultado_riesgo*/
            -------------------------------------------------------------------------------------------------------------------------------------------
            select @w_trans_internacionales = 'TRANSFERENCIAS INTERNACIONALES RECIBIDAS'
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_trans_internacionales
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end
	        
		    
       	    select @w_trans_internacionales_sum = convert(int,@w_trans_internacionales_sum) + convert(int,@w_resultado_riesgo)
       	    
       	           
            --Se reasigna para insertar en tabla 
            /*select @w_resul_numero_rec = @w_resultado_riesgo*/
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- Resultado para mostrar - Transf. internacionales
      
	
            select @w_nivel_obtenido = result_1
 		    from @w_regla_TRANSINTER
            where ( convert(int,@w_trans_internacionales_sum ) > max_value and operator_1 = '>') 
		     or   ( convert(int,@w_trans_internacionales_sum)  between min_value and max_value and operator_1 = 'between')  
		     
	        if @@rowcount = 0 begin 
	             SELECT @w_nivel_obtenido = '0'
	        end
	    
		
            --select @w_nivel_obtenido   = replace(convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values) - 1)),'|','')

            
            insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
         values ( @i_ente,    '009',       @w_nivel_obtenido, convert(int ,@w_trans_internacionales_sum))	
       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION Transferencias Nacionales
           
            select @w_nivel_obtenido = 'BAJO'
            select @w_trans_nacionales = 'TRANSFERENCIAS NACIONALES ENVIADAS'
            
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_trans_nacionales
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end

       	    select @w_trans_nacionales_sum = @w_resultado_riesgo
       	    --Se reasigna para insertar en tabla
       	    select @w_resul_numero_env = @w_resultado_riesgo
            
			--------------------------------------------------------------------------------------------------------------------------------------------
            select @w_trans_nacionales = 'TRANSFERENCIAS NACIONALES RECIBIDAS'
              	
	        
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_trans_nacionales
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end
	        
	        --Se reasigna para insertar en tabla 
            select @w_resul_numero_rec = @w_resultado_riesgo
            
       	    select @w_trans_nacionales_sum = convert(int,@w_trans_nacionales_sum) + convert(int,@w_resultado_riesgo)

       
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION DEPOSITOS EN EFECTIVO
        
            select @w_nivel_obtenido = 'BAJO'
            select @w_deposito = 'DEPOSITOS EN EFECTIVO'
            
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_deposito
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    END

	  
       	    select @w_deposito_sum = @w_resultado_riesgo
       	
       	    --Se reasigna para insertar en tabla
            select @w_resul_numero_dep_efec = @w_resultado_riesgo
            --------------------------------------------------------------------------------------------------------------------------------------------
            select @w_deposito = 'DEPOSITOS NO EFECTIVO'
       
      
            select @w_resultado_riesgo = result_1
	        from @w_regla_NUMOPMES
	        where variable_1 = @w_deposito
	        and   variable_2 = @w_nivel_obtenido
	        
	        if @@rowcount = 0 begin 
	             SELECT @w_resultado_riesgo = '0'
	        end   
		
       	    
       	    select @w_deposito_sum = convert(int,@w_deposito_sum) + convert(int,@w_resultado_riesgo)
            
               
               --Se reasigna para insertar en tabla
       	    select @w_resul_numero_dep_noefec = @w_resultado_riesgo
			
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION RETIROS EN EFECTIVO
          
            select @w_nivel_obtenido = 'BAJO'
            select @w_retiro = 'RETIROS EN EFECTIVO'
            
            --ojo
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_retiro
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end

	   	
       	    select @w_retiro_sum = @w_resultado_riesgo
            --------------------------------------------------------------------------------------------------------------------------------------------
            select @w_deposito = 'RETIROS NO EFECTIVO'       
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_deposito
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end

       	    
       	    select @w_retiro_sum = convert(int,@w_retiro_sum) + convert(int,@w_resultado_riesgo)

			
            --------------------------------------------------------------------------------------------------------------------------------------------
            --------------------------------------------------------------------------------------------------------------------------------------------
            -- EJECUCION Compra-venta divisas
       
            select @w_nivel_obtenido = 'BAJO'
            select @w_cv_divisas = 'COMPRA DE DIVISAS'
            
	        
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_cv_divisas
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end
	   	    

       	    select @w_cv_divisas_sum = @w_resultado_riesgo
            -------------------------------------------------------------------------------------------------------------------------------------------
            select @w_cv_divisas = 'VENTA DE DIVISAS'
            
            
            select @w_resultado_riesgo = result_1
	   	    from @w_regla_NUMOPMES
	   	    where variable_1 = @w_cv_divisas
		    and   variable_2 = @w_nivel_obtenido
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end

       	    
       	    select @w_cv_divisas_sum = convert(int,@w_cv_divisas_sum) + convert(int,@w_resultado_riesgo)

			
            -------------------------------------------------------------------------------------------------------------------------------------------- 	
            -- Resultado para mostrar - Compra-venta divisas
       
            --select @w_nivel_obtenido = 'BAJO'
            --Se guarda el la variable @w_resultado_riesgo el valor del nivel obetenido para la regla
            
    	    select @w_nivel_obtenido = result_1
 		    from @w_regla_COMVENTDIV
            where (convert(int,@w_cv_divisas_sum) > max_value and operator_1 = '>') 
		    or    (convert(int,@w_cv_divisas_sum) between min_value and max_value and operator_1 = 'between')  
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end

       	    
            insert into cob_credito..cr_matriz_riesgo_cli
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values
		    ( @i_ente,    '010',       @w_nivel_obtenido, convert(int ,@w_cv_divisas_sum))	
       										   
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            -- EJECUCION Transaccionalidad
            --select @w_nivel_obtenido = 'BAJO'
       	    -- Calculo de Nivel de Riesgo
       	    select @w_transaccionalidad_sum = convert(int,@w_trans_nacionales_sum) +
       	                                      convert(int,@w_deposito_sum) + convert(int,@w_retiro_sum) 
            
		    select @w_nivel_obtenido = result_1
 		    from   @w_regla_TRANSDAD
            where (convert(int,@w_transaccionalidad_sum)  > max_value and operator_1 = '>') 
		    or    (convert(int,@w_transaccionalidad_sum)  between min_value and max_value and operator_1 = 'between')  
	   	    
	   	    if @@rowcount = 0 begin 
	   	         SELECT @w_resultado_riesgo = '0'
	   	    end
	   	    

            insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values 
		    ( @i_ente,    '011',       @w_nivel_obtenido, convert(int ,@w_transaccionalidad_sum))  
			
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
			---REGLA NUMERO DE CONTRAPARTES
			select 	@w_nivel_obtenido = variable_4,
					@w_num_contrapartes = result_1
			from @w_regla_NUMCONTRAP
			where variable_2 = 'P'

			
			insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values 
		    ( @i_ente,    '012',       @w_nivel_obtenido,convert(int,@w_num_contrapartes))
			
			------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
			---REGLA CANAL DE CONTRATACION
			select 	@w_nivel_obtenido = variable_3,
					@w_canal_contratacion = result_1
			from @w_regla_CANCONTRAT
			where variable_2 = 'Presencial'

			
			insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values 
		    ( @i_ente,    '013',       @w_nivel_obtenido,convert(int,@w_canal_contratacion))       
			------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
			---REGLA FECHA DE NACIMIENTO
			select @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
			select @w_fecha_nac	= p_fecha_nac from cobis..cl_ente where en_ente = @i_ente
			
			
			
			SELECT @w_edad = DATEDIFF(year,@w_fecha_nac,@w_fecha_proceso)
			
			select 	@w_nivel_obtenido = variable_4,
					@w_cal_fecha_nacimiento = result_1
			from @w_regla_FECNACONS
			where convert(int,variable_1) <= @w_edad and convert(int,variable_2) > @w_edad

			
			insert into cob_credito..cr_matriz_riesgo_cli 
		    ( mr_cliente, mr_variable, mr_nivel,          mr_puntaje)
            values 
		    ( @i_ente,    '014',       @w_nivel_obtenido,convert(int,@w_cal_fecha_nacimiento))
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            --Ejecucion de regla calculo de nivel de riesgo
            select @w_resul_rango_calif      = sum(mr_puntaje)
            from   cob_credito..cr_matriz_riesgo_cli 
            where  mr_cliente  = @i_ente
              	   
	        select @w_resultado_riesgo = result_1
 	        from   @w_regla_CALFRISK
            where (@w_resul_rango_calif  >= max_value and operator_1 = '>=') 
	        or    (@w_resul_rango_calif  between min_value and max_value and operator_1 = 'between')  
			or    (@w_resul_rango_calif = max_value and operator_1 = '=')
	         
	        if @@rowcount = 0 begin 
	             SELECT @w_resultado_riesgo = '0'
	        END
	        
	        /* Se actualiza la calificacion en la cl_ente*/
			
			select @w_nivel_anterior = ea_nivel_riesgo from cobis..cl_ente_aux where ea_ente = @i_ente
	        
	        update cobis..cl_ente_aux
        	set    ea_nivel_riesgo   = @w_resultado_riesgo,
    	           ea_puntaje_riesgo = @w_resul_rango_calif
            where  ea_ente = @i_ente
			
			update cr_cliente_calif_137064
			set cal_ant = @w_nivel_anterior,
				cal_des = @w_resultado_riesgo
			where ente = @i_ente
    
           if @@error <> 0
            begin   
                select @w_num_error = 103163 --Error al actualizar resultado de riesgo
                goto ERROR
            end	
       	        
	 
	        --CLIENTE CONDICIONADO
       	    select @w_cli_a3ccc        = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CA3CCC' AND pa_producto='CLI'
            select @w_cli_a3bloq       = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CA3BLO' AND pa_producto='CLI'
			select @w_cli_a3dr         = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CA3DR' AND pa_producto='CLI'
            select @w_cli_condicionado = pa_char FROM cobis..cl_parametro WHERE pa_nemonico ='CLICON' AND pa_producto='CLI'


            select @w_msm_ea_nivel_riesgo=ea_nivel_riesgo from cobis..cl_ente_aux where  ea_ente = @i_ente
            
            IF  EXISTS ((SELECT 1 FROM cobis..cl_alertas_riesgo WHERE ar_ente= @i_ente AND ar_tipo_lista='C' ))
               BEGIN
 
                 if(replace(@w_msm_ea_nivel_riesgo,' ','')<>replace(@w_cli_a3ccc,' ','') and replace(@w_msm_ea_nivel_riesgo,' ','')<>replace(@w_cli_a3bloq,' ','') and replace(@w_msm_ea_nivel_riesgo,' ','')<>replace(@w_cli_a3dr,' ',''))
                       begin
	           	       
                        UPDATE  cobis..cl_alertas_riesgo SET ar_status='BA'
                        WHERE ar_ente=@i_ente AND ar_tipo_lista='C'
                         
                       END

                 if(replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3ccc,' ','') or replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3bloq,' ','')  or replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3dr,' ',''))
                       begin
                          UPDATE  cobis..cl_alertas_riesgo SET ar_status='EI'
                          WHERE ar_ente=@i_ente AND ar_tipo_lista='C'
                             
                          end
                      
               END
            
            if(replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3ccc,' ','') or replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3bloq,' ','') or replace(@w_msm_ea_nivel_riesgo,' ','')=replace(@w_cli_a3dr,' ',''))
            begin
		       exec cobis..sp_cliente_condicionado
		       @i_ente       =@i_ente
        
            end
        
		    if exists(select 1 from cob_credito..cr_monto_num_riesgo where mnr_ente = @i_ente)
    	    begin
    	       delete cob_credito..cr_monto_num_riesgo where mnr_ente = @i_ente
    	    end
	    
	        insert into cob_credito..cr_monto_num_riesgo 
    	    values (@i_ente,                    @w_resul_numero_env,                @w_resul_monto_env,                 @w_resul_numero_rec,
    	            @w_resul_monto_rec,         @w_resul_numero_dep_efec,           @w_resul_monto_dep_efec,	        @w_resul_numero_dep_noefec,
    	            @w_resul_monto_dep_noefec,	@w_num_contrapartes,				@w_canal_contratacion,				@w_cal_fecha_nacimiento)
	    		
		 end

		update cr_cliente_calif_137064
		set validado ='S'
		where ente = @i_ente
	   end
	end
	
	select * from cr_cliente_calif_137064
	
end --Fin opcion I


return 0

ERROR:
    begin --Devolver mensaje de Error 
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_num_error
    return @w_num_error
    end
go