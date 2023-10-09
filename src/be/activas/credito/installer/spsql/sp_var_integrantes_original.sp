/************************************************************************/
/*  Archivo:                sp_var_integrantes_original.sp              */
/*  Stored procedure:       sp_var_integrantes_original                 */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 23/Abr/2018                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Determina la cantidad de integrantes que vienen de una entidad       */
/* externa                                                              */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 23/Abr/2018    P. Ortiz     Emision Inicial                          */
/* 07/Jun/2019    P. Ortiz     Cambiar fecha consulta por proceso       */
/* 05-07-2019     srojas       Reestructuración Buro histórico          */
/* 07/Jun/2019    P. Ortiz     Grupo promo #116387                      */
/* 10/Jul/2019    D. Cumbal    Cambio caso 121732                       */
/* 22/Oct/2019    ACHP         #127801 Si no es promo el grupo el       */
/*                             tg_monto_cuenta_ref debe ser null        */
/* 30/Sep/2021    ACH          ERR#168924,s toma el parametro de ingreso*/
/* 30/12/2022     SRO          Req 184910                               */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_integrantes_original')
	drop proc sp_var_integrantes_original
GO


CREATE PROC sp_var_integrantes_original
        (@s_ssn        int         = null,
         @s_ofi        smallint    = null,
         @s_user       login       = null,
         @s_date       datetime    = null,
         @s_srv        varchar(30) = null,
         @s_term       descripcion = null,
         @s_rol        smallint    = null,
         @s_lsrv       varchar(30) = null,
         @s_sesn       int         = null,
         @s_org        char(1)     = NULL,
         @s_org_err    int         = null,
         @s_error      int         = null,
         @s_sev        tinyint     = null,
         @s_msg        descripcion = null,
         @t_rty        char(1)     = null,
         @t_trn        int         = null,
         @t_debug      char(1)     = 'N',
         @t_file       varchar(14) = null,
         @t_from       varchar(30) = null,
         --variables
         @i_id_inst_proc int,    --codigo de instancia del proceso
         @i_id_inst_act  int       = null,    
         @i_id_asig_act  int       = null ,
         @i_id_empresa   int       = null, 
         @i_id_variable  smallint  = 0,
         @i_tramite      int       = 0,
         @i_grupo        int       = 0,
         @i_ttramite     varchar(10) = null,
         @i_debug        char(1)     = 'N' 
         )
as
declare 
@w_sp_name              varchar(32),
@w_tramite              int,
@w_return               int,
@w_valor_ant            varchar(255),
@w_valor_nuevo          varchar(255),
@w_actividad            catalogo,
@w_grupo                int,
@w_ente                 int,
@w_fecha                datetime,
@w_fecha_dif            datetime,
@w_ttramite             varchar(255),
@w_promocion            char(1),
@w_min_original         int,
@w_asig_act             int,
@w_numero               int,
@w_proceso              varchar(5),
@w_usuario              varchar(64),
@w_comentario           varchar(255),
@w_nombre               varchar(64) ,
@w_num_valida_monto     int,
@w_porcentaje_min       float,
@w_porcentaje_ente      float,
@w_fecha_proceso        datetime,
@w_registros            int,
@w_ciclo_grupal         int,
@w_contador             int,
@w_parametro_tiempo     int,
@w_porcentaje_plazo     float,
@w_numero_dias_def      int,
@w_max_num_cuentas      int,
@w_min_monto            money,
@w_fecha_apertura       datetime,
@w_clientes_str         varchar(200),
@w_num_dias_valida      int,
@IDs                    VARCHAR(500),
@Number                 VARCHAR(5),
@charSpliter            CHAR,
@w_tipo_contrato        varchar(30),
@w_tipo_cuenta          varchar(30),
@w_tipo_respon          varchar(30),
@w_frecuencia_pago      varchar(30),
@w_buro                 varchar(1),
@w_numero_pagos         varchar(4),
@w_valor_variable_regla varchar(255),
@w_resultado            varchar(255) = '0',
@w_numero_dias          int,
@w_valor_frec_pag       int,
@w_bc_secuencial        int = 0,
@w_error                int

select @w_sp_name='sp_var_integrantes_original'


if @i_id_inst_proc <> -1
begin
    --print 'sp_var_integrantes_original >> SI llega instancia de proceso'
    select @w_grupo    = convert(int,io_campo_1),
           @w_tramite  = convert(int,io_campo_3),
           @w_ttramite = io_campo_4,
           @w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
    from cob_workflow..wf_inst_proceso
    where io_id_inst_proc = @i_id_inst_proc
end

if @i_tramite <> 0
begin
    --print 'sp_var_integrantes_original >> obtiene datos con el tramite'
    select @w_tramite = @i_tramite
    select @w_grupo  = @i_grupo 
    select @w_ttramite = @i_ttramite
    
end

select @w_ciclo_grupal = isnull(gr_num_ciclo,0) + 1
from cobis..cl_grupo where gr_grupo = @w_grupo

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_valor_nuevo = '0'


/* PARAMETROS */
select @w_min_original = (select pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MINEO' and pa_producto = 'CRE')
select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'
select @w_porcentaje_min = pa_tinyint/100.00 from cobis..cl_parametro WHERE pa_nemonico = 'POPAGP' and pa_producto = 'CRE' --PORCENTAJE DE PAGO GRUPO PROMO
select @w_porcentaje_plazo = pa_int/100.00 from cobis..cl_parametro WHERE pa_nemonico = 'PPLTI' and pa_producto = 'CRE'--PORCENTAJE PLAZO TIEMPO
select @w_numero_dias_def = pa_int from cobis..cl_parametro WHERE pa_nemonico = 'PNUMD' and pa_producto = 'CRE'--NUMERO DIAS CALCULO PLAZO AVANCE
select @w_num_dias_valida  = pa_int from cobis..cl_parametro WHERE pa_nemonico = 'TVCAB' and pa_producto = 'CRE'--NUMERO DIAS CALCULO PLAZO AVANCE

select @w_tramite = isnull(@w_tramite,@i_tramite)

if @w_tramite = 0 and @i_tramite = 0
begin
   print 'sp_var_integrantes_original ERROR NO LLEGA TRAMITE'
return 0
end

declare @clientes_tmp as table (
    idCliente             int, 
    nombreOtorgante       varchar(16), 
    tipoCuena             varchar(1), 
    tipoResp              varchar(1), 
    tipoContrato          varchar(2), 
    fchAperturaCta        datetime,  
    frecuenciaPago        varchar(1), 
    formaPagoActual       varchar(2), 
    creditoMax            varchar(9), 
    saldoActual           varchar(9),
    porcentajePago        float     ,
    numero_dias           float     ,
    dias_avance           float     ,
    fecha_actualizacion   datetime       
)

declare @clientes as table (
    idCliente           int, 
    nombreOtorgante     varchar(16), 
    tipoCuena           varchar(1), 
    tipoResp            varchar(1), 
    tipoContrato        varchar(2), 
    fchAperturaCta      datetime,  
    frecuenciaPago      varchar(1), 
    formaPagoActual     varchar(2), 
    creditoMax          varchar(9), 
    saldoActual         varchar(9),
    porcentajePago      float,
    porcentajePlazo     float,
    fecha_actualizacion datetime  
)

declare @cuentas_tmp as table ( 
  nombreOtorgante     varchar(16), 
  tipoCuena           varchar(1),    
  tipoResp            varchar(1),    
  tipoContrato        varchar(2),
  fchAperturaCta      datetime  ,     
  frecuenciaPago      varchar(1),    
  formaPagoActual     varchar(2),   
  numero_cuentas      int       ,
  monto               money     ,
  numero_integramtes  int
)

declare @original as table (
    idCliente           int, 
    nombreOtorgante     varchar(16), 
    tipoCuena           varchar(1), 
    tipoResp            varchar(1), 
    tipoContrato        varchar(2), 
    fchAperturaCta      datetime, 
    frecuenciaPago      varchar(1), 
    formaPagoActual     varchar(2), 
    monto               money,
    cuentas             int  
)
declare @paraemtro as table (
    nemonico          char(6),
    valor             varchar(30)
)

declare @consulta_buro as table (
   bc_secuencial                      int,
   ib_cliente                         int,
   bc_nombre_otorgante                varchar(16),
   bc_tipo_cuenta                     varchar(1),
   bc_indicador_tipo_responsabilidad  varchar(1),
   bc_tipo_contrato                   varchar(2),
   bc_fecha_apertura_cuenta           varchar(8), 
   bc_frecuencia_pagos                varchar(1), 
   bc_forma_pago_actual               varchar(2), 
   bc_credito_maximo                  varchar(9), 
   bc_saldo_actual                    varchar(9), 
   bc_numero_pagos                    varchar(4),
   bc_fecha_actualizacion             varchar(8)

)

select @w_tipo_contrato = pa_char from cobis..cl_parametro where pa_nemonico = 'TCONT'
select @w_tipo_cuenta = pa_char from cobis..cl_parametro where pa_nemonico = 'TICTA'
select @w_tipo_respon = pa_char from cobis..cl_parametro where pa_nemonico = 'TRESP'
select @w_frecuencia_pago = pa_char from cobis..cl_parametro where pa_nemonico = 'FRCPG'

/* TIPO CONTRATO */
if @w_tipo_contrato is not null
begin
    select @charSpliter = ','
    select @IDs = @w_tipo_contrato + @charSpliter;
    
    while CHARINDEX(@charSpliter, @IDs) > 0
    begin
        select @Number = SUBSTRING(@IDs, 0, CHARINDEX(@charSpliter, @IDs))
        select @IDs = SUBSTRING(@IDs, CHARINDEX(@charSpliter, @IDs) + 1, LEN(@IDs))
        insert into @paraemtro
        select 'TCONT', @Number
    end
end
/* TIPO CUENTA */
if @w_tipo_cuenta is not null
begin
    select @charSpliter = ','
    select @IDs = @w_tipo_cuenta + @charSpliter;
    
    while CHARINDEX(@charSpliter, @IDs) > 0
    begin
        select @Number = SUBSTRING(@IDs, 0, CHARINDEX(@charSpliter, @IDs))
        select @IDs = SUBSTRING(@IDs, CHARINDEX(@charSpliter, @IDs) + 1, LEN(@IDs))
        insert into @paraemtro
        select 'TICTA', @Number
    end
end
/* TIPO RESPONSABILIDAD */
if @w_tipo_respon is not null
begin
    select @charSpliter = ','
    select @IDs = @w_tipo_respon + @charSpliter;
    
    while CHARINDEX(@charSpliter, @IDs) > 0
    begin
        select @Number = SUBSTRING(@IDs, 0, CHARINDEX(@charSpliter, @IDs))
        select @IDs = SUBSTRING(@IDs, CHARINDEX(@charSpliter, @IDs) + 1, LEN(@IDs))
        insert into @paraemtro
        select 'TRESP', @Number
    end
end
/* FRECUENCIA PAGO */
if @w_frecuencia_pago is not null
begin
    select @charSpliter = ','
    select @IDs = @w_frecuencia_pago + @charSpliter;
    
    while CHARINDEX(@charSpliter, @IDs) > 0
    begin
        select @Number = SUBSTRING(@IDs, 0, CHARINDEX(@charSpliter, @IDs))
        select @IDs = SUBSTRING(@IDs, CHARINDEX(@charSpliter, @IDs) + 1, LEN(@IDs))
        insert into @paraemtro
        select 'FRCPG', @Number
    end
end

/* Determinar si en grupo es promocion */
select @w_promocion = tr_promocion from cob_credito..cr_tramite where tr_tramite = @w_tramite
select @w_promocion = isnull(@w_promocion,'N')

if @w_promocion = 'N'
begin
    select @w_valor_nuevo = 8
    --ACHP se actualiza el campo tg_monto_cuenta_ref cuando es N por que este
	--campo aumenta el valor Monto Maximo Propuesto
    update cob_credito..cr_tramite_grupal
    set    tg_monto_cuenta_ref = null
    where  tg_tramite = @w_tramite
    and    tg_grupo   = @w_grupo
    
    delete cob_credito..cr_grupo_promo_inicio
    where   gpi_tramite = @w_tramite
    and     gpi_grupo   = @w_grupo
end

select @w_comentario = 'ERROR GRUPO ORIGEN: Grupo PROMO no cumple integrantes mínimos del grupo origen. Los clientes que cumplen son: '

if (@w_promocion = 'S' and @w_ciclo_grupal > 1 and @w_ttramite = 'GRUPAL')
begin 
    select @w_valor_nuevo =  count(distinct(tg_cliente)) from cob_credito..cr_tramite_grupal, cob_credito..cr_grupo_promo_inicio
    where tg_tramite = @w_tramite
    and tg_cliente = gpi_ente
    and tg_participa_ciclo = 'S'
end

if (@w_promocion = 'S' and @w_ciclo_grupal = 1 and @w_ttramite = 'GRUPAL')
begin 
   --Promo  
   
   print 'Es promo'
   delete cr_grupo_promo_inicio where gpi_grupo= @w_grupo 
   
   select @w_ente = 0
   while 1 = 1
   begin
      
         
      delete from @consulta_buro
      delete from @clientes_tmp
           
      select top 1 @w_ente = cg_ente 
      from cobis..cl_cliente_grupo, cr_tramite_grupal 
      where cg_grupo = @w_grupo
      and tg_tramite = @w_tramite
      and cg_grupo = tg_grupo
      and tg_cliente = cg_ente
      -- and tg_participa_ciclo = 'S'
      and cg_estado = 'V'
      and cg_ente > @w_ente
      order by cg_ente asc
           
      IF @@ROWCOUNT = 0 BREAK  
                    
      print '@w_ente: '+ convert(varchar,@w_ente)  		   
      insert into @consulta_buro
	  select 
	  bc_secuencial,
      ib_cliente,
      bc_nombre_otorgante,
      bc_tipo_cuenta,
      bc_indicador_tipo_responsabilidad,
      bc_tipo_contrato,
      bc_fecha_apertura_cuenta, 
      bc_frecuencia_pagos, 
      bc_forma_pago_actual, 
      bc_credito_maximo, 
      bc_saldo_actual,
      bc_numero_pagos,
      bc_fecha_actualizacion
	  from cob_credito..cr_buro_cuenta, cob_credito..cr_interface_buro 
      where bc_ib_secuencial = ib_secuencial  
      and   ib_cliente = @w_ente 
      and   ib_estado  = 'V'
      and   bc_tipo_cuenta in (select valor from @paraemtro where nemonico = 'TICTA')                         -- I  -> Pagos Fijos
      and   bc_indicador_tipo_responsabilidad in (select valor from @paraemtro where nemonico = 'TRESP')-- I  -> individual y los J-> mancomunado
      and   bc_tipo_contrato    in (select valor from @paraemtro where nemonico = 'TCONT')            -- CS -> Credito Simple y PL ->Prestamo Personal
      and   bc_frecuencia_pagos in (select valor from @paraemtro where nemonico = 'FRCPG')              -- W  -> Semanal o K -> Catorcenal
      and   ltrim(rtrim(bc_nombre_otorgante)) not in (select ltrim(rtrim(c.valor))                           
                                                      from cobis..cl_tabla t,cobis..cl_catalogo c
                                                      where t.tabla  = 'cr_tipo_negocio'
                                                      and   t.codigo = c.tabla)              
      and  (datediff(dd,(convert(datetime,SUBSTRING(bc_fecha_apertura_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,5,4),103)),ib_fecha) <=@w_num_dias_valida) 
      
             
	  if @@rowcount = 0 and @i_debug = 'S' begin
	     insert into @consulta_buro
         select 
		 bc_secuencial,
         ib_cliente,
         bc_nombre_otorgante,
         bc_tipo_cuenta,
         bc_indicador_tipo_responsabilidad,
         bc_tipo_contrato,
         bc_fecha_apertura_cuenta, 
         bc_frecuencia_pagos, 
         bc_forma_pago_actual, 
         bc_credito_maximo, 
         bc_saldo_actual,
         bc_numero_pagos,
         bc_fecha_actualizacion from  cr_buro_cuenta, cr_interface_buro 
         where bc_ib_secuencial = ib_secuencial
         and   ib_cliente       = @w_ente 
         and   ib_estado        = 'V' 
         print 'entro @@rowcount and @i_debug = S'
      end
      
      
      ---------------------------
	  
      if @i_debug = 'S' select 'Antes Regla @consulta_buro', * from @consulta_buro
      print 'Cuenta consulta buro:'+convert(varchar,@@rowcount)
      
      select @w_bc_secuencial = 0
   
      while 1 = 1 
      begin 
      
         delete @clientes_tmp
   
         select top 1 @w_bc_secuencial = bc_secuencial
	     from @consulta_buro
	     where bc_secuencial > @w_bc_secuencial
	     order by bc_secuencial
	     
	     if @@rowcount = 0 break
	 
         select 
         @w_buro = bc_frecuencia_pagos,
         @w_numero_pagos = bc_numero_pagos
	     from @consulta_buro 
         where bc_secuencial = @w_bc_secuencial

         select @w_valor_variable_regla = isnull(@w_buro, ' ') + '|' + isnull(@w_numero_pagos, 0)
	     
	     exec @w_error            = cob_cartera..sp_ejecutar_regla
         @s_ssn                   = @s_ssn,
         @s_ofi                   = @s_ofi,
         @s_user                  = @s_user,
         @s_date                  = @s_date,
         @s_srv                   = @s_srv,
         @s_term                  = @s_term,
         @s_rol                   = @s_rol,
         @s_lsrv                  = @s_lsrv,
         @s_sesn                  = @s_sesn,
         @i_regla                 = 'FREPAG', 	 
         @i_valor_variable_regla  = @w_valor_variable_regla,
	     @i_tipo_ejecucion        = 'REGLA',
         @o_resultado1            = @w_resultado out
	     
	     if @w_error <> 0 begin
            goto ERROR	  
	     end
	  
	     if @i_debug = 'S' select '@consulta_buro', * from @consulta_buro  where bc_secuencial = @w_bc_secuencial
         select @w_valor_frec_pag = case when @w_resultado is null then @w_numero_dias_def else cast(@w_resultado as int) end 
	     select @w_numero_dias = @w_numero_pagos * @w_valor_frec_pag  
	     
	     print '@w_valor_frec_pag: '+convert(varchar, @w_valor_frec_pag)
	     print '@w_numero_dias: '+convert(varchar, @w_numero_dias)
	     
         insert into @clientes_tmp
         select ib_cliente,
         isnull(bc_nombre_otorgante, '|'),
         isnull(bc_tipo_cuenta, '|'),
         isnull(bc_indicador_tipo_responsabilidad, '|'),
         isnull(bc_tipo_contrato, '|'),
         'FechaApertura' = convert(datetime,SUBSTRING(bc_fecha_apertura_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,5,4),103),
         --isnull(bc_fecha_cierre_cuenta, '|'),
         isnull(bc_frecuencia_pagos, '|'),
         isnull(bc_forma_pago_actual, '|'),
         --isnull(bc_mop_historico_morosidad_mas_grave, '|'),
         isnull(bc_credito_maximo, '|'),
         isnull(bc_saldo_actual, '|'),
         case when convert(money,replace(replace(bc_credito_maximo,'+',''),'-','')) != 0 then
              convert(money,replace(replace(bc_saldo_actual,'+',''),'-',''))  / convert(money,replace(replace(bc_credito_maximo,'+',''),'-',''))
         else
              0
         end,
         @w_numero_dias,
         datediff(dd,convert(datetime,SUBSTRING(bc_fecha_apertura_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,5,4),103), @w_fecha_proceso),
         convert(datetime,SUBSTRING(bc_fecha_actualizacion,1,2) + '/' +SUBSTRING(bc_fecha_actualizacion,3,2) + '/' + SUBSTRING(bc_fecha_actualizacion,5,4),103)                                  
         from @consulta_buro  
         where bc_secuencial = @w_bc_secuencial
         
         insert into @clientes (
                idCliente     ,     nombreOtorgante,     tipoCuena     ,
                tipoResp      ,     tipoContrato   ,    fchAperturaCta,
                frecuenciaPago,    formaPagoActual,     creditoMax      ,
                saldoActual   ,    porcentajePago ,    fecha_actualizacion, 
                porcentajePlazo)
         select idCliente       ,     nombreOtorgante,    tipoCuena      ,
                tipoResp      ,    tipoContrato   ,    fchAperturaCta,
                frecuenciaPago,    formaPagoActual,    creditoMax      ,
                saldoActual   ,    porcentajePago *100,fecha_actualizacion,    
               (dias_avance/numero_dias) * 100 
         from @clientes_tmp
         where ((porcentajePago <= @w_porcentaje_min)
         or    ((porcentajePago > @w_porcentaje_min) and ((dias_avance/numero_dias) >= @w_porcentaje_plazo)))
             
                                
         if @@rowcount = 0 and @i_debug = 'S'
         begin
            select 'No Cumplen Cond. Porcentajes'
            select idCliente       ,     nombreOtorgante,                  tipoCuena               ,
                tipoResp      ,    tipoContrato                      , fchAperturaCta     ,
                   frecuenciaPago,    formaPagoActual                   , creditoMax           ,
                saldoActual   ,    porcentajePago=porcentajePago *100, fecha_actualizacion,    
                porcentajePlazo=(dias_avance/numero_dias) * 100 
            from @clientes_tmp               
         end
   
         if @i_debug = 'S' select 'Antes Promo @clientes',* from @clientes
	 
   
     end
      ---------------------------
                        
   end
   
   
   
        
 end
 
    

if exists(select 1 from @clientes)
begin
        if @i_debug = 'S' select '@clientes',* from @clientes
        
        insert into @cuentas_tmp(
               nombreOtorgante,   tipoCuena          ,  tipoResp,
               tipoContrato   ,   fchAperturaCta     ,  frecuenciaPago,
               formaPagoActual,   numero_cuentas,
               monto          ,   numero_integramtes )                  
        select nombreOtorgante,   tipoCuena          ,  tipoResp,    
               tipoContrato   ,   fchAperturaCta     ,  frecuenciaPago,    
               max(formaPagoActual),   cont = count(1),       
               sum(convert(money,replace(replace(replace(creditoMax,'|','0'),'+',''),'-',''))), 0               
        from @clientes
        group by nombreOtorgante,     tipoCuena,    tipoResp,    tipoContrato        ,
        fchAperturaCta,    frecuenciaPago
        having count(nombreOtorgante) > 1
        order by fchAperturaCta desc ,cont desc
                
        if @i_debug = 'S' select '@cuentas_tmp',* from @cuentas_tmp
                
        select @w_max_num_cuentas =max(numero_cuentas)                             
        from @cuentas_tmp
        
        select @w_min_monto  = min(monto)                         
        from @cuentas_tmp
        where numero_cuentas = @w_max_num_cuentas
        
        
        select @w_fecha_apertura = max(fchAperturaCta)
        from @cuentas_tmp
        where numero_cuentas = @w_max_num_cuentas
        
        insert into @original
        select top 1 numero_cuentas,
        nombreOtorgante,     tipoCuena,    tipoResp,    tipoContrato,
        fchAperturaCta ,    frecuenciaPago,    formaPagoActual,
        monto          ,    numero_cuentas
        from @cuentas_tmp
        where numero_cuentas = @w_max_num_cuentas
        and   fchAperturaCta = @w_fecha_apertura
        order by monto desc
               
        --condiciones promo
        delete from cr_grupo_promo_cond where gpc_grupo = @w_grupo and gpc_tramite = @w_tramite
        insert into cr_grupo_promo_cond(
               gpc_grupo          ,  gpc_tramite          ,  gpc_fecha_proceso  ,  gpc_nombre_otorgante  ,
               gpc_tipo_cuenta    ,  gpc_tipo_resp        ,  gpc_tipo_contrato  ,  gpc_fecha_apertura_cta,
               gpc_frecuencia_pago,  gpc_forma_pago_actual,  gpc_numero         ,  gpc_monto             )
        select @w_grupo           ,  @w_tramite           ,  @w_fecha_proceso   ,  nombreOtorgante       ,
               tipoCuena          ,  tipoResp             ,  tipoContrato       ,  fchAperturaCta        ,
               frecuenciaPago     ,  formaPagoActual      ,  cuentas            ,  monto                 
        from @original
        
        --print    'SMO v2 sp_var_integrantes_original antes de insertar'    
        
        insert into cob_credito..cr_grupo_promo_inicio
           select @w_tramite, @w_grupo, c.idCliente, convert(money,replace(replace(creditoMax,'+',''),'-',''))   
        from @clientes c, @original o
        where c.nombreOtorgante = o.nombreOtorgante    
        and   c.tipoCuena       = o.tipoCuena
        and   c.tipoResp        = o.tipoResp
        and   c.tipoContrato    = o.tipoContrato
        and   c.fchAperturaCta  = o.fchAperturaCta
        and   c.frecuenciaPago  = o.frecuenciaPago
        
               
        --print    'SMO v2 insertados!!!'    
        select @w_contador = count(1) 
        from cob_credito..cr_grupo_promo_inicio, cob_credito..cr_tramite_grupal
        where gpi_grupo = @w_grupo
        and gpi_grupo   = tg_grupo
        and tg_tramite  = @w_tramite
        and tg_participa_ciclo = 'S'
        and gpi_ente    = tg_cliente
        
        select @w_valor_nuevo = @w_contador
    
        --print 'SMO integrantes promo>>> '+convert(varchar,@w_contador)
        
        if @i_debug = 'S'
        begin
             select 'Integrante Grupo No Promo'
             select *
             from cobis..cl_cliente_grupo,
                  cr_tramite_grupal
             where cg_grupo   = @w_grupo
             and   tg_grupo   = cg_grupo
             and   tg_tramite = @w_tramite
             and   cg_ente    = tg_cliente
             and   cg_ente not in (select gpi_ente from cob_credito..cr_grupo_promo_inicio where gpi_tramite = @w_tramite and gpi_grupo = @w_grupo)
             and   cg_estado  = 'V'
            
             select 'CondicionPromo'
             select * 
             from cr_grupo_promo_cond 
             where gpc_grupo = @w_grupo 
             and gpc_tramite = @w_tramite 
                          
             select 'Clientes No Cumplen Cond. Promo'
             select *
             from @clientes
             where idCliente not in (select gpi_ente from cob_credito..cr_grupo_promo_inicio where gpi_tramite = @w_tramite and gpi_grupo = @w_grupo)
            
             select 'Clientes Cond. Promo'
             select c.*
             from @clientes c, @original o
             where c.nombreOtorgante = o.nombreOtorgante    
             and   c.tipoCuena       = o.tipoCuena
             and   c.tipoResp        = o.tipoResp
             and   c.tipoContrato    = o.tipoContrato
             and   c.fchAperturaCta  = o.fchAperturaCta
             and   c.frecuenciaPago  = o.frecuenciaPago
             
             
        end   
    
        select @w_clientes_str = ''
        select @w_ente = 0
        while 1 = 1
        begin
            
            select top 1 @w_ente   =gpi_ente
            from cob_credito..cr_grupo_promo_inicio
            where gpi_grupo = @w_grupo
            and   gpi_ente  > @w_ente
            order by gpi_ente asc
            
            
            IF @@ROWCOUNT = 0
              BREAK
            
            select @w_clientes_str = @w_clientes_str + convert(varchar,@w_ente) +', '
        end
    
    set @w_comentario = @w_comentario + @w_clientes_str
    
    
    if (@i_id_inst_proc <> -1 and convert(int,@w_valor_nuevo) < @w_min_original and @i_debug = 'N') 
    begin
            --print 'INGRESA OBSERVACION ORIGINALES:' + @w_comentario
            
            delete cob_workflow..wf_observaciones 
            where ob_id_asig_act = @w_asig_act
            and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
            where ol_id_asig_act = @w_asig_act 
            and ol_texto like 'ERROR GRUPO ORIGEN:%')
            
            delete cob_workflow..wf_ob_lineas 
            where ol_id_asig_act = @w_asig_act 
            and ol_texto like 'ERROR GRUPO ORIGEN:%'
            
            set @w_comentario = substring(@w_comentario,0,len(@w_comentario)) + '.'
            
            select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
            where ob_id_asig_act = @w_asig_act
            order by ob_numero desc
            
            if (@w_numero is not null)
            begin
                select @w_numero = @w_numero + 1 --aumento en uno el maximo
            end
            else
            begin
                select @w_numero = 1
            end
            
            select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
            
            insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
            values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
            
            insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
            values (@w_asig_act, @w_numero, 1, @w_comentario)
    
    
    
    end
    
end
--else
    --select @w_valor_nuevo = 0


--print 'EVALUA INTEGRANTES GRUPO PROMO: '+ @w_valor_nuevo

--insercion en estrucuturas de variables
if @i_debug = 'S'
   return 0
 

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
begin
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
            
    if @@error > 0
    begin
       select @w_error = 2101002
       goto ERROR
    end 

end

return 0

ERROR:

exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file = @t_file, 
@t_from = @t_from,
@i_num = @w_error

return @w_error