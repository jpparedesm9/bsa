/************************************************************************/
/*  Archivo:              sp_gen_ficha_pago.sp                          */
/*  Stored procedure:     sp_gen_ficha_pago                             */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         ACH                                           */
/*  Fecha de escritura:   Noviembre 2022                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBIS'.                                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus usuarios    */
/*  sin el debido consentimiento por escrito de la Presidencia Ejecutiva*/
/*  de COBIS o su representante legal.                                  */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Este proceso es utilizado para generar informaciOn para fichas de   */
/*  pagos al momento de desembolsar                                     */
/************************************************************************/
/*                          CAMBIOS                                     */
/*     FECHA       AUTOR                    CAMBIO                      */
/*  08-11-2022     ACH     V.Inicial,basada en sp_gen_ref_cuota_vigente */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_gen_ficha_pago')
   drop proc sp_gen_ficha_pago
go

create proc sp_gen_ficha_pago
(
	@i_banco        cuenta      = null,--padre
    @i_operacion    char(1)     = null
)
as 

declare
@w_error                 int,
@w_return                int,
@w_fecha_proceso         datetime,
@w_fecha_vencimiento     datetime,
@w_banco                 cuenta,
@w_est_vigente           tinyint,
@w_est_vencida           tinyint,
@w_lon_operacion         tinyint,
@w_sp_name               varchar(30),
@w_msg                   varchar(255),
@w_param_convgar         varchar(30),
@w_institucion1          varchar(20),
@w_institucion2          varchar(20),
@w_grupo                 int, 
@w_cliente_tramite         int,
@w_fecha                 datetime, 
@w_corresponsal          varchar(20), 
@w_fecha_venci           datetime, 
@w_monto_pago            money, 
@w_referencia            varchar(40),
@w_ref_santander         varchar(40),
@w_fecha_ini             datetime,
@w_fecha_fin             datetime,
@w_ciudad_nacional       int,
@w_mensaje               varchar(150),
@w_batch                 int,
@w_formato_fecha         int,
@w_tramite               int,
@w_actividad             int, 
@w_operacion             int,
@w_nombre_grupo          varchar(64),
@w_id_corresp            varchar(10),
@w_sp_corresponsal       varchar(50),
@w_descripcion_corresp   varchar(30),
@w_fail_tran             char(1),
@w_convenio              varchar(30),
@w_funcionario           int,
@w_oficina               int,
@w_login                 login,
@w_nombre                varchar(255),
@w_correo                varchar(255),
@w_rol                   int,
@w_desc_rol              varchar(255),
@w_mail_default          varchar(30),
@w_tipo_tran             varchar(4),
@w_opcion                varchar(4),
@w_estado                char(1),
@w_send_mail             char(1),
@w_est_etapa2            tinyint, -- 12
@w_est_castigado         tinyint, -- 4
@w_toperacion            varchar(20)

select 
@w_sp_name       = 'sp_gen_ficha_pago',
@w_batch         = 7071, 
@w_formato_fecha = 111,
@w_tipo_tran     = ''

select @w_banco = @i_banco

select @w_toperacion = op_toperacion,
       @w_cliente_tramite = op_cliente
from ca_operacion where op_banco = @w_banco

if(@w_toperacion = 'GRUPAL') begin
    select @w_tipo_tran     = 'PG'
end else 
    select @w_tipo_tran     = 'PI'

print 'ingreso el numBanco: ' +  @w_banco + '--->TipoOperacion: ' + @w_toperacion + '--->SuTransaccionEs: ' + @w_tipo_tran + '--->Operacion: ' + @i_operacion
    
if (@i_operacion = 'I') begin

    declare @TablaInfoPresGroup as table (
        grupo            int, 
        cliente          int, 
        operacion        int, 
        tramite          int,
        ope_grupal       cuenta, 
        dividendo        int, 
        fecha_ven        datetime, 
        fecha_ult_pro    DATETIME,
        grp_nombre       VARCHAR(64),   
        opg_fecha_liq    DATETIME NULL, 
        opg_moneda       SMALLINT NULL, 
        opg_oficina      SMALLINT NULL, 
        opg_operacion    INT NULL, 
        oficial          int)
    
    create table #universo_reporte_grupo (
     	grupo              int,
        cliente            int,
        tramite            int,
        referencia_grupal  varchar(15),
        operacion          int,
        fecha_ult_proceso  datetime,
        oficial            int
    )

    /*DETERMINAR FECHA DE PROCESO*/
    select @w_fecha_proceso = isnull(@w_fecha_vencimiento, fp_fecha)
    from cobis..ba_fecha_proceso
      
    exec @w_error   = sp_estados_cca
    @o_est_vigente  = @w_est_vigente out,
    @o_est_vencido  = @w_est_vencida out,
    @o_est_etapa2   = @w_est_etapa2 out,
    @o_est_castigado = @w_est_castigado out
    
    
    select @w_ciudad_nacional = pa_int
    from   cobis..cl_parametro with (nolock)
    where  pa_nemonico = 'CIUN'
    and    pa_producto = 'ADM'
    
    delete from ca_gen_ficha_pago_det where gfpd_cliente_id = @w_cliente_tramite
    delete from ca_gen_ficha_pago where gfp_cliente_id = @w_cliente_tramite
    
    select 
    @w_fecha_fin = @w_fecha_proceso,
    @w_fecha_ini = @w_fecha_proceso
    
    /* EL UNIVERSO A REPORTAR SE REDUCE A SOLO LA OPERACION DEL BANCO QUE LLEGA COMO PARAMETRO */
    if(@w_toperacion = 'GRUPAL') begin
    	insert into  #universo_reporte_grupo
        select distinct
        grupo             = tg_grupo,
        cliente           = op_cliente,
        tramite           = tg_tramite,
        referencia_grupal = tg_referencia_grupal,
        operacion         = op_operacion,
        fecha_ult_proceso = op_fecha_ult_proceso,
        oficial           = op_oficial
        from cob_credito..cr_tramite_grupal, ca_operacion
        where op_cliente	= tg_cliente
        and op_operacion    = tg_operacion
        and tg_referencia_grupal  = @w_banco
        and op_estado       in (@w_est_vigente)--, @w_est_vencida, @w_est_etapa2, @w_est_castigado)--DEJARLE ESTO ESTO: w_est_vigente
		
    end else begin
        insert into  #universo_reporte_grupo
        select distinct
        grupo             = op_cliente,
        cliente           = op_cliente,
        tramite           = op_tramite,
        referencia_grupal = op_banco,
        operacion         = op_operacion,
        fecha_ult_proceso = op_fecha_ult_proceso,
        oficial           = op_oficial
        from ca_operacion
        where op_banco  = @w_banco
        and op_estado   in (@w_est_vigente)--, @w_est_vencida, @w_est_etapa2, @w_est_castigado)--DEJARLE ESTO ESTO: w_est_vigente
    	
    end
        
    /* SI NO ENCONTRAMOS NADA QUE REPORTAR, AL MENOS REPORTAMOS LO VIGENTE SIN FECHA DE VENCIMIENTO*/ 
    insert into @TablaInfoPresGroup (
        grupo,         cliente,               operacion, 
        tramite,       ope_grupal,            dividendo, 
        fecha_ven,     fecha_ult_pro,         oficial)
        select 
        grupo,         cliente,                operacion, 
        tramite,       referencia_grupal,      di_dividendo, 
        di_fecha_ven,  fecha_ult_proceso,      oficial
        from #universo_reporte_grupo, ca_dividendo (nolock)
        where operacion	 = di_operacion 
        and   di_estado	in (@w_est_vigente)--, @w_est_vencida)--DEJARLE ESTO ESTO: w_est_vigente
    
    UPDATE @TablaInfoPresGroup SET
    opg_fecha_liq = op_fecha_liq,
    opg_moneda    = op_moneda,
    opg_oficina   = op_oficina,
    opg_operacion = op_operacion,
    oficial       = op_oficial
    FROM ca_operacion
    WHERE ope_grupal = op_banco
    
    if(@w_toperacion = 'GRUPAL') begin
        UPDATE @TablaInfoPresGroup SET
        grp_nombre    = cob_conta_super.dbo.fn_formatea_ascii_ext(gr_nombre, 'AN')
        FROM cobis..cl_grupo
        WHERE grupo = gr_grupo
    
        insert into ca_gen_ficha_pago (
        gfp_cliente_id,                        gfp_fecha_proceso, gfp_nombre, 
        gfp_tramite,                           gfp_op_fecha_liq,  gfp_op_moneda, 
        gfp_op_oficina,                        gfp_di_fecha_vig,  gfp_di_dividendo, 
        gfp_di_monto,                          gfp_banco,         gfp_operacion)
        select	
        grupo,                                 @w_fecha_proceso,  grp_nombre,
        tramite,		                       opg_fecha_liq, 	  opg_moneda, 
        opg_oficina,                           max(fecha_ven),    max(dividendo), 
        sum(am_cuota + am_gracia - am_pagado), ope_grupal,        opg_operacion	
        from  @TablaInfoPresGroup,  ca_amortizacion (nolock) 
        where operacion		= am_operacion
        and   dividendo	    = am_dividendo
        group by grupo, tramite, ope_grupal, grp_nombre, opg_fecha_liq, opg_moneda, opg_oficina, opg_operacion
        order by grupo, tramite, ope_grupal, grp_nombre, opg_fecha_liq, opg_moneda, opg_oficina, opg_operacion
        
        if @@error != 0 begin
        	select @w_error = 724632
        	goto ERROR_PROCESO
        end
    end else begin

        UPDATE @TablaInfoPresGroup SET
        grp_nombre    = cob_conta_super.dbo.fn_formatea_ascii_ext(isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') + ' ' + en_nombre, 'AN')
        FROM cobis..cl_ente
        WHERE grupo = en_ente
		        
        insert into ca_gen_ficha_pago (
        gfp_cliente_id,                        gfp_fecha_proceso,         gfp_nombre, 
        gfp_tramite,                           gfp_op_fecha_liq,          gfp_op_moneda, 
        gfp_op_oficina,                        gfp_di_fecha_vig,          gfp_di_dividendo, 
        gfp_di_monto,                          gfp_banco,                 gfp_operacion)                 
        select	                                                          
        grupo,                                 @w_fecha_proceso,          grp_nombre,
        tramite,		                       opg_fecha_liq, 	          opg_moneda, 
        opg_oficina,                           max(fecha_ven),            max(dividendo), 
        sum(am_cuota + am_gracia - am_pagado), ope_grupal,                opg_operacion	
    	from @TablaInfoPresGroup, ca_amortizacion (nolock)
        where operacion        = am_operacion
		and   dividendo        = am_dividendo
        group by grupo, grp_nombre, tramite, opg_fecha_liq, opg_moneda, opg_oficina, ope_grupal, opg_operacion
        order by grupo, grp_nombre, tramite, opg_fecha_liq, opg_moneda, opg_oficina, ope_grupal, opg_operacion    
    end
    
    select @w_cliente_tramite = gfp_cliente_id,
           @w_operacion       = gfp_operacion,
           @w_monto_pago      = gfp_di_monto,
           @w_fecha_venci     = gfp_di_fecha_vig
    from ca_gen_ficha_pago
    where gfp_banco = @w_banco
    
    
    select @w_id_corresp = 0

    if(@w_toperacion = 'GRUPAL') begin
        while (1=1) begin	  
            select top 1
            @w_id_corresp          = co_id,   
            @w_corresponsal        = co_nombre,
            @w_descripcion_corresp = co_descripcion,
            @w_sp_corresponsal     = co_sp_generacion_ref,
            @w_convenio            = ctr_convenio
            from  ca_corresponsal, 
            ca_corresponsal_tipo_ref   
            where co_id                 = ctr_co_id       
            and   convert(int,co_id)    > convert(int,@w_id_corresp)
            and   co_estado             = 'A'
            and   ctr_tipo_cobis        = @w_tipo_tran      
            and   co_nombre             not in ('OBJETADO','QUEBRANTO') --Mejora 129659
            order by convert(INT,co_id) asc
        	  
        	if @@rowcount = 0 break 
        	
            exec @w_error     = @w_sp_corresponsal
            @i_tipo_tran      = @w_tipo_tran,
            @i_id_referencia  = @w_cliente_tramite ,
            @i_monto          = null,
            @i_monto_desde    = null,
            @i_monto_hasta    = null,
            @i_fecha_lim_pago = null,	  
            @o_referencia     = @w_referencia out
            
            
            if @w_error <> 0 begin
               select @w_msg = mensaje from cobis..cl_errores where numero = @w_error
        	print @w_msg + '. CLIENTE:'+ convert(VARCHAR, @w_cliente_tramite)
               continue		 
            end
           
            insert into ca_gen_ficha_pago_det (
            gfpd_cliente_id,        gfpd_fecha_proceso,   gfpd_corresponsal, gfpd_institucion,       gfpd_referencia,  gfpd_convenio, gfpd_banco, gfpd_operacion)
            values(
            @w_cliente_tramite,      @w_fecha_proceso,    @w_corresponsal,   @w_descripcion_corresp, @w_referencia,   @w_convenio,    @w_banco, @w_operacion)	  
        end
    end else begin
        while 1 = 1 begin
        
            select top 1 
            @w_id_corresp          = co_id,   
            @w_corresponsal        = co_nombre,
            @w_descripcion_corresp = co_descripcion,
            @w_sp_corresponsal     = co_sp_generacion_ref,
            @w_convenio            = ctr_convenio
            from  ca_corresponsal, 
            ca_corresponsal_tipo_ref
            where co_id                 = ctr_co_id       
            and   convert(int,co_id)    > convert(int,@w_id_corresp)
            and   co_estado             = 'A'
            and   ctr_tipo_cobis        = @w_tipo_tran      
            and   co_nombre             not in ('OBJETADO','QUEBRANTO') --Mejora 129659
            order by convert(INT,co_id) asc
    	     
    	    if @@rowcount = 0 break
    	  
            exec @w_error     = @w_sp_corresponsal
            @i_tipo_tran      = @w_tipo_tran,
            @i_id_referencia  = @w_operacion,
            @i_monto          = @w_monto_pago,
            @i_monto_desde    = null,
            @i_monto_hasta    = null,
            @i_fecha_lim_pago = @w_fecha_venci,	  
            @o_referencia     = @w_referencia out
    	 
            if @w_error <> 0 begin
               select @w_msg = mensaje from cobis..cl_errores where numero = @w_error
        	   print @w_msg + '. CLIENTE:'+ convert(VARCHAR, @w_cliente_tramite)
               continue		 
            end
           
            insert into ca_gen_ficha_pago_det (
            gfpd_cliente_id,        gfpd_fecha_proceso,   gfpd_corresponsal, gfpd_institucion,       gfpd_referencia,  gfpd_convenio, gfpd_banco, gfpd_operacion)
            values(
            @w_cliente_tramite,      @w_fecha_proceso,    @w_corresponsal,   @w_descripcion_corresp, @w_referencia,    @w_convenio,   @w_banco,   @w_operacion)		
        end		
    end
end--Fin operacion I

if (@i_operacion = 'Q') begin
    select 
        'fecha_inicio'    = gfp_op_fecha_liq, -- 1
        'nombre_cliente'  = gfp_nombre,       -- 2
        'fecha_vigencia'  = gfp_di_fecha_vig, -- 3
        'nro_pago'        = gfp_di_dividendo, -- 4
        'monto'           = gfp_di_monto,     -- 5
        'sucursal'        = of_nombre,        -- 6
        'institucion' = gfpd_institucion,     -- 7
        'referencia'  = gfpd_referencia,      -- 8
        'convenio'    = gfpd_convenio         -- 9
    from ca_gen_ficha_pago, cobis..cl_oficina, ca_gen_ficha_pago_det
    where gfp_op_oficina = of_oficina
    and gfp_cliente_id = gfpd_cliente_id
    and gfp_banco = gfpd_banco
    and gfp_operacion = gfpd_operacion
    and gfp_banco = @w_banco
    
    return 0
end -- Fin operacion Q

ERROR_PROCESO:
select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error

set transaction isolation level read uncommitted
	  
select 
@w_banco = isnull(convert(varchar,@w_cliente_tramite), ''), 
@w_msg   = isnull(@w_msg,   '')
	  
select @w_msg = @w_msg + ' cuenta: ' + @w_banco
	  
return @w_error
GO

