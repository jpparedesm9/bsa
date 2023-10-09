
/*************************************************************/
/*   ARCHIVO:         	sp_data_garlig_seg.sp                */
/*   NOMBRE LOGICO:   	sp_data_garlig_seg.sp                */
/*   PRODUCTO:        		CARTERA                          */
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
/*   Este procedimiento permite generar los montos para      */
/*   cobros de seguros y garantias liquidas                  */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA          AUTOR    RAZON                           */
/*   09-Oct-2019    PXSG     Req. 124807                     */
/*   16-Ene-2020    DCU      Req. 126891                     */
/*   17/09/2020     DCU      Req. 141620                     */
/*   20/01/2020     DCU      Req. 140073                     */
/*   03/Mar/2021    SRO      Req #147999                     */
/*   06/Ene/2022    AGO      Req #175901                     */
/*   09/Jun/2022    ACH      Req #185234-calculo dl seguro   */
/*   12/Oct/2022    DCU      Req. #195239                    */
/*   05/09/2022     ACH      ERR#192858 alta asistencia medic*/
/*   05/09/2022     ACH      ERR#192858 alta asistencia medic*/
/*   27/04/2023     DBM      Req#203379 ajuste plazo asis med*/
/*************************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.sp_data_garlig_seg') IS NOT NULL
	DROP PROCEDURE dbo.sp_data_garlig_seg
GO

CREATE PROCEDURE sp_data_garlig_seg (	
   @s_ssn            int           = null,
   @s_ofi            smallint,
   @s_user           login,
   @s_date           datetime,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int = null,    
   @i_id_empresa     int = null, 	 
   @o_id_resultado   smallint out
   
)
as 

DECLARE
@w_grupo                int,
@w_grupal               char(1),
@w_monto_gar_liquida    money,
@w_porcentaje_monto     float,
@w_fecha_pro_orig       datetime,
@w_referencia           varchar(30),
@w_fecha_proceso        datetime,
@w_fecha_ini_credito    datetime,
@w_moneda               tinyint,
@w_oficina              smallint,
@w_ruta_xml             varchar(255),
@w_error                int,
@w_sql_bcp              varchar(5000),
@w_sql                  varchar(5000),
@w_mensaje_bcp          varchar(150),
@w_param_ISSUER         varchar(30),
@w_sp_name              varchar(30),
@w_nombre_grupo         varchar(64),
@w_corresponsal         varchar(20), 
@w_id_corresp           varchar(10),
@w_sp_corresponsal      varchar(50),
@w_descripcion_corresp  varchar(30),
@w_fail_tran            char(1),
@w_convenio             varchar(30),
@w_tipo_tran            varchar(4),
@w_tramite              int,
@w_promocion            char(1),
@w_monto_seguro_basico  money   ,
@w_banco_grupal         cuenta  ,
@w_operacion_grupal     int     ,
@w_edad_max_param       int     ,
@w_dias_adicionales     int     ,
@w_tipo_plazo           varchar(10),
@w_plazo                int,
@w_plazo_asis_med       int,
@w_valor_basico         money,
@w_gracia               int ,
@w_num_dec              int ,
@w_tipo_basico          catalogo,
--variables históricos
@w_secuencial           INT,
@w_cliente              int,
@w_operacion            int,
@w_banco                varchar(24),
@w_fecha_ini            datetime,
@w_monto                money,
@w_tipo_seguro          varchar(20),
@w_monto_basico         money,
@w_paga_seguro          varchar(2),
@w_resultado            varchar(2),
@w_msg                  varchar(255),
@w_toperacion           varchar(10),
@w_tipo_producto        varchar(255),
@w_carga_valor          char(1),
@w_meses_maximo_seg     int,
@w_meses_default_seg    int

/*  Inicializacion de Variables  */
select 
@w_sp_name   = 'sp_data_garlig_seg',
@w_tipo_tran = 'GL',
@w_tipo_basico = 'BASICO'

select 
@w_tramite = convert(int, io_campo_3),
@w_cliente = io_campo_1
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

--Datos iniciales		
select 
@w_grupal            = tr_grupal,
@w_fecha_ini_credito = tr_fecha_apr,
@w_moneda            = tr_moneda,
@w_oficina           = tr_oficina,
@w_grupo             = tr_cliente,
@w_promocion         = isnull(tr_promocion,'N'),
@w_toperacion        = tr_toperacion
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

if (@@rowcount = 0)
begin
    select @w_error = 724637
    goto ERROR
end 

print '@w_tramite'+convert(varchar(50),@w_tramite)

select @w_dias_adicionales = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'NDEDAD'
and   pa_producto = 'ADM'

------------------------------------------------------------------
--Regla porcentaje para el calculo de la garantia
------------------------------------------------------------------
select @w_carga_valor = 'S'

exec @w_error = cob_credito..sp_eje_reg_porc_cobro_gl
@i_id_inst_proc = @i_id_inst_proc,
@o_respuesta = @w_porcentaje_monto out 

if @w_error <> 0 begin 
   select 
   @w_msg  = 'ERROR: AL EJECUTAR LA REGLA DE sp_eje_reg_porc_cobro_gl' ,
   @w_error = 70005
   goto ERROR  
end

print '--->>>@w_toperacion: '+convert(varchar(50), @w_toperacion) + '--->>>@w_tramite: '+convert(varchar(50), @w_tramite)
print '--->>>@w_porcentaje_monto: '+convert(varchar(50), @w_porcentaje_monto)

if (@w_toperacion = 'GRUPAL' and @w_porcentaje_monto is null and @w_promocion = 'N') begin
    select @w_porcentaje_monto = pa_float
    from cobis..cl_parametro
    where pa_nemonico = 'PGARGR' -- PORCENTAJE GARANTIA CREDITO GRUPAL
    and pa_producto = 'CCA'
end

if (@w_toperacion = 'GRUPAL' and @w_porcentaje_monto is null and @w_promocion = 'S') begin
    select @w_porcentaje_monto = pa_float
    from cobis..cl_parametro 
    where pa_nemonico = 'PGARAN' -- PORCENTAJE GARANTIA CREDITO ANIMATE
    and pa_producto = 'CCA'
end
	
if (@w_toperacion = 'INDIVIDUAL' and @w_porcentaje_monto is null) begin-- aun no esta implementado segunda fase
    select @w_porcentaje_monto = pa_float
    from cobis..cl_parametro
    where pa_nemonico = 'PGAIND' -- PORCENTAJE GARANTIA CREDITO INDIVIDUAL
    and pa_producto = 'CCA'
end

if @w_promocion = 'S' and @w_toperacion = 'GRUPAL' and @w_porcentaje_monto = 0
   select @w_carga_valor = 'N'

------------------------------------------------------------------
------------------------------------------------------------------

--Parametro de edad
select @w_edad_max_param=pa_tinyint 
from cobis..cl_parametro
where pa_nemonico='EMACI'
and   pa_producto='CRE'

print '@w_edad_max_param'+convert(varchar(50),@w_edad_max_param)


--Parametro referencia del corresponsal
select @w_param_ISSUER = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'ISSUER' 
and pa_producto = 'CCA'

if (@@error != 0 or @@rowcount != 1)
begin
    select @w_error = 724629
    goto ERROR
end

--Fecha proceso y cálculo de fecha de vencimiento del pago
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha_proceso  = convert(datetime,convert(varchar(10), @w_fecha_proceso,101) + ' ' + convert(varchar(12),getdate(),114))
select @w_fecha_pro_orig = dateadd(hour,36,@w_fecha_proceso)

--- NUMERO DE DECIMALES 
exec @w_error = sp_decimales
@i_moneda      = @w_moneda ,
@o_decimales   = @w_num_dec out   

--INICIALIZACION POR DEFECTO    
select  @w_paga_seguro  = 'SI'
if @i_id_inst_proc is not null begin
   exec @w_error           = cob_cartera..sp_ejecutar_regla
   @s_ssn                  = @s_ssn,
   @s_ofi                  = @s_ofi,
   @s_user                 = @s_user,
   @s_date                 = @w_fecha_proceso,
   @s_srv                  = @s_srv,
   @s_term                 = @s_term,
   @s_rol                  = @s_rol,
   @s_lsrv                 = @s_lsrv,
   @s_sesn                 = @s_ssn,
   @i_regla                = 'COBROSEGUR', 
   @i_tipo_ejecucion       = 'WORKFLOW',	 
   @i_id_inst_proc         = @i_id_inst_proc,
   @o_resultado1           = @w_resultado  out
   
   if @w_error <> 0 begin 
      select 
      @w_msg  = 'ERROR: AL EJECUTAR LA REGLA DE PAGA SEGURP' ,
      @w_error= 70005
      goto ERROR  
   end
   select @w_paga_seguro = @w_resultado
end 
else begin
   select  
   @w_paga_seguro  = 'SI'
end


--Inserto lo que ya tengo en seguros
create table #seguros(
    tramite     int       ,
    grupo       int       ,
    cliente     int         null,
    monto       money       null,
    monto_pag   money       null,
    edad_string varchar(50) null,
    anio        int         null,
    mes         int         null,
    dia         int         null,
    forma_pago  varchar(16) null,
    tipo_seguro varchar(16) null,
    monto_basico money      null,
    plazo_asis_med int      null
)

create table #garantialiq_tmp(
    id                int identity,
    tramite           int,
    cliente           int,
    fecha_vencimiento datetime,
    pag_estado        char(2) null,  --cambio realizado por problemas en dev y test en sust no da inconvenientes
    dev_estado        char(2) null,  --cambio realizado por problemas en dev y test en sust no da inconvenientes
    monto_individual  money,
    monto_garantia    money,
    monto_pagado      money
)

--Inicio llenado de tabla para seguros tanto para Grupo promo y Grupo no promo
create table #ca_seguro_externo_tmp	(
    id                       int identity,
    se_operacion_tmp         int,
    se_banco_tmp             varchar (24),
    se_cliente_tmp           int,
    se_fecha_ini_tmp         datetime,
    se_fecha_ult_intento_tmp datetime,
    se_monto_tmp             money,
    se_estado_tmp            char (1),
    se_tramite_tmp           int,
    se_grupo_tmp             int,
    se_monto_pagado_tmp      money       null,
    se_forma_pago            varchar(16) null,
    se_tipo_seguro           varchar(16) null,
    se_monto_basico          money       null,
    se_plazo_asis_med        int         null
)
		
if @w_toperacion = 'GRUPAL'
begin
    
   select top 1 
   @w_banco_grupal     = op_banco,
   @w_operacion_grupal = op_operacion,  
   @w_tipo_plazo       = op_tplazo,
   @w_plazo            = op_plazo ,
   @w_gracia           = isnull(op_desplazamiento,0),
   @w_moneda           = op_moneda
   from cob_credito..cr_tramite_grupal,
        cob_cartera..ca_operacion
   where tg_tramite   = @w_tramite
   and   op_banco     = tg_referencia_grupal

   if exists (select 1 from cob_cartera..ca_seguro_externo where se_tramite = @w_tramite)
   begin
      insert into #seguros(
      tramite      , grupo                     , cliente    ,
      monto        , monto_pag                 , edad_string,
      forma_pago   , tipo_seguro               , monto_basico,
      plazo_asis_med)                          
      select                                                
      se_tramite   , se_grupo                  , se_cliente,
      0            , isnull(se_monto_pagado, 0), null         ,
      se_forma_pago, se_tipo_seguro            , 0            ,
      se_plazo_asis_med
      from cob_cartera..ca_seguro_externo                  
      where se_tramite = @w_tramite                         
   end                                              
   else                                                  
   begin                                                 
      insert into #seguros(                            
      tramite      , grupo                     ,  cliente    ,
      monto        , monto_pag                 ,  edad_string,
      forma_pago   , tipo_seguro               , monto_basico,
      plazo_asis_med)              
      select                                                  
      tg_tramite   , tg_grupo                  ,  tg_cliente,
      0            , 0                         ,  null         ,
      null         , 'BASICO'                  , 0,
      null
      from cob_credito..cr_tramite_grupal
      where tg_tramite = @w_tramite
      and   tg_participa_ciclo = 'S'  
   end
   
   
   update #seguros set 
   edad_string=cobis.dbo.fn_calculo_edad(p_fecha_nac,dateadd(dd,@w_dias_adicionales,@w_fecha_proceso)) 
   from cobis..cl_ente
   where en_ente=cliente
   
   update #seguros set 
   anio        = convert(int,substring(edad_string,0,charindex('|',edad_string))), 
   edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
   
   update #seguros set 
   mes         = convert(int,substring(edad_string,0,charindex('|',edad_string))),
   edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
   
   update #seguros set 
   dia         = convert(int,edad_string)
   
   --Se comenta para el caso que va a pasar
   if @w_gracia >0 and @w_gracia is not null
      select @w_plazo = @w_plazo + isnull(@w_gracia,0)
            
   select *
   into #ca_param_seguro_externo
   from cob_cartera..ca_param_seguro_externo
   where se_estado = 'V'
   and   se_producto = 'GRUPAL'
   
   
   if @w_paga_seguro = 'NO'
   begin
      update #ca_param_seguro_externo set
      se_valor = 0,
      se_asistencia_funeraria = 0
      where se_paquete = @w_tipo_basico
   end
   
   select 
   se_id, 
   se_paquete, 
   se_edad_max,  
   se_total = round(sum(se_asistencia_funeraria + se_valor) *
              case when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'D' then round(convert(float,@w_plazo)/30,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'W' then round(convert(float,@w_plazo)* 7 /30,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'Q' then round(convert(float,@w_plazo) /2,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'M' then round(convert(float,@w_plazo),0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'B' then round(convert(float,@w_plazo) * 2,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'T' then round(convert(float,@w_plazo) * 3,0)
                   when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'S' then round(convert(float,@w_plazo) * 6,0)
               else  
                    1
               end,@w_num_dec) ,
   se_basico    = convert(money,0)           
   into #valores_seguro
   from #ca_param_seguro_externo
   where se_estado = 'V'
   group by se_id, se_paquete, se_edad_max
   
   select @w_valor_basico =se_total
   from #valores_seguro
   where se_paquete = @w_tipo_basico
   
   update #valores_seguro set 
   se_basico   =  isnull(@w_valor_basico,0)
   where se_total > 0
   
   update #valores_seguro
   set se_total = se_total + isnull(@w_valor_basico,0)
   where se_paquete <> @w_tipo_basico
   and   se_total   > 0 
   
   update #seguros set 
   monto =se_total,
   monto_basico = se_basico
   from #valores_seguro
   where se_paquete = tipo_seguro
   and ((anio >= 18 and  anio < se_edad_max)
   or   (anio = se_edad_max and  mes = 0 and   dia = 0 ))

   --caso#192858
   update #seguros set 
   tipo_seguro = 'NINGUNO'
   from #valores_seguro
   where se_paquete = tipo_seguro
   and ((anio < 18) or  (anio > se_edad_max) or (anio = se_edad_max and mes > 0) or (anio = se_edad_max and dia > 0))
      
   update #seguros set
   monto = 0
   where tramite = @w_tramite
   and   cliente not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite and tg_participa_ciclo = 'S' )
      
   update #seguros set
   monto_basico = 0
   where monto = 0
   
   insert into #ca_seguro_externo_tmp (
   se_operacion_tmp   , se_banco_tmp            , se_cliente_tmp,
   se_fecha_ini_tmp   , se_fecha_ult_intento_tmp, se_monto_tmp  ,
   se_estado_tmp      , se_tramite_tmp          , se_grupo_tmp  ,
   se_monto_pagado_tmp, se_forma_pago           , se_tipo_seguro,
   se_monto_basico, se_plazo_asis_med  )
   select                                                                  
   @w_operacion_grupal, @w_banco_grupal         , cliente       ,
   @w_fecha_proceso   , @w_fecha_pro_orig       , sum(monto)    ,
   'C'                , tramite                 , grupo                     , 
   pago=sum(isnull(monto_pag,0)), case when sum(isnull(monto_pag,0)) >0 then max(forma_pago) else null end,
   tipo_seguro, monto_basico, plazo_asis_med
   from #seguros
   group by tramite, grupo, cliente, tipo_seguro, monto_basico, plazo_asis_med
   
   --Encuentro el monto de los seguros
   select @w_monto_seguro_basico=sum(isnull(se_monto_tmp,0)-isnull(se_monto_pagado_tmp,0))
   from #ca_seguro_externo_tmp
   select @w_monto_seguro_basico
   
   --Inserccion en tablas fisicas de seguro
   delete from cob_cartera..ca_seguro_externo
   where se_tramite   = @w_tramite
    
   insert into ca_seguro_externo (
   se_operacion,            se_banco,                   se_cliente,
   se_fecha_ini,            se_fecha_ult_intento,       se_monto  ,
   se_estado,               se_tramite,                 se_grupo  ,
   se_monto_pagado,         se_forma_pago,              se_tipo_seguro,
   se_monto_basico,         se_usuario,                 se_terminal,
   se_plazo_asis_med)
   select 
   se_operacion_tmp,        se_banco_tmp,               se_cliente_tmp,
   se_fecha_ini_tmp,        se_fecha_ult_intento_tmp,   case when se_monto_tmp >=0 then se_monto_tmp else 0 end ,
   se_estado_tmp,           se_tramite_tmp,             se_grupo_tmp,
   se_monto_pagado_tmp,     se_forma_pago ,             se_tipo_seguro,
   se_monto_basico,         @s_user,                    @s_term,
   se_plazo_asis_med
   from #ca_seguro_externo_tmp
    --Fin Llenado de tabla de seguros
    
   --Aqui iba -- Inicio de tabla de Garantia solo No Promo
end else begin

    select top 1 
    @w_banco_grupal     = op_banco,
    @w_operacion_grupal = op_operacion,  
    @w_tipo_plazo       = case when op_tplazo = 'W' and op_periodo_int = 2 and op_periodo_cap = 2 then 'BW' else op_tplazo end,
    @w_plazo            = op_plazo ,
    @w_gracia           = isnull(op_desplazamiento,0),
    @w_moneda           = op_moneda
    from cob_cartera..ca_operacion
    where op_tramite   = @w_tramite        
    
    if exists (select 1 from cob_cartera..ca_seguro_externo where se_tramite = @w_tramite)
    begin
        insert into #seguros(
        tramite      , grupo                     , cliente    ,
        monto        , monto_pag                 , edad_string,
        forma_pago   , tipo_seguro               , monto_basico,
        plazo_asis_med)                          
        select                                                
        se_tramite   , se_grupo                  , se_cliente,
        0            , isnull(se_monto_pagado, 0), null         ,
        se_forma_pago, se_tipo_seguro            , 0            ,
        se_plazo_asis_med
        from cob_cartera..ca_seguro_externo                  
        where se_tramite = @w_tramite                         
    end                                              
    else                                                  
    begin                                                 
        insert into #seguros(                            
        tramite      , grupo                     ,  cliente    ,
        monto        , monto_pag                 ,  edad_string,
        forma_pago   , tipo_seguro               ,  monto_basico,
        plazo_asis_med)              
        select                                                  
        tr_tramite   , 0                         ,  tr_cliente,
        0            , 0                         ,  null         ,
        null         , 'BASICO'                  , 0             ,
        null
        from cob_credito..cr_tramite
        where tr_tramite = @w_tramite  
    end

   select top 1
   @w_plazo_asis_med = se_plazo_asis_med
   from cob_cartera..ca_seguro_externo
   where se_tramite = @w_tramite
            
    update #seguros set 
    edad_string=cobis.dbo.fn_calculo_edad(p_fecha_nac,dateadd(dd,@w_dias_adicionales,@w_fecha_proceso)) 
    from cobis..cl_ente
    where en_ente=cliente
    
    update #seguros set 
    anio        = convert(int,substring(edad_string,0,charindex('|',edad_string))), 
    edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
    
    update #seguros set 
    mes         = convert(int,substring(edad_string,0,charindex('|',edad_string))),
    edad_string = substring(edad_string,charindex('|',edad_string)+1,len(edad_string))
    
    update #seguros set 
    dia         = convert(int,edad_string)
    
    --Se comenta para el caso que va a pasar
    if @w_gracia > 0 and @w_gracia is not null
       select @w_plazo = @w_plazo + isnull(@w_gracia,0)
       
    select *
    into #ca_param_seguro_externo_1
    from cob_cartera..ca_param_seguro_externo
    where se_estado = 'V'
    and   se_producto = @w_toperacion--'INDIVIDUAL'

    update #ca_param_seguro_externo_1
    set se_valor = (select pm_valor * @w_plazo_asis_med from cob_cartera..ca_plazo_asis_med where pm_plazo = @w_plazo_asis_med and pm_producto = @w_toperacion) 
    where se_paquete = 'EXTENDIDO'
            
    if @w_paga_seguro = 'NO'
    begin
       update #ca_param_seguro_externo_1 set
       se_valor = 0,
       se_asistencia_funeraria = 0
       where se_paquete = @w_tipo_basico
    end
    
    select 
    se_id, 
    se_paquete, 
    se_edad_max,  
    se_total = convert(money,0),
    asist_funeraria = se_asistencia_funeraria,
    tiempo = case when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'D' then round(convert(float,@w_plazo)/30,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'W' then round(convert(float,@w_plazo) * 7 /30,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'BW' then round(convert(float,@w_plazo) * 14 /30,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'Q' then round(convert(float,@w_plazo) /2,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'M' then round(convert(float,@w_plazo),0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'B' then round(convert(float,@w_plazo) * 2,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'T' then round(convert(float,@w_plazo) * 3,0)
                  when se_paquete  = @w_tipo_basico and @w_tipo_plazo = 'S' then round(convert(float,@w_plazo) * 6,0)
                  when se_paquete = 'EXTENDIDO' then 1
             else 1 end,
    se_valor,
    se_mes_inicial,
    se_mes_final         
    into #valores_seguro_1
    from #ca_param_seguro_externo_1
    where se_estado = 'V'
    group by se_id, se_paquete, se_edad_max, se_asistencia_funeraria, se_valor, se_mes_inicial, se_mes_final
    
    SELECT
    @w_meses_maximo_seg = pa_int
    from cobis..cl_parametro
    where pa_nemonico = 'SEGMAX'
 
    SELECT
    @w_meses_default_seg = pa_int
    from cobis..cl_parametro
    where pa_nemonico = 'SEGDEF'
 
    UPDATE #valores_seguro_1
    SET tiempo = @w_meses_default_seg
    WHERE tiempo <= @w_meses_maximo_seg
    AND se_paquete = @w_tipo_basico

    select 
    se_id, se_paquete, se_edad_max,
    se_total = sum(tiempo * asist_funeraria) + sum(tiempo * se_valor),
    se_basico    = convert(money,0)  
    into #seguros_calculados
    from #valores_seguro_1
    where tiempo >= se_mes_inicial and tiempo <= se_mes_final
    group by se_id, se_paquete, se_edad_max
    
    select @w_valor_basico =se_total
    from #seguros_calculados
    where se_paquete = @w_tipo_basico
    
    update #seguros_calculados set 
    se_basico   =  isnull(@w_valor_basico,0)
    where se_total > 0
    
    update #seguros_calculados
    set se_total = se_total + isnull(@w_valor_basico,0)
    where se_paquete <> @w_tipo_basico
    and   se_total   > 0 
    
    update #seguros set 
    monto =se_total,
    monto_basico = se_basico
    from #seguros_calculados
    where se_paquete = tipo_seguro
    and ((anio >= 18 and  anio < se_edad_max)
    or   (anio = se_edad_max and  mes = 0 and   dia = 0 ))

    --caso#192858
    update #seguros set 
    tipo_seguro = 'NINGUNO'
    from #valores_seguro_1
    where se_paquete = tipo_seguro
    and ((anio < 18) or  (anio > se_edad_max) or (anio = se_edad_max and mes > 0) or (anio = se_edad_max and dia > 0))
    
    update #seguros set
    monto_basico = 0
    where monto = 0
    
    insert into #ca_seguro_externo_tmp (
    se_operacion_tmp   , se_banco_tmp            , se_cliente_tmp,
    se_fecha_ini_tmp   , se_fecha_ult_intento_tmp, se_monto_tmp  ,
    se_estado_tmp      , se_tramite_tmp          , se_grupo_tmp  ,
    se_monto_pagado_tmp, se_forma_pago           , se_tipo_seguro,
    se_monto_basico, se_plazo_asis_med  )
    select                                                                  
    @w_operacion_grupal, @w_banco_grupal         , cliente       ,
    @w_fecha_proceso   , @w_fecha_pro_orig       , sum(monto)    ,
    'C'                , tramite                 , grupo                     , 
    pago=sum(isnull(monto_pag,0)), case when sum(isnull(monto_pag,0)) >0 then max(forma_pago) else null end,
    tipo_seguro, monto_basico, plazo_asis_med
    from #seguros
    group by tramite, grupo, cliente, tipo_seguro, monto_basico, plazo_asis_med
    
    --Encuentro el monto de los seguros
    select @w_monto_seguro_basico=sum(isnull(se_monto_tmp,0)-isnull(se_monto_pagado_tmp,0))
    from #ca_seguro_externo_tmp
    select @w_monto_seguro_basico
    
    --Inserccion en tablas fisicas de seguro
    delete from cob_cartera..ca_seguro_externo
    where se_tramite   = @w_tramite
     
    insert into ca_seguro_externo (
    se_operacion,            se_banco,                   se_cliente,
    se_fecha_ini,            se_fecha_ult_intento,       se_monto  ,
    se_estado,               se_tramite,                 se_grupo  ,
    se_monto_pagado,         se_forma_pago,              se_tipo_seguro,
    se_monto_basico,         se_usuario,                 se_terminal,
    se_plazo_asis_med)
    select 
    se_operacion_tmp,        se_banco_tmp,               se_cliente_tmp,
    se_fecha_ini_tmp,        se_fecha_ult_intento_tmp,   case when se_monto_tmp >=0 then se_monto_tmp else 0 end ,
    se_estado_tmp,           se_tramite_tmp,             se_grupo_tmp,
    se_monto_pagado_tmp,     se_forma_pago ,             se_tipo_seguro,
    se_monto_basico,         @s_user,                    @s_term,
    se_plazo_asis_med
    from #ca_seguro_externo_tmp
    --Fin Llenado de tabla de seguros
end

--Inicio de tabla de Garantia solo No Promo   
if((@w_toperacion = 'GRUPAL' and @w_carga_valor = 'S') or (@w_toperacion = 'INDIVIDUAL'))
begin      
    if (@w_toperacion = 'GRUPAL') begin 
        insert into #garantialiq_tmp   (
        tramite,                               cliente,         monto_individual, 
        monto_garantia,                        monto_pagado,    fecha_vencimiento)
        select 
        @w_tramite,                            tg_cliente,      tg_monto, 
        (tg_monto * @w_porcentaje_monto/100),  0,               @w_fecha_pro_orig
        from cob_credito..cr_tramite_grupal
        where tg_tramite = @w_tramite
        and   tg_participa_ciclo = 'S'
	end else begin
        insert into #garantialiq_tmp   (
        tramite,                              cliente,          monto_individual, 
        monto_garantia,                       monto_pagado,     fecha_vencimiento)
        select
        @w_tramite,                           tr_cliente,       tr_monto, 
        (tr_monto * @w_porcentaje_monto/100), 0,                @w_fecha_pro_orig
        from cob_credito..cr_tramite
        where tr_tramite = @w_tramite
	end
	
    update #garantialiq_tmp set 
    monto_pagado = isnull(gl_pag_valor,0)
    from cob_cartera..ca_garantia_liquida
    where tramite = gl_tramite
    and cliente = gl_cliente
    	
	if (@w_toperacion = 'GRUPAL') begin
        insert into #garantialiq_tmp(
        tramite,          cliente,           monto_individual, 
        monto_garantia,    fecha_vencimiento, monto_pagado)
        select
        @w_tramite,        gl_cliente,        0,
        0,                 @w_fecha_pro_orig, isnull(gl_pag_valor, 0)
        from cob_cartera..ca_garantia_liquida
        where gl_tramite = @w_tramite
        and gl_cliente not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite
                                and   tg_participa_ciclo = 'S')        
	end else begin
        insert into #garantialiq_tmp(
        tramite,           cliente,              monto_individual, 
        monto_garantia,    fecha_vencimiento,    monto_pagado)
        select                                   
        @w_tramite,        gl_cliente,           0,
        0,                 @w_fecha_pro_orig,    isnull(gl_pag_valor, 0)
        from cob_cartera..ca_garantia_liquida
        where gl_tramite = @w_tramite
	end
		
    update #garantialiq_tmp set
    pag_estado = 'PC',
    dev_estado = NULL
    where monto_garantia > monto_pagado
    
    update #garantialiq_tmp set
    pag_estado = 'CB',
    dev_estado = 'PD'
    where monto_garantia < monto_pagado
    
    update #garantialiq_tmp set
    pag_estado = 'CB',
    dev_estado = NULL
    where monto_garantia = monto_pagado
        
    select @w_monto_gar_liquida = sum(isnull(monto_garantia, 0) - isnull(monto_pagado,0))
    from #garantialiq_tmp
    where pag_estado = 'PC'
    
    
    --llenado en tabla fisicas de garantia liquida
    print'Ingresa I'
    
    update cob_cartera..ca_garantia_liquida set
    gl_fecha_vencimiento = fecha_vencimiento,
    gl_monto_garantia    = monto_garantia,
    gl_monto_individual  = monto_individual,
    gl_pag_estado        = pag_estado,
    gl_dev_estado        = dev_estado
    from #garantialiq_tmp
    where gl_tramite = @w_tramite
    and gl_cliente   = cliente
        
    if (@@error != 0)
    begin
        select @w_error = 708154
        goto ERROR
    end
    print'Ingresa I1'
    /*select * from #garantialiq_tmp
    where cliente not in (select gl_cliente from cob_cartera..ca_garantia_liquida where gl_tramite = @w_tramite)
    */
    insert into ca_garantia_liquida (
    gl_grupo,            gl_cliente,        gl_tramite,
    gl_monto_individual, gl_monto_garantia, gl_fecha_vencimiento,
    gl_pag_estado)
    select 
    @w_grupo,         cliente,        @w_tramite,
    monto_individual, monto_garantia, fecha_vencimiento,
    pag_estado
    from #garantialiq_tmp
    where cliente not in (select gl_cliente from cob_cartera..ca_garantia_liquida where gl_tramite = @w_tramite)
	 	
    if (@@error != 0)
    begin
        select @w_error = 708154
        goto ERROR
    end	
end--Fin llenado de tabla de garantia Liquida
   
select @o_id_resultado = 1

return 0

ERROR:
set transaction isolation level read uncommitted
if @w_fail_tran = 'S' begin
	rollback tran
end

exec cobis..sp_cerror 
@t_from = @w_sp_name, 
@i_num = @w_error
return @w_error
go
