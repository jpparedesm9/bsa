
use cob_conta_super
go
/************************************************************/
/*   ARCHIVO:         genera_buro.sp                        */
/*   NOMBRE LOGICO:   sp_gen_buro_act_parciales             */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  biginternacionales de */
/*   propiedad bigintelectual.  Su uso  no  autorizado dara */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Genera los datos para el "Formato Corto para            */
/*  Actualizaciones Parciales" del reporte Buro de Credito. */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR         RAZON                      */
/* 13/SEPT/2017    Wtoledo      Emision inicial             */
/* 18/OCT/2017     Achiluisa    Se envian valores por       */
/*                              defecto, modificacion de    */
/*                              consultas                   */
/* 05/ABR/2019     AEOC         Se agregan Operaciones      */
/*                              Individuales Revolventes    */
/* 17/05/2019     DCumbal       Caso #116355                */
/* 17/05/2019     DCumbal       Requerimiento #110097       */
/* 24/06/2019     DCumbal       Ajuste saldo vencido        */
/* 25/06/2019     DCumbal       Ajuste numero cuotas LCR    */
/* 02/07/2019     DCumbal       Ajuste Caso 121057 LCR      */
/* 12/07/2019     MDiaz         Ajuste Caso 121920          */
/* 10/05/2020     AGO           PGAD     154017             */
/* 01/09/2021     DCU           Validacion #166586          */
/* 22/Dic/2022    ACH           ERR#199164 Fecha Ultimo Pago*/
/************************************************************/

if exists(select 1 from sysobjects where name = 'sp_gen_buro_act_parciales')
    drop proc sp_gen_buro_act_parciales
go
create proc sp_gen_buro_act_parciales (
    @t_show_version     bit         =   0,
    @i_param1           datetime    =   null, -- FECHA DE PROCESO
    @i_param2           char(1)     =   'N' 
)as
declare
   @w_sp_name       varchar(20),
   @w_s_app         varchar(50),
   @w_path          varchar(50),
   @w_path_obj     varchar(50),
   @w_destino       varchar(2500),
   @w_msg           varchar(200),
   @w_error         int,
   @w_errores       varchar(1500),
   @w_comando       varchar(2500),
   @w_multiplicador int,
   @w_redondeo        int,
   @w_inicio_mes      datetime,
   -- ----------------------------
   @w_cadena        varchar (200),
   @w_version       varchar(10),
   @w_member_code   varchar(20),
   -- ---------------------------
   @w_fecha_ini     datetime,
   @w_fecha_fin     datetime,
   @w_ult_fec_proc  datetime,
   @w_ultimo_dia_def_habil  datetime,
   @w_fecha_cierre  datetime,
   @w_ciudad_nacional int,
   -- ----------------------------
   @w_dia           varchar(2),
   @w_mes           varchar(2),
   @w_ano           varchar(4),
   @w_ext_arch      varchar(6),
   @w_nom_arch      varchar(50),
   @w_nom_log       varchar(50),
   @w_fecha_default datetime,
   -- ---------------------------- Para fecha reporte de buro anterior mensual
   @w_fecha_rep_mes_ant datetime,
   @w_dia_fech_rep  varchar(2),
   @w_mes_fech_rep  varchar(2),
   @w_ano_fech_rep  varchar(4),
   @w_fin_mes_rep_mes_ant date,
   -- ---------------------------- Ejecucion semanal
   @w_ejecuta                char(1) ,
   @w_dia_semana             int     ,
   @w_fecha_proceso          datetime,
   @w_fecha_proceso_aux      datetime,
   @w_dia_reporte              int     ,
   @w_reproceso              char(1) ,
   @w_num_dias               int     
      

select @w_sp_name = 'sp_gen_buro_act_parciales'

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

--///////////////////////////////
-- validar si se procesa o no
DECLARE
@w_reporte          VARCHAR(10),
@w_return           int,
@w_existe_solicitud char (1) ,
@w_ini_mes          datetime ,
@w_fin_mes          datetime ,
@w_fin_mes_hab      datetime ,
@w_fin_mes_ant      datetime ,
@w_fin_mes_ant_hab  datetime

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_dia_reporte =  6, --dia Viernes
       @w_ejecuta   = 'N',
       @w_reproceso = 'N'


select @w_num_dias  = isnull(pa_int,6)
from cobis..cl_parametro
where pa_nemonico = 'NDREPA'

-------------------------------------------------------------
-------------------------------------------------------------
select @w_fecha_proceso =  @i_param1
select @w_dia_semana = datepart(dw, @w_fecha_proceso)  
SELECT @w_reporte = 'BUROE'


if @i_param2 = 'S' --Procesamiento Por Fechas
begin
     select @w_fecha_fin =  @w_fecha_proceso,
            @w_fecha_ini = dateadd(dd,(-1) *@w_num_dias,@w_fecha_proceso),
            @w_ejecuta ='S' 
end
else
begin
if exists(select 1 
          from cob_conta..cb_solicitud_reportes_reg
          where sr_reporte = @w_reporte and sr_status  = 'I')
     select @w_reproceso = 'S'
  
  
  if exists(select 1 
                   from cobis..cl_dias_feriados
                   where df_ciudad = @w_ciudad_nacional
                   and   df_fecha  = @w_fecha_proceso)
  begin
               select @w_ejecuta ='N'                          
  end               
  else
  begin
      if   @w_dia_semana = @w_dia_reporte or  @w_reproceso = 'S' 
      begin
              select @w_ejecuta   = 'S',
                     @w_fecha_fin = @w_fecha_proceso,
                     @w_fecha_ini = dateadd(dd,@w_num_dias*(-1),@w_fecha_proceso) 
        
      end
      else
      begin          
            select @w_ultimo_dia_def_habil = dateadd(day,@w_dia_reporte - @w_dia_semana, @w_fecha_proceso)         
            while exists(select 1 
                         from cobis..cl_dias_feriados
                         where df_ciudad = @w_ciudad_nacional
                         and   df_fecha  = @w_ultimo_dia_def_habil 
                        ) 
            begin
                      select @w_ultimo_dia_def_habil = dateadd(day,1,@w_ultimo_dia_def_habil),
                             @w_num_dias = @w_num_dias + 1
                                    
            end
               
            if @w_ultimo_dia_def_habil = @w_fecha_proceso
            begin
                     select @w_ejecuta   =  'S'             ,
                            @w_fecha_fin =  @w_fecha_proceso,
                            @w_fecha_ini = dateadd(dd,@w_num_dias*(-1),@w_fecha_proceso) 
               
            end
      end
  end
end
-------------------------------------------------------------
if @w_ejecuta = 'N' 
begin
    print 'DIA DIFERENTE A LUNES o FERIADO FECHA INICIO' + convert(varchar,@w_fecha_ini) + ' ' + convert(varchar,@w_fecha_fin)
    goto SALIDA_PROCESO
end   

--///////////////////////////////
--Resultado de ejecutar sp_calcula_ultima_fecha_habil
SELECT
    'eje_@o_ini_mes        '  = @w_ini_mes ,
    'eje_@o_fin_mes        '  = @w_fin_mes ,
    'eje_@o_fin_mes_hab    '  = @w_fin_mes_hab ,
    'eje_@o_fin_mes_ant    '  = @w_fin_mes_ant ,
    'eje_@o_fin_mes_ant_hab'  = @w_fin_mes_ant_hab ,
    'eje_@i_param1         '  = @i_param1
--/////////////////////

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path = ba_path_destino,
       @w_path_obj = ba_path_fuente
from cobis..ba_batch
where ba_batch = 36007


---- ASIGNACION DE VALORES PARA CALCULOS
select @w_multiplicador=1 -- SE USA PARA SUBIR LA PARTE DECIMAL A LA PARTE ENTERA POR LA RESTRICCION DE NO DECIMALES EN LOS CAMPOS MONEDA
select @w_redondeo=0

-- FECHA POR DEFECTO
select @w_fecha_default = '01/01/1900'
-- -------------------------------------------------------------------------------
-- NOMBRE DEL ARCHIVO - INI
select @w_member_code = pa_char
from cobis..cl_parametro
where pa_nemonico='MNBRCD'--='BCCU'
and pa_producto='REC'--='CRE'

select @w_dia = right('00'+convert(varchar(2),datepart(dd, @i_param1)  ),2)
select @w_mes = right('00'+convert(varchar(2),datepart(mm, @i_param1)  ),2)
select @w_ano = convert(varchar(4),datepart(yyyy, @i_param1))

select @w_ext_arch = pa_char
from cobis..cl_parametro
where pa_nemonico = 'EXFCAP'
and pa_producto = 'REC'

select @w_nom_arch = @w_member_code + '_' + @w_dia + @w_mes + @w_ano + '.' + @w_ext_arch
select @w_nom_log  = @w_member_code + '_' + @w_dia + @w_mes + @w_ano + '.err'
-- NOMBRE DEL ARCHIVO - FIN
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- DEFINIENDO FECHA INICIO Y FECHA FIN




select
    @w_ult_fec_proc = max(bf_fecha_proceso)
from sb_buro_fc_fecha_ult_proc
where bf_fecha_proceso < @i_param1

select @w_fecha_cierre = @w_fecha_fin--dateadd(day,-1,@i_param1)
        ---@w_fecha_fin = dateadd(day,-1,@i_param1)
        -- @w_fecha_ini = @w_ult_fec_proc,     
        


select '@w_fecha_ini    ' = @w_fecha_ini ,
       '@w_fecha_fin    ' = @w_fecha_fin ,
       '@w_fecha_cierre ' = @w_fecha_cierre


-- -------------------------------------------------------------------------------

   -- ------------------------------------------------------------------------------------
   -- SEGMENTO DE INICIO DE ARCHIVO - INI
   -- ------------------------------------------------------------------------------------
   -- Se añade esto porque se pide la fecha del ultimo reporte mensual generado
select @w_dia_fech_rep = right('00'+convert(varchar(2),datepart(dd, @w_fecha_cierre)  ),2)
select @w_mes_fech_rep = right('00'+convert(varchar(2),datepart(mm, @w_fecha_cierre)  ),2)
select @w_ano_fech_rep = convert(varchar(4),datepart(yyyy, @w_fecha_cierre))
    
   truncate table sb_rep_buro_f_corto_final

   select @w_cadena = 'BOF' +'|'+ @w_member_code +'|'+ @w_dia_fech_rep + @w_mes_fech_rep + @w_ano_fech_rep +'|'+ '**' +'|'
   
   insert into sb_rep_buro_f_corto_final(rb_cadena) values (@w_cadena)

   -- ------------------------------------------------------------------------------------
   -- SEGMENTO DE INICIO DE ARCHIVO - FIN
   -- ------------------------------------------------------------------------------------

   PRINT '111111111111111111111- segmento de inicio'
   -- ------------------------------------------------------------------------------------
   -- INI - SEGMENTO DE CUENTA O CREDITO DEL CLIENTE
   -- ------------------------------------------------------------------------------------
    truncate table sb_rpt_buro_frmt_act_parc

    INSERT INTO sb_rpt_buro_frmt_act_parc
      (rf_fecha_report, rf_operacion,  rf_ente,       rf_num_cta,    rf_tipo_re_cta,   rf_tipo_cta,   rf_tipo_prod,  rf_mon_cred,
       rf_num_pagos,    rf_frec_pagos, rf_monto_pagar,rf_fecha_apert,rf_fec_ult_pag,   rf_fec_ult_cmp,rf_fec_cierre, rf_fec_rep_inf,
       rf_cre_max_aut,  rf_saldo_act,  rf_limit_cred, rf_saldo_venc, rf_num_pa_venc,   rf_for_pag_act,rf_clave_obsr)
   select 'fecha'       = @w_fecha_cierre, --IGUAL 
         'operacion'    = case when do_operacion is null then
                               (select op_operacion from cob_cartera..ca_operacion where op_banco = do_banco)
                          else
                                do_operacion
                          end,                               
         'ente'      = do_codigo_cliente, --IGUAL 
         'num_cta'   = ltrim(rtrim(do_banco)), --IGUAL 04
         'tipo_resp' =  'I',
         'tipo_cta'  = case when do_tipo_operacion = 'REVOLVENTE' then 'R'  else 'I'  end, --IGUAL06
         'tipo_prod' = case when do_tipo_operacion = 'REVOLVENTE' then 'CL' else 'PL' end, --IGUAL07
         'mon_cred'  = (select eq_valor_arch from sb_equivalencias--IGUAL08
                       where eq_catalogo='CL_MONEDA' and eq_valor_cat=do_moneda),
         'num_pagos' = case when do_tipo_operacion in ('REVOLVENTE') then ' ' else convert(varchar(10),do_num_cuotas) end,--IGUAL10                       
         'frec_pagos'= case when do_tipo_operacion not in ('REVOLVENTE') then
		                         case when do_periodicidad  <> 1 then
                                      (select eq_valor_arch from sb_equivalencias where eq_catalogo='FREC_PAGOS' and eq_valor_cat = convert(varchar(2),do_periodicidad ) + do_tplazo )
								 else case (select eq_valor_arch from sb_equivalencias where eq_catalogo='FREC_PAGOS' and eq_valor_cat = do_tplazo)
                                      when null then ''
                                      else (select upper(eq_valor_arch) from sb_equivalencias where eq_catalogo='FREC_PAGOS' and eq_valor_cat = do_tplazo)
                                      end
                                 end			  						  
                             else 'Z' end,
         'monto_pag' = case when do_estado_cartera = 3 and  do_tipo_operacion <> 'REVOLVENTE'  then 0
                            when do_estado_cartera = 3 and  do_tipo_operacion = 'REVOLVENTE'   and do_fecha_vencimiento < @i_param1 then 0
                            when do_estado_cartera <> 3 and  do_tipo_operacion <> 'REVOLVENTE' then
	                             case do_periodicidad_cuota
                                      when 7  then convert(bigint,(round(isnull(do_valor_cuota,0)* 4,@w_redondeo))*@w_multiplicador)
			                          when 14 then convert(bigint,(round(isnull(do_valor_cuota,0)* 2,@w_redondeo))*@w_multiplicador)
                                      when 15 then convert(bigint,(round(isnull(do_valor_cuota,0)* 2,@w_redondeo))*@w_multiplicador)                    
                                      when 30 then convert(bigint,(round(isnull(do_valor_cuota,0)* 1,@w_redondeo))*@w_multiplicador)
                                      else 0
                                 end
	                        when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora > 0 then
	                             convert(bigint,(round(isnull(do_saldo_cuotaven,0),@w_redondeo)) *@w_multiplicador)
	                        when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora = 0 and do_fecha_vencimiento >= @i_param1 then
	                             convert(bigint,(round(isnull(do_saldo,0)/3,@w_redondeo)) *@w_multiplicador)
	                        when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora = 0 and do_fecha_vencimiento < @i_param1 then
	                             convert(bigint,(round(isnull(do_saldo,0)/3,@w_redondeo)) *@w_multiplicador)								 
		               end,	   
         'fech_aper' = isnull(replace(convert(varchar(10),do_fecha_concesion,103),'/',''),'01011900'), --IGUAL13
         --14--Preguntar si se deja fecha por defecto
         'fec_ult_pg'= isnull(replace(convert(varchar(10),isnull(do_fecha_ult_pago,@w_fecha_default),103),'/',''),''),-- PDF 'Manual Buro Credito PDF v14' pag 68 regla 16
         --Se deja como antes por descripción en pdf
         'fec_ult_cp'=  case when do_tipo_operacion <> 'REVOLVENTE' then
                             isnull(replace(convert(varchar(10),isnull(do_fecha_ult_pago,@w_fecha_default),103),'/',''),'') -- PDF 'Manual Buro Credito PDF v14' pag 68 regla 16
                        else
                             ( select  isnull(replace(convert(varchar(10),isnull(max(dt_fecha_trans),@w_fecha_default),103),'/',''),'')
                               from cob_conta_super..sb_dato_transaccion
                               where dt_banco      = do_banco
                               and dt_tipo_trans   = 'DES'
                               and dt_fecha_trans <= @i_param1
                              )end,    
         --IGUAL16
		 'fec_cierre'= (case when do_estado_cartera = '3' and do_tipo_operacion <> 'REVOLVENTE' then
                                  replace(convert(varchar(10),do_fecha_proceso,103),'/','')
                             when do_estado_cartera = '3' and do_tipo_operacion = 'REVOLVENTE' and do_fecha_vencimiento < @i_param1 and 
							      do_fecha_vencimiento >= do_fecha_proceso then   
                                  replace(convert(varchar(10),do_fecha_vencimiento,103),'/','')
							 when do_estado_cartera = '3' and do_tipo_operacion = 'REVOLVENTE' and do_fecha_vencimiento < @i_param1 and 
							      do_fecha_vencimiento < do_fecha_proceso then   
                                  replace(convert(varchar(10),do_fecha_proceso,103),'/','')
                             else ''
                        end),
         'fec_rp_inf'= replace(convert(varchar(10),@w_fecha_cierre,103),'/',''), --IGUAL17
         'cre_mx_aut'= case when do_tipo_operacion = 'REVOLVENTE' then
                           convert(varchar(20),convert(bigint,(round(do_monto_aprobado,@w_redondeo))*@w_multiplicador))
                       else
                           convert(bigint,(round(do_monto,@w_redondeo))*@w_multiplicador)--IGUAL21
                       end,
         --Se cambia para que sea IGUAL22
		 'saldo_act' = isnull(convert(bigint,(round(do_saldo,@w_redondeo))*@w_multiplicador),0),                       
		 --Segun correo si no tiene debe ir vacio
         'limit_cred'= case when do_tipo_operacion = 'REVOLVENTE' then
                           convert(varchar(20),convert(bigint,(round(do_monto_aprobado,@w_redondeo))*@w_multiplicador))
                       else '' end,
		 --Se deja resultado igual al 24
         'saldo_venc'= case when do_tipo_operacion <> 'REVOLVENTE'  then
                            convert(bigint,(round(isnull(ceiling(do_saldo_total_Vencido),0),@w_redondeo))*@w_multiplicador)
                       when do_tipo_operacion = 'REVOLVENTE' and  do_edad_mora > 0 then
                             convert(bigint,(round(isnull(ceiling(do_saldo_cuotaven),0),@w_redondeo))*@w_multiplicador)
                       else 
                              0
                       end, 
         --Se deja resultado igual al 25
         'num_pa_ven'= case when (do_num_cuotaven != 0 and do_num_cuotaven is not null) then
                            do_num_cuotaven
                       else 
                            ''
                       end,
		 --Se deja resultado igual al 26
         'fr_pag_act'= (select codigo_sib  from cob_credito..cr_corresp_sib where tabla = 'ca_forma_pago_mop' 
		               and   isnull(do_dias_mora_365, 0)  between limite_inf and limite_sup),
         --IGUAL30
         'clave_obsr'= (case when do_estado_cartera = 3 and do_tipo_operacion <> 'REVOLVENTE' then 'CC'
                             when do_estado_cartera = 3 and do_tipo_operacion =  'REVOLVENTE' and do_fecha_vencimiento <= @i_param1 and do_saldo = 0then 'CC'
                             else ''  end)
   from  cob_conta_super..sb_dato_operacion         
   where  do_fecha             = @i_param1
   and    do_aplicativo        = 7
   and    do_fecha_ult_pago between @w_fecha_ini and @w_fecha_fin
   and do_monto <= 9999999


   if @@error <> 0
   begin
      select @w_msg = 'ERROR EN INSERCION SB_RPT_BURO_FRMT_ACT_PARC'
      exec cob_conta_super..sp_errorlog
      @i_fecha_fin     = @i_param1,
      @i_fuente        = @w_sp_name,
      @i_origen_error  = '70011010',
      @i_descrp_error  = @w_msg
   end
   
   update sb_rpt_buro_frmt_act_parc set
   rf_monto_pagar = rf_saldo_act
   where rf_monto_pagar > rf_saldo_act
      
   
   update sb_rpt_buro_frmt_act_parc set
   rf_saldo_venc = rf_saldo_act
   where rf_saldo_venc > rf_saldo_act
   
  
----------------------------------------------------------------------------------------
---SECCION DE PAGOS QUE RESULTARON DE PAGOS CONDONADOS CANCELADOS EL MISMO DIA --------
----------------------------------------------------------------------------------------

select 
operacion 		  = ab_operacion ,
banco             = convert(varchar(24), null), 
fecha_pag         = replace(convert(varchar(10),max(ab_fecha_pag),103),'/',''),
estado_op         = convert(int, null),
fecha_can         = rf_fec_cierre,
monto_con 		  =sum(abd_monto_mn),
secuencial_cond   = max (ab_secuencial_ing) 
into #abonos_con
from cob_cartera..ca_abono,
cob_cartera..ca_abono_det ,
sb_rpt_buro_frmt_act_parc
where ab_operacion = rf_operacion
and ab_operacion  = abd_operacion
and ab_secuencial_ing = abd_secuencial_ing
and ab_estado = 'A'
and abd_tipo = 'CON'
and ab_usuario <> 'usrcond'
group by ab_operacion,rf_fec_cierre



update #abonos_con set 
estado_op   = op_estado,
banco       = op_banco 
from  cob_cartera..ca_operacion  
where operacion   = op_operacion 



delete #abonos_con where estado_op not in (3)


delete #abonos_con where fecha_pag <>fecha_can


---ACTUALIZACION DE CLAVE 20 A LC DE ACUERDO A REQUERIMIENTO 154017 MODIFICACIONES PGAD

select s.* into #sb_rpt_buro_frmt_act_parc
from  sb_rpt_buro_frmt_act_parc s, #abonos_con
where rf_operacion = operacion  

 
---ACTUALIZACION A LOS VALORES PARA CUANDO ES CONDONADO EN LA COPIA DE BURO CUENTAS 
   
   
update #sb_rpt_buro_frmt_act_parc set 
rf_clave_obsr = 'LC',     --30
rf_saldo_venc = convert(bigint,(round(isnull(ceiling(monto_con),0),@w_redondeo))*@w_multiplicador) ,  --24
rf_for_pag_act    = '97',
rf_fec_cierre = replace(convert(varchar(10),fecha_can,103),'/',''),
rf_saldo_act  = convert(bigint,(round(isnull(ceiling(0),0),@w_redondeo))*@w_multiplicador) 
from #abonos_con where 
rf_operacion = operacion


   
insert into   sb_rpt_buro_frmt_act_parc
select * from #sb_rpt_buro_frmt_act_parc


---

delete sb_rpt_buro_frmt_act_parc 
where rf_operacion in (select rf_operacion from #sb_rpt_buro_frmt_act_parc)
and rf_clave_obsr <> 'LC'

   -- ------------------------------------------------------------------------------------
   -- FIN - SEGMENTO DE CUENTA O CRÉDITO DEL CLIENTE
   -- ------------------------------------------------------------------------------------

   -- GENERO LAS LINEAS PARA EL ARCHIVO
   insert INTO sb_rep_buro_f_corto_final(rb_cadena)
   select
      isnull(rf_num_cta    ,'') +'|'+ isnull(rf_tipo_re_cta,'') +'|'+ isnull(rf_tipo_cta   ,'') +'|'+ isnull(rf_tipo_prod  ,'') +'|'+
      isnull(rf_mon_cred   ,'0')+'|'+ isnull(rf_num_pagos  ,'') +'|'+ isnull(rf_frec_pagos ,'') +'|'+ isnull(rf_monto_pagar,'0') +'|'+
      isnull(rf_fecha_apert,'') +'|'+ isnull(rf_fec_ult_pag,replace(convert(varchar(10),@w_fecha_cierre,103),'/','')) +'|'+
      isnull(rf_fec_ult_cmp,'') +'|'+
      isnull(rf_fec_cierre, replace(convert(varchar(10),@w_fecha_cierre,103),'/','')) +'|'+
      isnull(rf_fec_rep_inf,'') +'|'+ isnull(rf_cre_max_aut,'0') +'|'+ case when rf_saldo_act = 0 then '00' else convert(VARCHAR,rf_saldo_act) end +'|'+
      isnull(rf_limit_cred ,'') +'|'+ convert(varchar,rf_saldo_venc) +'|'+  isnull(rf_num_pa_venc,'') +'|'+
      isnull(rf_for_pag_act,'') +'|'+ isnull(rf_clave_obsr ,'') +'|**|'
   from sb_rpt_buro_frmt_act_parc

   -- ------------------------------------------------------------------------------------
   -- INI - SEGMENTO DE FIN DE ARCHIVO
   -- ------------------------------------------------------------------------------------
   insert into sb_rep_buro_f_corto_final(rb_cadena)
   select 'EOF' + '|'
         + convert(varchar(9),count(rf_num_cta)) + '|'
         + convert(varchar(14),isnull(sum(rf_saldo_act),0)) + '|'
         + convert(varchar(14),isnull(sum(rf_saldo_venc),0)) + '|'
         + '**' +'|'
   from sb_rpt_buro_frmt_act_parc
   -- ------------------------------------------------------------------------------------
   -- FIN - SEGMENTO DE FIN DE ARCHIVO
   -- ------------------------------------------------------------------------------------

   select @w_comando = 'bcp "select rb_cadena from cob_conta_super..sb_rep_buro_f_corto_final order by rb_id" queryout '
    select @w_destino  = @w_path + @w_nom_arch, -- MEMBERCODE_DDMMYYYY.ext
          @w_errores  = @w_path + @w_nom_log   -- MEMBERCODE_DDMMYYYY.err
    select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -T -e' + @w_errores

    --Ejecucion para Generar Archivo Datos
   exec @w_error = xp_cmdshell @w_comando
    if @w_error <> 0 begin
        select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
        exec cob_conta_super..sp_errorlog
        @i_fecha_fin     = @i_param1,
        @i_fuente        = @w_sp_name,
        @i_origen_error  = '28016',
        @i_descrp_error  = @w_msg

        return 1
    end


   -- ------------------------------------------------------------------------------------
 /*  select @w_comando = @w_path_obj + 'cloud-process-intf-1.0.0-jar-with-dependencies.jar ' +
                       @w_path + @w_nom_arch + ' #' --@w_path + 'reporte_buro_' + replace(convert(varchar(10),@i_param1,103),'/','')+ '.txt'
   exec @w_error = xp_cmdshell @w_comando
   if @w_error <> 0 begin
      select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
      exec cob_conta_super..sp_errorlog
      @i_fecha_fin     = @i_param1,
      @i_fuente        = @w_sp_name,
      @i_origen_error  = '28016',
      @i_descrp_error  = @w_msg
      return 1
   end*/
   -- ------------------------------------------------------------------------------------


   -- ------------------------------------------------------------------------------------
   -- ACTUALIZACION DE LA FECHA DE PROCESADO - INI
   insert into sb_buro_fc_fecha_ult_proc(bf_fecha_proceso)values(@i_param1)
   if @@error <> 0
   begin
      select @w_msg = 'ERROR EN INGRESO DE LA FECHA PROCESO - INTF FORMATO CORTO'
      exec cob_conta_super..sp_errorlog
      @i_fecha_fin     = @i_param1,
      @i_fuente        = @w_sp_name,
      @i_origen_error  = '70011015',
      @i_descrp_error  = @w_msg
   end
   -- ACTUALIZACION DE LA FECHA DE PROCESADO - FIN
   -- ------------------------------------------------------------------------------------



update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I'

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

SALIDA_PROCESO:
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg

go