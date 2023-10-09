/************************************************************************/ 
/*  Archivo:            inspecci.sp                                     */ 
/*  Stored procedure:   sp_inspeccion                                     */ 
/*  Base de datos:      cob_custodia                                    */ 
/*  Producto:           Custodia                                        */ 
/*  Disenado por:                                                       */ 
/*  Fecha de escritura:                                                 */ 
/************************************************************************/ 
/*                          IMPORTANTE                                  */ 
/*  Este programa es parte de los paquetes bancarios propiedad de       */ 
/*  'MACOSA'.                                                           */ 
/*  Su uso no autorizado queda expresamente prohibido asi como          */ 
/*  cualquier alteracion o agregado hecho por alguno de sus             */ 
/*  usuarios sin el debido consentimiento por escrito de la             */ 
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */ 
/************************************************************************/ 
/*                         PROPOSITO                                    */ 
/*  Procedimiento que genera el secuenciales para transacciones de      */ 
/*      servicio tomando como parametro la garantia.                    */ 
/************************************************************************/ 
/*                         MODIFICACIONES                               */ 
/*  FECHA       AUTOR       RAZON                                       */ 
/************************************************************************/ 
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_inspeccion')
    drop proc sp_inspeccion
go
create proc sp_inspeccion (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_fecha_insp         datetime  = null,
   @i_inspector          int  = null,
   @i_estado             catalogo  = null,
   @i_factura            varchar( 20)  = null,
   @i_valor_fact         money  = 0,
   @i_observaciones      varchar(255)  = null,
   @i_cuenta_cliente     cuenta  = null,
   @i_tipo_cta_cli       char(3) = null,
   @i_instruccion        varchar(255)  = null,
   @i_motivo             catalogo  = null,
   @i_valor_avaluo       money  = null,
   @i_estado_tramite     char(1) = null,
   @i_periodicidad       catalogo = null,
   @i_tipo_cust1         descripcion = null,
   @i_custodia1          int = null,
   @i_custodia2          int = null,
   @i_custodia3          int = null,
   @i_fecha_insp1        datetime = null,
   @i_fecha_insp2        datetime = null,
   @i_fecha_insp3        datetime = null,
   @i_oficial1           smallint = null,
   @i_oficial2           smallint = null,
   @i_formato_fecha	 int = null,
   @i_todas              char(1) = null,
   @i_cliente            int = null,
   @i_lote               tinyint = null,
   @i_fecha_reporte      datetime = null,
   @i_fecha_carta        datetime = null,
   @i_usuario            login = null,
   @i_evaluacion         catalogo  = null, --jvc
   @i_registro           char(1) =  null

   
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo_cust          descripcion,
   @w_custodia           int,
   @w_secservicio        int,
   @w_fecha_insp         datetime,
   @w_inspector          int,
   @w_estado             catalogo,
   @w_factura            varchar( 20),
   @w_tran               catalogo,
   @w_valor_fact         money,
   @w_observaciones      varchar(255),
   @w_instruccion        varchar(255),
   @w_motivo             catalogo,
   @w_valor_avaluo       money,
   @w_estado_tramite	 char(1),
   @w_error 		 int,
   @w_periodicidad       catalogo,
   @w_des_periodicidad   descripcion,
   @w_des_est_inspeccion descripcion,
   @w_des_cliente        varchar(255),
   @w_des_inspector      descripcion,
   @w_des_tipo 		 descripcion,
   @w_valor_actual       money,
   @w_valor_total        money,
   @w_debcred            char(1),
   @w_descripcion        descripcion,
   @w_valor_tran         money,
   @w_num_inspeccion     tinyint,
   @w_ultima_fecha       datetime,
   @w_fecha_carta        datetime,
   @w_fecha_asig         datetime, 
   @w_return		 int,
   @w_nombre_cliente     varchar(64),
   @w_codigo_externo     varchar(64),
   @w_nro_clientes       tinyint,
   @w_valor_intervalo    smallint,
   @w_valor_intervalo1   smallint,
   @w_estado_garantia    char(1),
   @w_valor_anterior     money,
   @w_valor              money,
   @w_fenvio_carta       datetime,
   @w_frecep_reporte     datetime,
   @w_ultimo             tinyint,
   @w_secuencial         int    ,    
   @w_evaluacion         catalogo  , 
   @w_registro           char(1) ,
   @w_des_evalua         descripcion


select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_inspeccion'

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
   select 
   @w_filial         = in_filial,
   @w_sucursal       = in_sucursal,
   @w_tipo_cust      = in_tipo_cust,
   @w_custodia       = in_custodia,
   @w_fecha_insp     = in_fecha_insp,
   @w_inspector      = in_inspector,
   @w_estado         = in_estado,
   @w_factura        = in_factura,
   @w_valor_fact     = in_valor_fact,
   @w_observaciones  = in_observaciones,
   @w_instruccion    = in_instruccion,
   @w_motivo         = in_motivo,
   @w_valor_avaluo   = in_valor_avaluo,
   @w_estado_tramite = in_estado_tramite,
   @w_codigo_externo = in_codigo_externo
   from cob_custodia..cu_inspeccion
   where 
   in_filial     = @i_filial and
   in_sucursal   = @i_sucursal and
   in_tipo_cust  = @i_tipo_cust and
   in_custodia   = @i_custodia and
   in_fecha_insp = @i_fecha_insp and
   in_lote       = @i_lote    

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0

end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'F'
begin
   if 
      @i_filial is NULL or 
      @i_sucursal is NULL or 
      @i_tipo_cust is NULL or 
      @i_custodia is NULL or 
      @i_fecha_insp is NULL 
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
   if @i_valor_fact = 0 or @i_valor_fact is null
     
select @i_estado_tramite = 'S'
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
    /* Ya existe el registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903002
      return 1 
   end
   else
   begin
          select @w_secservicio = @@spid

      begin tran
         exec sp_externo 
         @i_filial,@i_sucursal,@i_tipo_cust,
         @i_custodia, @w_codigo_externo out

         insert into cu_inspeccion(
         in_filial,        in_sucursal,       in_tipo_cust,
         in_custodia,      in_fecha_insp,     in_inspector,
         in_estado,        in_factura,        in_valor_fact,
         in_observaciones, in_instruccion,    in_motivo,
         in_valor_avaluo,  in_estado_tramite, in_codigo_externo ,
         in_lote,          in_pago,           in_evaluacion,    
         in_registro 
         ) 
         values (
         @i_filial,        @i_sucursal,       @i_tipo_cust,
         @i_custodia,      @i_fecha_insp,     @i_inspector,
         @i_estado,        @i_factura,        @i_valor_fact,
         @i_observaciones, @i_instruccion,    @i_motivo,
         @i_valor_avaluo,  @i_estado_tramite, @w_codigo_externo,
         @i_lote,          'N',               @i_evaluacion , 
         @i_registro
         )
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903001
            return 1 
         end

         -- MODIFICA LA FECHA Y VALOR DEL CONTROL DE INSPECTORES
         if exists (select 1 from cu_control_inspector
                    where ci_inspector = @i_inspector
                    and ci_fenvio_carta = @i_fecha_carta
                    and ci_lote         = @i_lote)
         begin  
            select @w_valor_anterior = isnull(ci_valor_facturado,0)
            from cu_control_inspector
            where ci_inspector    = @i_inspector
            and ci_fenvio_carta = @i_fecha_carta
            and ci_lote         = @i_lote
            select @w_valor_anterior = isnull(@w_valor_anterior,0) 
            update cu_control_inspector
            set ci_frecep_reporte  = @i_fecha_reporte,
            ci_valor_facturado = isnull(@w_valor_anterior,0)+
                                 isnull(@i_valor_fact,0)
            where  ci_inspector    = @i_inspector
            and  ci_fenvio_carta = @i_fecha_carta
            and  ci_lote         = @i_lote
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1903005
               return 1 
            end
         end
         else
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903005
            return 1 
         end

        -- OBTENGO EL ESTADO DE LA GARANTIA

         select @w_estado_garantia = cu_estado
         from cu_custodia
         where cu_codigo_externo = @w_codigo_externo

     -- ***************************************        
     -- Se incrementa el numero de inspecciones
                    
           update cob_custodia..cu_custodia
           set
           cu_nro_inspecciones = isnull(cu_nro_inspecciones,0) + 1
           where  
           cu_filial   = @i_filial and
           cu_sucursal = @i_sucursal and
           cu_tipo     = @i_tipo_cust and
           cu_custodia = @i_custodia

           if @@error <> 0 
           begin
	   /* Error en insercion de registro */
	      exec cobis..sp_cerror
	      @t_from  = @w_sp_name,
	      @i_num   = 1905001
	      return 1 
	    end
if @i_periodicidad is not null
begin
		select @w_valor_intervalo = td_factor
		from   cob_cartera..ca_tdividendo
		where  td_tdividendo = @i_periodicidad
		if @@rowcount =0
		begin
		   exec cobis..sp_cerror
	           @t_from  = @w_sp_name,
		   @i_num   = 1901003
	           return 1 
		end
	    end
           update cob_custodia..cu_custodia
           set
           cu_periodicidad  = @i_periodicidad, -- Nueva periodicidad
           cu_fecha_insp    = @i_fecha_insp,   -- Ultima fecha de inspeccion
           cu_intervalo     = @w_valor_intervalo1,
           cu_fecha_prox_insp = dateadd(dd,@w_valor_intervalo,@i_fecha_insp)
           where  
           cu_filial = @i_filial and
           cu_sucursal = @i_sucursal and
           cu_tipo = @i_tipo_cust and
           cu_custodia = @i_custodia
           if @@error <> 0 
           begin
	     /* Error en insercion de registro */
	      exec cobis..sp_cerror
	      @t_from  = @w_sp_name,
	      @i_num   = 1905001
	      return 1 
	   end
       -- ***************************************** 
       -- Se  tabla cu_por_inspeccionar 

           update cob_custodia..cu_por_inspeccionar 
           set pi_inspeccionado = 'S',
           pi_fecha_insp     = @i_fecha_insp,
           pi_inspector_ant  = @i_inspector,
           pi_estado_ant     = @i_estado,
           pi_frecep_reporte = @i_fecha_reporte
           where 
           pi_filial   = @i_filial and
           pi_sucursal = @i_sucursal and 
           pi_tipo     = @i_tipo_cust and
           pi_custodia = @i_custodia and
           pi_lote     = @i_lote and
           pi_inspeccionado = 'N'
           if @@error <> 0 
             begin
             /* Error en insercion de registro */
	      exec cobis..sp_cerror
	      @t_from  = @w_sp_name,
	      @i_num   = 1905001
	      return 1 
	     end

       -- ****************************************************** 
       -- Se calculan valores para la tabla cu_control_inspector
          select @w_valor_total = sum(isnull(in_valor_fact,0)) +
                                  isnull(@i_valor_fact,0) 
          from cu_inspeccion
          where in_inspector   = @i_inspector and
          in_lote = @i_lote

          if @@error <> 0 
          begin
         /* Error en insercion del registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903001
             return 1 
          end

         /* Transaccion de Servicio */
         /***************************/
          insert into ts_inspeccion
          values (
          @w_secservicio, @t_trn,          'N',
          @s_date,        @i_usuario,      @s_term,
          @s_ofi,         'cu_inspeccion', @i_filial,
          @i_sucursal,    @i_tipo_cust,  @i_custodia,
          @i_fecha_insp,  @i_inspector,  @i_estado,
          @i_factura,     @i_valor_fact, @i_observaciones,
          @i_instruccion, @i_motivo,     @i_valor_avaluo,
          @i_estado_tramite, @w_codigo_externo)

          if @@error <> 0 
          begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
          end
       commit tran
       return 0
    end 
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905002
       return 1 
    end
    else
    begin
          -- pga 30may2001
           select @w_secservicio = @@spid

       begin tran
          exec sp_externo
          @i_filial,@i_sucursal,@i_tipo_cust,
          @i_custodia, @w_codigo_externo out

          if @w_estado_tramite = 'S'
          begin
         /* No se puede modificar una inspeccion cobrada */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905011
             return 1 
          end
         
         if @i_inspector is null
           
select @i_inspector = @w_inspector
         if @i_estado is null
           
select @i_estado = @w_estado
         if @i_factura is null
           
select @i_factura = @w_factura
         if @i_valor_fact is null
           
select @i_valor_fact = @w_valor_fact
         if @i_observaciones is null
           
select @i_observaciones = @w_observaciones
         if @i_instruccion is null
           
select @i_instruccion = @w_instruccion
         if @i_motivo is null
           
select @i_motivo = @w_motivo
         if @i_valor_avaluo is null
           
select @i_valor_avaluo = @w_valor_avaluo
         if @i_estado_tramite is null
           
select @i_estado_tramite = @w_estado_tramite
         if @i_registro is null
           
select @i_registro = @i_registro
         if  @i_evaluacion is null
           
select  @i_evaluacion =  @i_evaluacion
        
         update cob_custodia..cu_inspeccion
         set 
         in_inspector      = @i_inspector,
         in_estado         = @i_estado,
         in_factura        = @i_factura,
         in_valor_fact     = @i_valor_fact,
         in_observaciones  = @i_observaciones,
         in_instruccion    = @i_instruccion,
         in_motivo         = @i_motivo,
         in_valor_avaluo   = @i_valor_avaluo,
         in_codigo_externo = @w_codigo_externo,
         in_estado_tramite = @i_estado_tramite,
         in_registro       = @i_registro,             
         in_evaluacion     = @i_evaluacion                
         where 
         in_filial     = @i_filial and
         in_sucursal   = @i_sucursal and
         in_tipo_cust  = @i_tipo_cust and
         in_custodia   = @i_custodia and
         in_fecha_insp = @i_fecha_insp and
         in_lote       = @i_lote

         if @@error <> 0 
           begin
	   /* Error en insercion de registro */
	     exec cobis..sp_cerror
	     @t_from  = @w_sp_name,
	     @i_num   = 1905001
	     return 1 
	   end
       -- ***************************************** 
       -- Se actualiza la tabla cu_por_inspeccionar

         update cob_custodia..cu_por_inspeccionar 
         set  pi_fecha_insp = @i_fecha_insp
         where 
         pi_filial   = @i_filial and
         pi_sucursal = @i_sucursal and 
         pi_tipo     = @i_tipo_cust and
         pi_custodia = @i_custodia and
         pi_lote     = @i_lote and
         pi_inspeccionado = 'S' 
         if @@error <> 0 
           begin
	   /* Error en insercion de registro */
	   exec cobis..sp_cerror
	   @t_from  = @w_sp_name,
	   @i_num   = 1905001
	   return 1 
	  end

         -- MODIFICA LA FECHA Y VALOR DEL CONTROL DE INSPECTORES
         
         select @w_valor_anterior = isnull(ci_valor_facturado,0)
         from cu_control_inspector
         where ci_inspector    = @i_inspector
         and ci_fenvio_carta = @i_fecha_carta
         and ci_lote            = @i_lote

         if @i_valor_fact <> @w_valor_fact
            select @w_valor_anterior = isnull(@w_valor_anterior,0) - 
                                       isnull(@w_valor_fact,0) +
                                       isnull(@i_valor_fact,0)
         select @w_valor_anterior = isnull(@w_valor_anterior,0)
         update cu_control_inspector
         set ci_frecep_reporte  = @i_fecha_reporte,
         ci_valor_facturado = isnull(@w_valor_anterior,0)
         where  ci_inspector    = @i_inspector
         and  ci_fenvio_carta = @i_fecha_carta
         and  ci_lote         = @i_lote

        -- OBTENGO EL ESTADO DE LA GARANTIA 

         select @w_estado_garantia = cu_estado
         from cu_custodia
         where cu_codigo_externo = @w_codigo_externo

    if @i_periodicidad is not null
   
begin
	select @w_valor_intervalo = td_factor
	from   cob_cartera..ca_tdividendo
	where  td_tdividendo = @i_periodicidad
	if @@rowcount =0
	begin
	   exec cobis..sp_cerror
           @t_from  = @w_sp_name,
	   @i_num   = 1901003
           return 1 
	end
    end

         update cob_custodia..cu_custodia
         set
         cu_periodicidad = @i_periodicidad,
         cu_fecha_insp   = @i_fecha_insp,
         cu_intervalo    = @w_valor_intervalo1,
         cu_fecha_prox_insp = dateadd(dd,@w_valor_intervalo,@i_fecha_insp)
         from cu_custodia
         where  
         cu_filial = @i_filial and
         cu_sucursal = @i_sucursal and
         cu_tipo = @i_tipo_cust and
         cu_custodia = @i_custodia and
         cu_periodicidad <> @i_periodicidad
         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
         end

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_inspeccion
         values (@w_secservicio,@t_trn,'P',
         @s_date,@i_usuario,@s_term,
         @s_ofi,'cu_inspeccion', @w_filial,
         @w_sucursal, @w_tipo_cust, @w_custodia,
         @w_fecha_insp, @w_inspector, @w_estado,
         @w_factura, @w_valor_fact, @w_observaciones,
         @w_instruccion, @w_motivo, @w_valor_avaluo,
         @w_estado_tramite, @w_codigo_externo)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
        /* Transaccion de Servicio */
         /***************************/

         insert into ts_inspeccion
         values (@w_secservicio,@t_trn,'A',
         @s_date,@i_usuario,@s_term,
         @s_ofi,'cu_inspeccion', @i_filial,
         @i_sucursal, @i_tipo_cust, @i_custodia,
         @i_fecha_insp, @i_inspector, @i_estado,
         @i_factura, @i_valor_fact, @i_observaciones,
         @i_instruccion, @i_motivo, @i_valor_avaluo,
         @i_estado_tramite, @w_codigo_externo)
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
    return 0
    end
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end

    if @w_estado_tramite = 'S'
    begin
    /* No se puede modificar una inspeccion cobrada */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905011
       return 1 
    end
         
          -- pga 30may2001
          select @w_secservicio = @@spid
 
    begin tran

         delete cob_custodia..cu_inspeccion
         where 
         in_filial = @i_filial and
         in_sucursal = @i_sucursal and
         in_tipo_cust = @i_tipo_cust and
         in_custodia = @i_custodia and
         in_fecha_insp = @i_fecha_insp and
         in_lote       = @i_lote                                      
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

         -- ELIMINA EL VALOR DEL GASTO
         
         select @w_valor_anterior = isnull(ci_valor_facturado,0)
           from cu_control_inspector
          where ci_inspector    = @i_inspector
            and ci_fenvio_carta = @i_fecha_carta

            select @w_valor_anterior = isnull(@w_valor_anterior,0) - 
                                       isnull(@w_valor_fact,0) 
            update cu_control_inspector
            set ci_valor_facturado = isnull(@w_valor_anterior,0)
            where  ci_inspector    = @i_inspector
            and  ci_fenvio_carta = @i_fecha_carta
            if @@error <> 0 
            begin
	      /* Error en insercion de registro */
	       exec cobis..sp_cerror
	       @t_from  = @w_sp_name,
	       @i_num   = 1905001
	       return 1 
	     end

         -- ACTUALIZO LA TABLA DE POR INSPECCIONAR
         -- **************************************

         update cu_por_inspeccionar
         set pi_inspeccionado = 'N'
         where
               pi_filial   = @i_filial and
               pi_sucursal = @i_sucursal and 
               pi_tipo     = @i_tipo_cust and
               pi_custodia = @i_custodia and
               pi_inspeccionado = 'S' and
               pi_fecha_insp    = @i_fecha_insp and
	       pi_lote          = @i_lote
	  if @@error <> 0 
          begin
	   /* Error en insercion de registro */
	   exec cobis..sp_cerror
	   @t_from  = @w_sp_name,
	   @i_num   = 1905001
	   return 1 
	 end
          -- MODIFICA EL VALOR DE LA GARANTIA  MVI 08/14/96
          --***********************************************

        select @w_estado_garantia = cu_estado
          from cu_custodia
         where cu_codigo_externo = @w_codigo_externo

         insert into ts_inspeccion
         values (
         @w_secservicio,    @t_trn,           'B',
         @s_date,           @i_usuario,       @s_term,
         @s_ofi,            'cu_inspeccion',  @w_filial,       
         @w_sucursal,       @w_tipo_cust,     @w_custodia,     
         @w_fecha_insp,     @w_inspector,     @w_estado,        
         @w_factura,        @w_valor_fact,    @w_observaciones, 
         @w_instruccion,    @w_motivo,        @w_valor_avaluo,  
         @w_estado_tramite, @w_codigo_externo)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'

begin
    if @w_existe = 1
    begin
   
        select @w_des_tipo = tc_descripcion
          from cu_tipo_custodia 
         where tc_tipo = @w_tipo_cust


        select @w_des_est_inspeccion = A.valor
          from cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla and
               B.tabla  = 'cu_est_inspeccion' and
               A.codigo = @w_estado
	set transaction isolation level read uncommitted

        select @w_fenvio_carta   = ci_fenvio_carta,
               @w_frecep_reporte = ci_frecep_reporte
          from cu_control_inspector
         where ci_inspector = @w_inspector and
         ci_lote  = @i_lote   
        
        select @w_periodicidad = cu_periodicidad
          from cu_custodia
         where cu_codigo_externo = @w_codigo_externo 


          select @w_des_periodicidad = td_descripcion
          from   cob_cartera..ca_tdividendo
          where  td_tdividendo = @w_periodicidad


           set rowcount 1
           select @w_des_cliente = convert(varchar(10),en_ente) + '  ' +
                  p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
           from cobis..cl_ente,cu_cliente_garantia
           where cg_codigo_externo = @w_codigo_externo and
                 en_ente      = cg_ente  and
                 cg_principal = 'D' --(S)i  
           set rowcount 0
      
         select @w_des_inspector = is_nombre  
           from cu_inspector
           where 
                 is_inspector  = @w_inspector 
      
       
         select @w_evaluacion = in_evaluacion ,
                @w_registro   = in_registro
                
          from cu_inspeccion
         where in_codigo_externo = @w_codigo_externo and
               in_fecha_insp     = @w_fecha_insp     and
               in_lote           = @i_lote             
               
               select @w_des_evalua = A.valor
          from cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla and
               B.tabla  = 'cu_evaluacion' and
               A.codigo = @w_evaluacion     
         set transaction isolation level read uncommitted

         select 
              @w_filial,
              @w_sucursal,
              @w_tipo_cust,
              @w_des_tipo,
              @w_custodia,
              @w_des_cliente, 
              isnull(convert(varchar(20),@w_inspector),''),
              @w_des_inspector,
              @w_estado,
              @w_des_est_inspeccion,
              @w_factura,
              @w_valor_fact,
              convert(char(10),@w_fecha_insp,@i_formato_fecha),
              @w_valor_avaluo,
              @w_periodicidad,
              @w_des_periodicidad,
              @w_observaciones,
              @w_instruccion,
              convert(char(10),@w_fenvio_carta,@i_formato_fecha),
              convert(char(10),@w_frecep_reporte,@i_formato_fecha),
              @i_lote ,
              @w_evaluacion ,  --jvc
              @w_registro ,
              @w_des_evalua
    end
    else
    begin
        
        select @w_inspector = pi_inspector_asig
          from cu_por_inspeccionar
         where pi_filial    = @i_filial 
           and pi_sucursal  = @i_sucursal
           and pi_tipo      = @i_tipo_cust
           and pi_custodia  = @i_custodia  
           and pi_lote      = @i_lote 
        select @w_des_inspector = is_nombre  
          from cu_inspector
         where is_inspector  = @w_inspector 
 
        select @w_periodicidad = cu_periodicidad
          from cu_custodia
         where cu_filial   = @i_filial and
               cu_sucursal = @i_sucursal and  
               cu_tipo     = @i_tipo_cust and  
               cu_custodia = @i_custodia  
           


          select @w_des_periodicidad = td_descripcion
          from   cob_cartera..ca_tdividendo
          where  td_tdividendo = @w_periodicidad


        select @w_inspector,
               @w_des_inspector,
               @w_periodicidad,
               @w_des_periodicidad

        return 1 
    end
    return 0
end


if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0
   begin 
      select distinct 
      B.in_lote              as LOTE,
      B.in_custodia          as GARANTIA, 
      B.in_tipo_cust         as TIPO,
      A.tc_descripcion       as DESCRIPCION_DEL_TIPO,
      convert(varchar(10),B.in_fecha_insp,@i_formato_fecha) as FECHA,
      (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y  where X.tabla = Y.codigo
                  and Y.tabla = 'cu_est_inspeccion' 
		  and B.in_estado = X.codigo) as ESTADO,
      B.in_inspector                  as INSPECTOR,
      I.is_nombre                     as NOMBRE_INSPECTOR,
      E.cg_ente                       as CLIENTE,
      E.cg_nombre                     as NOMBRE_CLIENTE,
      cu_codigo_externo               as CODIGO_EXTERNO   
      from cu_inspeccion B,cu_custodia C,cu_tipo_custodia A, 
      	cu_por_inspeccionar P, cu_inspector I, cu_cliente_garantia E
      where (B.in_filial = @i_filial) and
      (B.in_codigo_externo = C.cu_codigo_externo) and
      (cg_codigo_externo = C.cu_codigo_externo) and
       cg_principal = 'D' and 
      (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
      (cg_oficial <= @i_oficial2 or @i_oficial2 is null) and
      (A.tc_tipo = C.cu_tipo) and
      (B.in_codigo_externo = P.pi_codigo_externo) and
      (B.in_lote = P.pi_lote) and
      (B.in_tipo_cust like @i_tipo_cust or @i_tipo_cust is null) and
      (B.in_custodia >= @i_custodia1 or @i_custodia1 is null) and
      (B.in_custodia <= @i_custodia2 or @i_custodia2 is null) and
      (B.in_estado = @i_estado or @i_estado is null) and
      (B.in_fecha_insp >= @i_fecha_insp1
       or @i_fecha_insp1 is null) and
      (B.in_fecha_insp <= @i_fecha_insp2
       or @i_fecha_insp2 is null) and
      (B.in_inspector = @i_inspector or @i_inspector is null) and
      ((B.in_tipo_cust > @i_tipo_cust1 or (B.in_tipo_cust = @i_tipo_cust1
      and B.in_custodia > @i_custodia3) or (B.in_tipo_cust = @i_tipo_cust1
      and B.in_custodia = @i_custodia3 and B.in_fecha_insp >@i_fecha_insp3)) 
      or @i_custodia3 is null)
      and I.is_inspector = B.in_inspector
      order by LOTE,
      GARANTIA, 
      TIPO,
      DESCRIPCION_DEL_TIPO,
      FECHA,
      ESTADO,		 
      INSPECTOR ,
      NOMBRE_INSPECTOR ,
      CLIENTE,
      NOMBRE_CLIENTE ,
      CODIGO_EXTERNO
      if @@rowcount = 0
      begin
         if @i_custodia is null /* Modo 0 */
            return 1 
         else
            return 2 
      end 
   end -- fin modo 0

   if @i_modo = 1
   begin 
      select distinct 
      B.in_lote as LOTE,
      B.in_custodia as GARANTIA, 
      B.in_tipo_cust as TIPO,
      A.tc_descripcion as DESCRIPCION_DEL_TIPO,
      convert(varchar(10),B.in_fecha_insp,@i_formato_fecha) as FECHA,
      (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y                            where X.tabla = Y.codigo
                  and Y.tabla = 'cu_est_inspeccion' 
		  and B.in_estado = X.codigo) as ESTADO,
      B.in_inspector as INSPECTOR,
      I.is_nombre as NOMBRE_INSPECTOR,
      E.cg_ente as CLIENTE,
      E.cg_nombre as NOMBRE_CLIENTE
      from cu_inspeccion B,cu_custodia C,cu_tipo_custodia A, 
      	cu_por_inspeccionar P, cu_inspector I, cu_cliente_garantia E
      where (B.in_filial      = @i_filial) and
         (B.in_codigo_externo = C.cu_codigo_externo) and
         (cg_codigo_externo   = C.cu_codigo_externo) and
          cg_principal        = 'D' and  
         (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
         (cg_oficial <= @i_oficial2 or @i_oficial2 is null) and
         (A.tc_tipo = C.cu_tipo) and
         (B.in_codigo_externo = P.pi_codigo_externo) and
         (B.in_lote = P.pi_lote) and
         (B.in_custodia >= @i_custodia1 or @i_custodia1 is null) and
         (B.in_custodia <= @i_custodia2 or @i_custodia2 is null) and
         (B.in_estado = @i_estado or @i_estado is null) and
         (B.in_fecha_insp >= @i_fecha_insp1
          or @i_fecha_insp1 is null) and
         (B.in_fecha_insp <= @i_fecha_insp2
          or @i_fecha_insp2 is null) and
         (B.in_inspector = @i_inspector or @i_inspector is null) 
         and I.is_inspector = B.in_inspector
         and ((in_tipo_cust > @i_tipo_cust) OR  
           (in_custodia > @i_custodia and in_tipo_cust > @i_tipo_cust) )        
         order by LOTE      ,
                  GARANTIA  , 
                  TIPO      ,
                  DESCRIPCION_DEL_TIPO,
                  FECHA    ,
      ESTADO ,
      INSPECTOR ,
      NOMBRE_INSPECTOR ,
      CLIENTE ,
      NOMBRE_CLIENTE
      if @@rowcount = 0
      begin
         if @i_custodia is null 
            return 1 
         else
            return 2 
      end 
   end -- fin modo 1


      return 0
end 
    
if @i_operacion = 'Z'
begin
      set rowcount 20
         select distinct
         in_lote as LOTE,
         in_custodia as GARANTIA , 
         in_tipo_cust as TIPO,
         tc_descripcion as DESCR ,
         convert(char(10),in_fecha_insp,@i_formato_fecha) as FECHA,
         cg_oficial as GERENTE , 
         en_ente as CLIENTE ,
         p_p_apellido + ' '+ p_s_apellido + ' ' + en_nombre as APELLIDOS,
         in_estado as ESTADO , 
         in_inspector as INSPECTOR
         from cu_inspeccion, cu_custodia, cobis..cl_ente,
              cu_cliente_garantia, cu_tipo_custodia
         where (in_filial      = @i_filial) and
            (in_sucursal       = @i_sucursal) and
            (in_codigo_externo = cu_codigo_externo) and
            (tc_tipo           = cu_tipo) and
            (in_codigo_externo = cg_codigo_externo) and
            (in_tipo_cust like @i_tipo_cust or @i_tipo_cust is null) and
            (in_custodia >= @i_custodia1 or @i_custodia1 is null) and
            (in_custodia <= @i_custodia2 or @i_custodia2 is null) and
            (in_estado = @i_estado or @i_estado is null) and
            (in_fecha_insp >= @i_fecha_insp1 or @i_fecha_insp1 is null) and
            (in_fecha_insp <= @i_fecha_insp2 or @i_fecha_insp2 is null) and
            (in_inspector = @i_inspector or @i_inspector is null) and
            (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
            (en_ente = cg_ente) and
            cg_principal  = 'D' and 
            (en_ente = @i_cliente or @i_cliente is null) and
            ((in_tipo_cust > @i_tipo_cust1 or (in_tipo_cust = @i_tipo_cust1
            and in_custodia > @i_custodia3) or (in_tipo_cust = @i_tipo_cust1
            and in_custodia = @i_custodia3 and in_fecha_insp >@i_fecha_insp3)) 
            or @i_custodia3 is null)
         order by LOTE,      
         GARANTIA ,  
         TIPO,      
         DESCR,    
         FECHA ,   
         GERENTE ,  
         CLIENTE ,
         APELLIDOS,
         ESTADO  , 
         INSPECTOR 
         if @@rowcount = 0
         begin
            if @i_custodia is null /* Modo 0 */
               select @w_error  = 1901003
            else
               select @w_error  = 1901004
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
         end 
         return 0
end


if @i_operacion = 'N' 
begin
      set rowcount 20
      select distinct  in_custodia as GARANTIA, 
                in_tipo_cust as TIPO,
                tc_descripcion as DESCR,
                convert(char(10),in_fecha_insp,@i_formato_fecha) as FECHA,
                cu_valor_inicial as VALOR,
                cg_oficial as GERENTE, 
                en_ente as CLIENTE,
                p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre as APELLIDOS,
                in_estado as ESTADO, 
                in_inspector as INSPECTOR ,
                in_observaciones as NOVEDADES, 
                substring(in_instruccion,1,70) as COMENTARIO
         from cu_inspeccion,cu_custodia,cobis..cl_ente,
              cu_cliente_garantia, cu_tipo_custodia
         where (in_filial = @i_filial) and
            (in_sucursal = @i_sucursal) and
            (in_codigo_externo = cu_codigo_externo) and
            (tc_tipo = cu_tipo) and
            (in_codigo_externo = cg_codigo_externo) and
            (in_observaciones is not null) and
            (in_tipo_cust like @i_tipo_cust or @i_tipo_cust is null) and
            (in_custodia >= @i_custodia1 or @i_custodia1 is null) and
            (in_custodia <= @i_custodia2 or @i_custodia2 is null) and
            (in_estado = @i_estado or @i_estado is null) and
            (in_fecha_insp >= @i_fecha_insp1
             or @i_fecha_insp1 is null) and
            (in_fecha_insp <= @i_fecha_insp2
             or @i_fecha_insp2 is null) and
            (in_inspector = @i_inspector or @i_inspector is null) and
            (cg_oficial >= @i_oficial1 or @i_oficial1 is null) and
            (cg_oficial <= @i_oficial2 or @i_oficial2 is null) and
            (en_ente = cg_ente) and
            cg_principal  = 'D' and  
            (en_ente = @i_cliente or @i_cliente is null) and
            ((in_tipo_cust > @i_tipo_cust1 or (in_tipo_cust = @i_tipo_cust1
            and in_custodia > @i_custodia3) or (in_tipo_cust = @i_tipo_cust1
            and in_custodia = @i_custodia3 and in_fecha_insp >@i_fecha_insp3)) 
            or @i_custodia3 is null)
         order by GARANTIA , 
                TIPO ,
                DESCR ,
                FECHA,
                VALOR ,
                GERENTE , 
                CLIENTE ,
                APELLIDOS ,
                ESTADO , 
                INSPECTOR ,
                NOVEDADES , 
                COMENTARIO
         if @@rowcount = 0
         begin
            if @i_custodia is null /* Modo 0 */
               select @w_error  = 1901003
            else
               select @w_error  = 1901004
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return 1
         end 
         return 0
end

if @i_operacion = 'T'
begin
    select @w_valor_total = sum(isnull(in_valor_fact,0))
      from cu_inspeccion
     where in_inspector = @i_inspector 
    
end


if @i_operacion = 'B'  
begin
   set rowcount 20
   select
   'LOTE' = pi_lote,
   'GARANTIA' = pi_custodia, 
   'TIPO' = pi_tipo,
   'DESCRIPCION' = tc_descripcion,
   'CLIENTE' = en_ente,
   'NOMBRE' = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
   'PERIODICIDAD' = cu_periodicidad ,
   'DESC.' = td_descripcion,
   'CODIGO GARANTIA' = pi_codigo_externo   
   from cu_control_inspector,cu_por_inspeccionar,cu_custodia,
   cu_tipo_custodia,cu_cliente_garantia,
   cobis..cl_ente , cob_cartera..ca_tdividendo 
   where  pi_filial         = @i_filial 
   and  pi_sucursal       = @i_sucursal 
   and  ci_inspector      = @i_inspector 
   and  ci_fenvio_carta   = @i_fecha_carta 
   and  pi_inspector_asig = @i_inspector 
   and  pi_codigo_externo = cu_codigo_externo 
   and  pi_inspeccionado  = 'N'
   and  cu_inspeccionar   = 'S' 
   and  cu_periodicidad   <> 'N'
   and  cg_principal      = 'D'  
   and  en_ente           = cg_ente 
   and ((pi_tipo > @i_tipo_cust1) or   
       (pi_tipo = @i_tipo_cust1 and pi_custodia > @i_custodia1) or
       (@i_tipo_cust1 is null)) 
   and cu_periodicidad = td_tdividendo
   and  pi_lote           = ci_lote
   and  tc_tipo           = pi_tipo 
   and  cg_codigo_externo = cu_codigo_externo 
   order by pi_tipo, pi_custodia
         
   return 0
end

if @i_operacion = 'E'
begin
  begin tran
     if exists (select 1 from cu_inspeccion
                 where in_filial         = @i_filial
                   and in_sucursal       = @i_sucursal
                   and in_custodia       = @i_custodia
                   and in_tipo_cust      = @i_tipo_cust
                   and in_fecha_insp     = @i_fecha_insp
                   and in_estado_tramite = 'N')

     update cu_inspeccion
     set in_estado_tramite = 'S'
     where in_filial         = @i_filial
        and in_sucursal       = @i_sucursal
        and in_custodia       = @i_custodia
        and in_tipo_cust      = @i_tipo_cust
        and in_fecha_insp     = @i_fecha_insp
     else
     begin
        select @w_error = 1907002
        goto error
     end
   commit tran
end

return 0

error:    /* Rutina que dispara sp_cerror dado el codigo de error */

             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = @w_error
             return 1