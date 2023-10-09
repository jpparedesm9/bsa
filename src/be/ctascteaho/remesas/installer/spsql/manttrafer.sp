/************************************************************************/
/*	Archivo: 		      manttrafer.sp                                 */
/*	Stored procedure: 	sp_mantenca_transfer        	                 */
/*	Base de datos:  	cob_remesas				                 */
/*	Producto: 		Remesas 				                      */
/*	Disenado por:  Sandra Ortiz/ Julio Navarrete V.			       */
/*	Fecha de escritura: 29-Mar-1993					            */
/************************************************************************/
/*				IMPORTANTE				                      */
/*	Este programa es parte de los paquetes bancarios propiedad de	  */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	       */
/*	"NCR CORPORATION".						                      */
/*	Su uso no autorizado queda expresamente prohibido asi como	       */
/*	cualquier alteracion o agregado hecho por alguno de sus		  */
/*	usuarios sin el debido consentimiento por escrito de la 	       */
/*	Presidencia Ejecutiva de MACOSA o su representante.		       */
/************************************************************************/
/*				PROPOSITO				                           */
/*	Este programa hace un mantenimiento de tranferencias     	       */
/************************************************************************/
/*				MODIFICACIONES				                      */
/*	FECHA		AUTOR		RAZON				            */
/*	29/Mar/1993	J Navarrete	Emision inicial			       */
/*      19/Mar/1996     D Villafuerte   Cajero Interno                  */
/*	17/Ene/2001	Erika Alvarez	Remesas Negociadas		            */
/*      25/Ene/2001     E.Pulido        Aumentar el campo ciudad a 4 dig*/
/*	16/May/2001	Erika Alvarez   Aumentar parametro de entrada       */
/*      16/Ene/2003     Gloria Rueda    Retornar codigos de error       */
/*      21/Ene/2003     J. Loyo         Aumentar el campo Oficna a 4 dig*/
/*    24/06/2016      Roxana Sanchez   Modificación                     */ 
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_mantenca_transfer')
	drop proc sp_mantenca_transfer
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO
CREATE proc sp_mantenca_transfer(
	@s_ssn                	int,
	@s_ssn_branch         	int=null,
	@s_srv                	varchar(30) 	= null,
	@s_user               	varchar(30) 	= null,
	@s_sesn               	int,
	@s_term               	varchar(10),
	@s_date               	datetime,
	@s_org		      	    char(1),
	@s_ofi                	smallint,    	/* Localidad origen transaccion */
	@s_rol                	smallint 	= 1,
	@s_org_err            	char(1) 	= null, /* Origen de error:[A], [S] */
	@s_error              	int 		= null,
	@s_sev                	tinyint 	= null,
	@s_msg                	mensaje 	= null,
	@t_debug              	char(1)	 	= 'N',
	@t_file               	varchar(14) = null,
	@t_from               	varchar(32) = null,
	@t_rty                	char(1) 	= 'N',
	@t_trn		      	    smallint,
	@i_tipo_transfer      	catalogo	= null,
	@i_producto_dst       	varchar(3),
	@i_cta_banco_dst      	cuenta		= null,
	@i_nombre_dst         	varchar(64)	= '',
	@i_operacion		    char(1),
	@i_comision           	char(1)		= 'N',
	@i_base_comision	    char(1)		= 'M',
	@i_tasa           	    float		= 0.0,
	@i_monto		        money		= 0.00,
	@i_monto_total		    money		= 0.00,
	@i_periodicidad		    char(1)		= 'D',
	@i_dia_1		        tinyint		= 0,
	@i_dia_2		        tinyint		= 0,
	@i_turno		        smallint 	= null,
	@i_formato_fecha      	int		    = 101,
	@i_fecha_desde		    datetime	= null,
	@i_fecha_hasta		    datetime	= null,
	@i_estado		        char(1)		= 'N',  --PCOELLO CAMBIA EL DEFAULT DE ESTE DATO YA QUE NO PERMITE NULL LA TABLA
    @i_codigo               int         = null,     /*  ROL 12202006  */
    @i_modificable          varchar(1)  = null
)
as
declare @w_return		    int,
	@w_sp_name	    	    varchar(30),
	@w_estado    		    char(1),
	@w_moneda_dst 		    tinyint,
	@w_tipocta_super	    char(1),
	@w_monto_minimo 	    money,
	@w_monto_maximo 	    money,
	@w_porcent_minimo	    float,
	@w_porcent_maximo 	    float,
	@w_mensaje		        varchar(255),
    @w_ciudad_matriz        int,
    @w_mes_sig          	datetime,     /* ROL 12262006 */
    @w_mes_sigc         	varchar(10),  /* ROL 12262006 */
    @w_dia_pri          	varchar(10),  /* ROL 12262006 */
    @w_dia                  tinyint ,      /* ROL 12262006 */ 
    @w_ult_dia_mes      	datetime,
    @w_fecha_lab          	varchar(10), 
    @w_modificable          varchar(1),
    @w_usuario_crea         varchar(30),
    @w_codigo_pais          char(2)
/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_mantenca_transfer'
select @w_codigo_pais = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico = 'ABPAIS' 
   and pa_producto = 'ADM'
   
if @w_codigo_pais = 'CO'
   select @i_estado = 'C'
   
select @s_ssn_branch = isnull(@s_ssn_branch,@s_ssn)
/***********************************************************************/
/* 2756        BUSQUEDA DE DEFINICION TRANSFERENCIAS AUTOMATICAS       */             
/* 2757        INGRESO DE DEFINICION TRANSFERENCIAS AUTOMATICAS        */        
/* 2758        ACTUALIZACION DE DEFINICION TRANSFERENCIAS AUTOMATICAS  */         
/* 2759        ELIMINACION DE DEFINICION TRANSFERENCIAS AUTOMATICAS    */
/***********************************************************************/
if  @t_trn not in (711, 714, 715, 716, 712)
begin
   -- Error en codigo de transaccion 
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201048
   return 1
end  
if @i_turno = null
    select @i_turno = @s_rol
if @i_operacion = 'Q'   -- Query
   begin
   if @i_codigo is  null
      begin
       select @i_cta_banco_dst = ta_cuenta_dst
       from cob_remesas..re_enca_transfer_automatica a
      where ta_codigo       = isnull(@i_codigo,ta_codigo)
        and ta_tipo 	    = @i_tipo_transfer
        and ta_cuenta_dst   = @i_cta_banco_dst
        and ta_producto_dst = @i_producto_dst
        and ta_oficina      = @s_ofi
      if @@rowcount > 1
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351096
        return 1
       end
      select	'TIPO'               = ta_tipo,
            	'DESCRIPCION'        = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 're_tipo_transfer')
                                          and codigo = a.ta_tipo),
            	'APLI.COMISION'      = ta_comision,
		'BASE COMISION'	     = isnull(ta_base_comision,'M'),
                'PORCENTAJE'         = ta_tasa, --cuando la base es porcentaje
		'MONTO'		     = isnull(ta_monto,0),
		'TOTAL A DEBITAR'    = isnull(ta_monto_total,0),
		'PERIODICIDAD'	     = ta_periodicidad,
		'DESC. PERIOD'	     = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 'cc_period_transfer')
                                          and codigo = a.ta_periodicidad),
		'DIA 1'		     = ta_dia_1,
		'DIA 2'		     = ta_dia_2,
		'FECHA DESDE'	     = convert(varchar(10),ta_fecha_desde,@i_formato_fecha),
		'FECHA HASTA'	     = convert(varchar(10),ta_fecha_hasta,@i_formato_fecha),
                'CODIGO'             = ta_codigo,          /* ROL 12202006  */
                'Cuenta'             = ta_cuenta_dst,      /* ROL 12202006  */
                'Producto'           = ta_producto_dst,     /* ROL 12202006 17 */
                'MODIFICABLE'        = isnull(ta_modificable,"S")
       from	cob_remesas..re_enca_transfer_automatica a
      where ta_codigo       = isnull(@i_codigo,ta_codigo)
        and ta_tipo 	    = @i_tipo_transfer
        and ta_cuenta_dst   = @i_cta_banco_dst
        and ta_producto_dst = @i_producto_dst
        and ta_oficina      = @s_ofi
    if @@rowcount = 0
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351049
        return 1
       end
    if @@rowcount > 1
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351096
        return 1
       end
    end
  else
    begin
      select	'TIPO'               = ta_tipo,
            	'DESCRIPCION'        = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 're_tipo_transfer')
                                          and codigo = a.ta_tipo),
            	'APLI.COMISION'      = ta_comision,
		'BASE COMISION'	     = isnull(ta_base_comision,'M'),
                'PORCENTAJE'         = ta_tasa, --cuando la base es porcentaje
		'MONTO'		     = isnull(ta_monto,0),
		'TOTAL A DEBITAR'    = isnull(ta_monto_total,0),
		'PERIODICIDAD'	     = ta_periodicidad,
		'DESC. PERIOD'	     = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 'cc_period_transfer')
                                          and codigo = a.ta_periodicidad),
		'DIA 1'		     = ta_dia_1,
		'DIA 2'		     = ta_dia_2,
		'FECHA DESDE'	     = convert(varchar(10),ta_fecha_desde,@i_formato_fecha),
		'FECHA HASTA'	     = convert(varchar(10),ta_fecha_hasta,@i_formato_fecha),
                'CODIGO'             = ta_codigo,          /* ROL 12202006  */
                'Cuenta'             = ta_cuenta_dst,      /* ROL 12202006  */
                'Producto'           = ta_producto_dst,     /* ROL 12202006 17 */
                'MODIFICABLE'        = isnull(ta_modificable,"S")
       from	cob_remesas..re_enca_transfer_automatica a
      where ta_codigo       = @i_codigo
        and ta_oficina      = @s_ofi
    if @@rowcount = 0
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351049
        return 1
       end
    end
  end  /*  Fin de @i_operacion = 'Q'  */
if @i_operacion = 'I'
begin
   /* validaciones de vigencia de cuenta */
   /* Cuenta Debito  */
   if @i_producto_dst = 'CTE'
   	  exec cob_interfase..sp_icte_select_cc_ctacte
	  @i_cuenta = @i_cta_banco_dst,
	  @o_estado = @w_estado out,
	  @o_moneda = @w_moneda_dst out,
	  @@o_tipocta_super = @w_tipocta_super out
			
   else
      select @w_estado = ah_estado,
             @w_moneda_dst = ah_moneda,
             @w_tipocta_super = ah_tipocta_super
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cta_banco_dst
   if @w_estado <> 'A'
   begin
	  exec cobis..sp_cerror
	     @t_debug	= @t_debug,
	     @t_file	= @t_file,
	     @t_from	= @w_sp_name,
	     @i_num     = 201088
	  return 1
   end
  
   /*  Verifica que no exista un registro anterior */
   if exists(select ta_tipo 
             from cob_remesas..re_enca_transfer_automatica 
             where ta_tipo       = @i_tipo_transfer
             and   ta_cuenta_dst = @i_cta_banco_dst)
   begin
	  exec cobis..sp_cerror
	     @t_debug	= @t_debug,
	     @t_file	= @t_file,
	     @t_from	= @w_sp_name,
	     @i_num 	= 351097
	  return 1
   end
   /* Verificamos que el monto maximo y el minimo de la transferencia este en el rango permitido */
   if @i_comision = 'S'
   begin
	  if @i_base_comision = 'M' /* Comision en Base a Monto */
	  begin
		 select @w_monto_minimo = pa_money
     	 from cobis..cl_parametro
    	 where pa_producto = 'REM'
         and   pa_nemonico = 'MICT'
		if @@rowcount <> 1
		begin
		   /* Parametro de Monto Minimo No Encontrado */
    	   exec cobis..sp_cerror
	 	       @i_num       = 201196,
	 	       @i_msg       = 'PARAMETRO DE MONTO MINIMO NO ENCONTRADO'
           
    	   return 201196
		   end
		select @w_monto_maximo = pa_money
     	from  cobis..cl_parametro
    	where pa_producto = 'REM'
      	and   pa_nemonico = 'MACT'
		if @@rowcount <> 1
		begin
		   /* Parametro de Monto Maximo No Encontrado */
    	   exec cobis..sp_cerror
	 		     @i_num       = 201196,
	 		     @i_msg       = 'PARAMETRO DE MONTO MAXIMO NO ENCONTRADO'
    	   return 201196
		end
	
		if @i_monto not between @w_monto_minimo and @w_monto_maximo
		begin
		
			select @w_mensaje = 'EL MONTO DEBE ESTAR ENTRE ' + ltrim(rtrim(convert(varchar(250),@w_monto_minimo))) + ' Y ' +  ltrim(rtrim(convert(varchar(250),@w_monto_maximo)))
    			exec cobis..sp_cerror
	 		     @i_num       = 351551,
	 		     @i_msg       = @w_mensaje
    	    return 351551
        end
    end
	if @i_base_comision = 'P' /*Comision en Base a Porcentaje */
	begin
		select @w_porcent_minimo = pa_float
     	  	  from cobis..cl_parametro
    	 	 where pa_producto = 'REM'
      	   	  and pa_nemonico = 'PMIT'
		if @@rowcount <> 1
	    begin
		   	/* Parametro de Porcentaje Minimo No Encontrado */
    			exec cobis..sp_cerror
	 		     @i_num       = 201196,
	 		     @i_msg       = 'PARAMETRO DE PORCENTAJE MINIMO NO ENCONTRADO'
    			return 201196
		end
   		select @w_porcent_maximo = pa_float
     	from   cobis..cl_parametro
    	where  pa_producto = 'REM'
      	and    pa_nemonico = 'PMAT'
		if @@rowcount <> 1
		   begin
		   	/* Parametro de Porcentaje Maximo No Encontrado */
    			exec cobis..sp_cerror
	 		     @i_num       = 201196,
	 		     @i_msg       = 'PARAMETRO DE PORCENTAJE MAXIMO NO ENCONTRADO'
    			return 201196
		    end
		if @i_tasa not between @w_porcent_minimo and @w_porcent_maximo
		   begin
			select @w_mensaje = 'EL PORCENTAJE DEBE ESTAR ENTRE ' + ltrim(rtrim(convert(varchar(250),@w_porcent_minimo))) + ' Y ' +  ltrim(rtrim(convert(varchar(250),@w_porcent_maximo)))
    			exec cobis..sp_cerror
	 		     @i_num       = 351551,
	 		     @i_msg       = @w_mensaje
    			return 351551
		   end
	    end
      end
 
    begin tran
     /* ROL 12202006 Busqueda de secuencial  */
      exec @w_return = cobis..sp_cseqnos
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_tabla = 're_enca_transfer_automatica',
           @o_siguiente = @i_codigo out
      if @w_return != 0
         begin
          rollback tran
          return @w_return
         end 
                        
     insert into cob_remesas..re_enca_transfer_automatica 
     values (@i_tipo_transfer, @i_cta_banco_dst,  @i_producto_dst, 
	     @i_nombre_dst, @i_comision, @i_tasa, @i_base_comision,
	     @i_monto, @i_monto_total, @i_periodicidad, @i_dia_1, @i_dia_2,
	     @i_fecha_desde, @i_fecha_hasta, @i_estado,@i_codigo,@s_user,
             null,@i_modificable,@s_ofi) /* ROL 12202006 SE AGREGO @i_codigo  */
     if @@error != 0
     begin
        -- Error en creacion de registro de encabezado de transferencia
        exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 203071
        return 203071
    end
    -- Insercion de transaccion de servicio
    insert into  cob_interfase..cc_tstran_servicio
           (ts_secuencial,   ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,  ts_usuario, 
           ts_terminal,      ts_reentry,    ts_oficina,          ts_origen,   ts_servicio,
	       ts_cta_banco,     ts_nombre,     ts_moneda,           ts_estado,   ts_oficina_cta,
	       ts_tasa,          ts_vale,       ts_carta)
    values (@s_ssn,          @s_ssn_branch, @t_trn,              @s_date,     @s_user, 
           @s_term,          @t_rty,        @s_ofi,              @s_org,      @i_producto_dst,
	       @i_cta_banco_dst, @i_nombre_dst, @w_moneda_dst,       null,        null,
	       @i_tasa,          @i_comision,   @i_codigo)  /* ROL 12202006 SE AGREGO @i_codigo  */
   if @@error != 0
    begin
     -- Error en creacion de transaccion de servicio
     exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 203005
     return 203005
    end
    select @i_codigo
    commit tran
    return 0
end
if @i_operacion = 'U'    -- Update
begin
    /* ROL 01112007 valido que pueda ser actualizado por el mismo usuario */   
     select @w_usuario_crea = ta_usuario_crea,
            @w_modificable  = ta_modificable
       from  cob_remesas..re_enca_transfer_automatica 
             where  ta_codigo      = @i_codigo
               and  ta_tipo        = @i_tipo_transfer
               and  ta_cuenta_dst  = @i_cta_banco_dst
    if @w_modificable = "N"
       begin /* Solo Puede ser Modificado por el usuario que lo Creo */
          if @w_usuario_crea <> @s_user
             begin
               exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 351097
               return 351097
             end 
       end
  begin tran
   -- Verifica que el registro exista
  if exists(select ta_tipo 
              from  cob_remesas..re_enca_transfer_automatica 
             where  ta_codigo = @i_codigo
               and  ta_tipo = @i_tipo_transfer
               and  ta_cuenta_dst = @i_cta_banco_dst)
    begin
            
    
      update cob_remesas..re_enca_transfer_automatica 
        set 
           ta_nombre_dst	= @i_nombre_dst,
           ta_comision		= @i_comision,
           ta_tasa         	= @i_tasa,
	       ta_base_comision	= @i_base_comision,
	       ta_monto		    = @i_monto,
	       ta_monto_total	= @i_monto_total,
	       ta_periodicidad	= @i_periodicidad,
	       ta_dia_1		    = @i_dia_1,
	       ta_dia_2		    = @i_dia_2,
	       ta_fecha_desde	= @i_fecha_desde,
	       ta_fecha_hasta	= @i_fecha_hasta,	
           ta_estado        = @i_estado,     /* Si hay un Cambio, se deja en I para autorizar */
           ta_modificable   = @i_modificable,
           ta_usuario_crea  = @s_user
      where ta_codigo       = @i_codigo
      and   ta_tipo         = @i_tipo_transfer
      and   ta_cuenta_dst = @i_cta_banco_dst
     if @@error != 0
     begin
        -- Error en actualizaci=n de registro de encabezado de transferencia
        exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 207030
        return 207030
     end
    -- Insercion de transaccion de servicio
    insert into  cob_interfase..cc_tstran_servicio
           (ts_secuencial,   ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,   ts_usuario, 
           ts_terminal,      ts_reentry,    ts_oficina,          ts_origen,    ts_servicio,
	       ts_cta_banco,     ts_nombre,     ts_moneda,           ts_estado,    ts_oficina_cta,
	       ts_tasa,          ts_vale,       ts_carta)
    values (@s_ssn,          @s_ssn_branch, @t_trn,              @s_date,	   @s_user, 
           @s_term,          @t_rty,        @s_ofi,              @s_org,       @i_producto_dst,
	       @i_cta_banco_dst, @i_nombre_dst, @w_moneda_dst,       null,         null,
	       @i_tasa,          @i_comision,   @i_codigo)
   if @@error != 0
    begin
     -- Error en creacion de transaccion de servicio
     exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 203005
     return 203005
    end
    select @w_dia = 0
    if @i_periodicidad = 'D' 	-- Diaria
       begin
  	select @w_dia = datepart(dd,@i_fecha_desde)
        if datepart(dd,@i_fecha_desde) > @w_dia
       	   begin
             select  @w_mes_sig = dateadd(mm,1,@i_fecha_desde)
             select  @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)
          		
	     if @w_dia < 10
               	select  @w_dia_pri  = 	substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@w_dia) +
                             		substring(@w_mes_sigc,6,5)
             else
                select  @w_dia_pri  = 	substring(@w_mes_sigc,1,3) + convert(varchar(2),@w_dia) +
                             		substring(@w_mes_sigc,6,5)
           	select  @w_ult_dia_mes = @w_dia_pri
            end
       	else
 	    begin
              select  @w_mes_sigc = convert(varchar(10),@i_fecha_desde,101)
              if @w_dia < 10
                 select  @w_dia_pri  =	substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@w_dia) +
                                        substring(@w_mes_sigc,6,5)
              else
                 select  @w_dia_pri  = 	substring(@w_mes_sigc,1,3) + convert(varchar(2),@w_dia) +
                                        substring(@w_mes_sigc,6,5)
                 select  @w_ult_dia_mes = @w_dia_pri
       	    end 
		--select @w_ult_dia_mes = dateadd(dd, 1, @i_fecha_desde)
       end /*   FIN    if @i_periodicidad = 'D' 	-- Diaria */
     update cob_remesas..re_transfer_automatica 
        set ta_fecha_desde = @i_fecha_desde,
            ta_fecha_hasta = @i_fecha_hasta,
            ta_periodicidad = @i_periodicidad,
            ta_dia          = @w_dia
        where ta_codigo     = @i_codigo    /*  ROL 12202006 */ 
        and ta_tipo         = @i_tipo_transfer
     if @@error != 0
     begin
        -- Error en actualizaci=n de registro de transferencia
        exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 207030
        return 203066
     end    
   end
  else
   begin
	exec cobis..sp_cerror
	     @t_debug = @t_debug,
	     @t_file  = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 201275
	  return 1
      end
  commit tran
  return 0
end
if @i_operacion = 'D'    -- Delete
begin
  begin tran
   -- Verifica que el registro exista
  if exists(select ta_tipo 
              from cob_remesas..re_enca_transfer_automatica 
              where ta_codigo = @i_codigo
                and ta_tipo = @i_tipo_transfer
                and ta_cuenta_dst = @i_cta_banco_dst)
  begin
     --  Verifica que no haya detalle vigente
     if exists(select ta_tipo 
              from cob_remesas..re_transfer_automatica 
              where ta_codigo = @i_codigo 
                and ta_tipo = @i_tipo_transfer
                and ta_cuenta_dst = @i_cta_banco_dst)
     begin
        exec cobis..sp_cerror
          @i_num       = 201276,
          @i_msg       = 'EXISTEN CUENTAS ASOCIADAS A ESTE CONTRATO. VER DETALLE.'
        return 201276
     end
     delete cob_remesas..re_enca_transfer_automatica 
      where ta_codigo = @i_codigo
        and ta_tipo = @i_tipo_transfer
        and ta_cuenta_dst = @i_cta_banco_dst
     if @@error != 0
     begin
        -- Error en eliminacion de registro de transferencia
        exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 207030
        return 207030
     end
    -- Insercion de transaccion de servicio
    insert into  cob_interfase..cc_tstran_servicio
           (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
	       ts_usuario, ts_terminal, ts_reentry, ts_oficina, ts_origen, ts_servicio,
	       ts_cta_banco, ts_nombre, ts_moneda, ts_estado, ts_oficina_cta,
	       ts_tasa, ts_vale,
	       --ts_tipocta_super, ts_turno,
	       ts_carta)
    values (@s_ssn, @s_ssn_branch, @t_trn, @s_date,
	       @s_user, @s_term, @t_rty, @s_ofi, @s_org, @i_producto_dst,
	       @i_cta_banco_dst, @i_nombre_dst, @w_moneda_dst, null, null,
	       @i_tasa,@i_comision,
	       --@w_tipocta_super, @i_turno,
	       @i_codigo)
   if @@error != 0
    begin
     -- Error en creacion de transaccion de servicio
     exec cobis..sp_cerror
          @t_debug	 = @t_debug,
          @t_file	 = @t_file,
          @t_from	 = @w_sp_name,
          @i_num	 = 203005
     return 203005
    end
  end
  else
	  begin
	  	exec cobis..sp_cerror
		  	@t_debug = @t_debug,
		  	@t_file	 = @t_file,
		  	@t_from	 = @w_sp_name,
		  	@i_num	 = 201275
	  	return 1
      end
  commit tran
  return 0
end
if @i_operacion = 'S'   -- Query
   begin
        /* Encontrar el codigo de la ciudad de feriados nacionales */
       select @w_ciudad_matriz = pa_int
         from cobis..cl_parametro
        where pa_producto = 'CTE'
          and pa_nemonico = 'CMA'
       if @@rowcount <> 1
       begin
          exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201196
          return 1
       end
       
        /* Encontrar el pr¾xima fecha laborable */
       select @w_fecha_lab = convert(varchar(10),min(dl_fecha),103)
         from cob_ahorros..ah_dias_laborables
        where dl_ciudad =  @w_ciudad_matriz
          and dl_num_dias = 1
       if @w_fecha_lab is null -- @@rowcount = 0  
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 201249
        return 1
       end
       select @w_fecha_lab
  end
if @i_operacion = 'T'   -- Transacciones Automaticos ROL 12212006
   begin
      set rowcount 20
      select	'CODIGO'             = ta_codigo,  
                'TIPO'               = ta_tipo,
            	'DESCRIPCION'        = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 're_tipo_transfer')
                                          and codigo = a.ta_tipo),
            	'APLI.COMISION'      = ta_comision,
		'BASE COMISION'	     = isnull(ta_base_comision,'M'),
                'PORCENTAJE'         = ta_tasa, --cuando la base es porcentaje
		'MONTO'		     = isnull(ta_monto,0),
		'TOTAL A DEBITAR'    = isnull(ta_monto_total,0),
		'PERIODICIDAD'	     = ta_periodicidad,
		'DESC. PERIOD'	     = (select valor 
                                     	  from cobis..cl_catalogo
                                         where tabla = (select codigo 
                                                         from cobis..cl_tabla 
                                                     where tabla = 'cc_period_transfer')
                                          and codigo = a.ta_periodicidad),
		'DIA 1'		     = ta_dia_1,
		'DIA 2'		     = ta_dia_2,
		'FECHA DESDE'	     = convert(varchar(10),ta_fecha_desde,@i_formato_fecha),
		'FECHA HASTA'	     = convert(varchar(10),ta_fecha_hasta,@i_formato_fecha),
                'Cuenta'             = ta_cuenta_dst, 
                'Producto'           = ta_producto_dst
       from	cob_remesas..re_enca_transfer_automatica a
      where ta_codigo > isnull(@i_codigo,0)
        and ta_tipo   > ""
        and ta_cuenta_dst = isnull(@i_cta_banco_dst,ta_cuenta_dst)
        and ta_estado     = isnull(@i_estado,ta_estado)
        and ta_producto_dst = @i_producto_dst
        and ta_oficina      = @s_ofi  
      order by ta_codigo,ta_tipo
       if @@rowcount = 0
       begin
        exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 141030
        return 1
       end
   end
if @i_operacion = 'A'   -- Transacciones Automaticos ROL 12212006
   begin
        select	@s_user		= fu_login
	  from	cobis..cl_funcionario, cob_remesas..re_funcionario_autoriz
	 where  fu_login       = @s_user
	   and  fa_autorizante = fu_funcionario
           and  fa_tipo        = 'S'
	
	if @@rowcount = 0
           begin
		exec cobis..sp_cerror
          	@t_debug        = @t_debug,
          	@t_file         = @t_file,
          	@t_from         = @w_sp_name,
          	@i_num          = 201329
     		return 201329		
	   end
        select @w_estado       = ta_estado,
               @w_usuario_crea = ta_usuario_crea,
               @w_modificable  = ta_modificable
              from cob_remesas..re_enca_transfer_automatica 
              where ta_codigo = @i_codigo
        if @@rowcount = 0
           begin
            exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351049
       return 1
           end
        if @w_usuario_crea not in (select fu_login  from cobis..cl_funcionario
                          	where fu_funcionario in (select fa_ejecutor 
                                                         from cobis..cl_funcionario, 
                                                              cob_remesas..re_funcionario_autoriz
				                          where fu_funcionario = fa_autorizante
				                            and fa_tipo = 'D'
				                            and fu_login = @s_user
                                                         )
                                   )
           begin
		exec cobis..sp_cerror
          	@t_debug        = @t_debug,
          	@t_file         = @t_file,
          	@t_from         = @w_sp_name,
          	@i_num          = 201329
     		return 201329		
	   end
         if @w_estado <> "I"
            begin
             exec  cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @t_from,
              @i_num          = 351049,
              @i_msg          = "La Transferencia ya esta Autorizado o no esta Cuadrado",
              @i_sev          = 0
              return 1
            end
       begin tran
            update cob_remesas..re_enca_transfer_automatica 
             set ta_estado = "C",
                 ta_usuario_apro = @s_user
            from cob_remesas..re_enca_transfer_automatica 
            where ta_codigo = @i_codigo
            if @@error != 0
               begin
                -- Error en actualizaci=n de registro de encabezado de transferencia
                exec cobis..sp_cerror
                 @t_debug	 = @t_debug,
                 @t_file	 = @t_file,
                 @t_from	 = @w_sp_name,
                 @i_num	 = 207030
                 return 207030
               end
               -- Insercion de transaccion de servicio
           insert into  cob_interfase..cc_tstran_servicio
                 (ts_secuencial,    ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,    
                  ts_terminal,      ts_reentry,    ts_oficina,          ts_origen,  ts_servicio,
	              ts_cta_banco,     ts_nombre,     ts_moneda,           ts_estado,  ts_oficina_cta,
	              ts_tasa,          ts_vale,       ts_carta,            ts_autorizante)
           values(@s_ssn,           @s_ssn_branch, @t_trn,              @s_date,     @s_user, 
                  @s_term,          @t_rty,        @s_ofi,              @s_org,      @i_producto_dst,
	              @i_cta_banco_dst, @i_nombre_dst, @w_moneda_dst,       null,        null,
	              @i_tasa,          @i_comision,   @i_codigo,@s_user)
           if @@error != 0
              begin
               -- Error en creacion de transaccion de servicio
               exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 203005
              return 203005
             end
       
      commit tran
      return 0    
       
   end
return 0