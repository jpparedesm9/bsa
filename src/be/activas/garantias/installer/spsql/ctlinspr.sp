/************************************************************************/
/*	Archivo:                ctlinspr.sp                             */
/*	Stored procedure:       sp_ctrl_inspect                         */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Ingreso / Modificacion / Eliminacion y Consulta del Control     */
/*	de Inspectores                                                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995   L. Castellanos	Emision inicial			*/
/*      Nov/2002   Jennifer V                                           */   
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_ctrl_inspect')
    drop proc sp_ctrl_inspect
go
create proc sp_ctrl_inspect (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_inspector          int  = null,
   @i_fenvio_carta       datetime  = null,
   @i_frecep_reporte     datetime  = null,
   @i_valor_facturado    money  = null,
   @i_fecha_pago         datetime  = null,
   @i_inspector1         int  = null,
   @i_formato_fecha      int = null,
   @i_fenvio1  		 datetime = null,
   @i_fenvio2            datetime = null,
   @i_fenvio3  		 datetime = null,
   @i_fenvio4            datetime = null,
   @i_param1             varchar(10) = null,
   @i_param2             varchar(10) = null,
   @i_cond1              varchar(15) = null,
   @i_cond2              varchar(15) = null,
   @i_cond3              varchar(15) = null,
   @i_fec_max_rep        datetime    = null,
   @i_tipo_cust		 varchar(10) = null	
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_inspector          int,
   @w_secservicio        int,
   @w_fenvio_carta       datetime,
   @w_frecep_reporte     datetime,
   @w_valor_facturado    money,
   @w_fecha_pago         datetime,
   @w_aux                money 

select @w_today = convert(varchar(10),getdate(),101)
select @w_sp_name = 'sp_ctrl_inspect'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19070 and @i_operacion = 'I') or
   (@t_trn <> 19071 and @i_operacion = 'U') or
   (@t_trn <> 19072 and @i_operacion = 'D') or
   (@t_trn <> 19073 and @i_operacion = 'V') or
   (@t_trn <> 19074 and @i_operacion = 'S') or
   (@t_trn <> 19075 and @i_operacion = 'Q') or
   (@t_trn <> 19076 and @i_operacion = 'A') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,

    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
         @w_inspector = ci_inspector,
         @w_fenvio_carta = ci_fenvio_carta,
         @w_frecep_reporte = ci_frecep_reporte,
         @w_valor_facturado = ci_valor_facturado,
         @w_fecha_pago = ci_fecha_pago
    from cob_custodia..cu_control_inspector
    where 
         ci_inspector = @i_inspector and
         ci_fenvio_carta = @i_fenvio_carta

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end
-- pga18may2001
select @w_secservicio = @@spid

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' 
begin
    if 
         @i_inspector is NULL or 
         @i_fenvio_carta is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901002
        return 1 
    end


    begin tran
         insert into cu_control_inspector(
              ci_inspector,
              ci_fenvio_carta,
              ci_frecep_reporte,
              ci_valor_facturado,
              ci_fecha_pago,
              ci_fmaxrecep,
              ci_pago ) --FPL Jun/26/1997 Agregar fecha maxima de recepcion
         values (
              @i_inspector,
              @i_fenvio_carta,
              @i_frecep_reporte,
              @i_valor_facturado,
              @i_fecha_pago,
              @i_fec_max_rep,
              'N') --FPL Jun/26/1997 Fecha maxima de recepcion 

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_control_inspector
         values (@w_secservicio,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cu_control_inspector',
         @i_inspector,
         @i_fenvio_carta,
         @i_frecep_reporte,
         @i_valor_facturado,
         @i_fecha_pago)

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

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */

        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    -- PGA 18may2001
    select @w_secservicio = @@spid 
    begin tran
         update cob_custodia..cu_control_inspector
         set 
              ci_frecep_reporte = @i_frecep_reporte,
              ci_valor_facturado = @i_valor_facturado,
              ci_fecha_pago = @i_fecha_pago
    where 
         ci_inspector = @i_inspector and
         ci_fenvio_carta = @i_fenvio_carta

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_control_inspector
         values (@w_secservicio,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,'cu_control_inspector',
         @w_inspector,
         @w_fenvio_carta,
         @w_frecep_reporte,
         @w_valor_facturado,
         @w_fecha_pago)

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

            

         /* Transaccion de Servicio */
         /***************************/


         insert into ts_control_inspector
         values (@w_secservicio,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,'cu_control_inspector',
         @i_inspector,

         @i_fenvio_carta,
         @i_frecep_reporte,
         @i_valor_facturado,
         @i_fecha_pago)

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

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end

/***** Integridad Referencial *****/
/*****                        *****/


    begin tran
         delete cob_custodia..cu_control_inspector
    where 
         ci_inspector = @i_inspector and
         ci_fenvio_carta = @i_fenvio_carta

                                          
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

            


         /* Transaccion de Servicio */
         /***************************/

         insert into ts_control_inspector
         values (@w_secservicio,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,'cu_control_inspector',
         @w_inspector,
         @w_fenvio_carta,
         @w_frecep_reporte,
         @w_valor_facturado,
         @w_fecha_pago)

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
         select 
              convert(char(10),@w_frecep_reporte,@i_formato_fecha),
              convert(char(10),@w_fecha_pago,@i_formato_fecha),
              @w_valor_facturado
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901005
        return 1 
    end
    return 0
end

/* Busqueda de registros */
if @i_operacion = 'S'
begin
   if @i_modo = 0
   begin

      set rowcount 20

      select distinct
           "AVALUADOR"		= i.in_inspector,
	   "NOMBRE" 		= k.is_nombre,
           "ORDEN DE SERVICIO"	= (select convert(char(10),ci_fenvio_carta,103) from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_frecep_reporte  = ci_frecep_reporte),
         "F.MAX REPORTE"	= (select convert(char(10),ci_fmaxrecep,103) from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_frecep_reporte  = ci_frecep_reporte),
          "FECHA REPORTE"	= (select convert(char(10),ci_frecep_reporte,103) from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_fenvio_carta  = ci_fenvio_carta),
          "VALOR FACTURADO"	= (select ci_valor_facturado from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_fenvio_carta  = ci_fenvio_carta),
                              
           "GARANTIA" 		= p.pi_codigo_externo,
	   "DESCRIPCION GARANTIA" = (select tc_descripcion from cu_tipo_custodia where tc_tipo = p.pi_tipo),
	   "OFICINA GARANTIA" 	= (select of_nombre from cobis..cl_oficina where ((of_oficina = p.pi_sucursal 
	                           and p.pi_sucursal is not null)
	                          or (of_oficina = p.pi_sucursal))),
	 
	   "OFICINA AVALUADOR" 	= (select of_nombre from cobis..cl_oficina where of_oficina = convert(smallint,k.is_regional)),
           "CALIDAD AVALUO" 	= (select valor from cobis..cl_catalogo 
				   where  tabla in (select codigo from cobis..cl_tabla 
						   where  tabla = 'cu_evaluacion')
				   and    codigo = i.in_evaluacion),
	 "INSTRUCCION"       = (select in_instruccion from cu_inspeccion where in_inspector = i.in_inspector and 
                                   in_codigo_externo = p.pi_codigo_externo and in_lote = p.pi_lote
                                   and  in_fecha_insp = i.in_fecha_insp ),
	 "NUMERO FACTURA"       = (select in_factura from cu_inspeccion where in_inspector = i.in_inspector and 
                                   in_codigo_externo = p.pi_codigo_externo and in_lote = p.pi_lote
                                   and  in_fecha_insp = i.in_fecha_insp )
      from cu_por_inspeccionar p, cu_inspector k, cu_inspeccion i
      where (i.in_inspector = @i_inspector or @i_inspector is null)
      and ((p.pi_fenvio_carta  >= @i_fenvio1 or @i_fenvio1 is null)
      and (p.pi_fenvio_carta  <= @i_fenvio2 or @i_fenvio2 is null) or (p.pi_frecep_reporte >= @i_fenvio3 or @i_fenvio3 is null)
      and (p.pi_frecep_reporte <= @i_fenvio4 or @i_fenvio4 is null))
      and  p.pi_inspector_asig	= is_inspector
      and  k.is_tipo_inspector = 'A'
      and   i.in_codigo_externo = p.pi_codigo_externo
      and i.in_inspector = is_inspector
      --and in_sucursal =x.cu_sucursal
      --and in_tipo_cust = x.cu_tipo
      --and in_custodia = x.cu_custodia
      order by in_inspector
      --ci_inspector



      if @@rowcount = 0
      begin
        /*No existes registros */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901003
        return 1 
      end
      set rowcount 0

   end
   if @i_modo = 1
   begin

      set rowcount 20
      select distinct
           "AVALUADOR"		= i.in_inspector,
	   "NOMBRE" 		= k.is_nombre,
           "ORDEN DE SERVICIO"	= (select convert(char(10),ci_fenvio_carta,103) from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_frecep_reporte  = ci_frecep_reporte),
        -- "F.MAX REPORTE"	= (select convert(char(10),ci_fmaxrecep,103) from cu_control_inspector 
        --                           where ci_inspector = @i_inspector
        --                           and ci_lote =p.pi_lote 
        --                           and p.pi_frecep_reporte  = ci_frecep_reporte),
          "FECHA REPORTE"	= (select convert(char(10),ci_frecep_reporte,103) from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_fenvio_carta  = ci_fenvio_carta),
          "VALOR FACTURADO"	= (select ci_valor_facturado from cu_control_inspector 
                                   where ci_inspector = @i_inspector
                                   and ci_lote =p.pi_lote 
                                   and p.pi_fenvio_carta  = ci_fenvio_carta),
           "GARANTIA" 		= p.pi_codigo_externo,
	   "DESCRIPCION GARANTIA" = (select tc_descripcion from cu_tipo_custodia where tc_tipo = p.pi_tipo),
	   "OFICINA GARANTIA" 	= (select of_nombre from cobis..cl_oficina where ((of_oficina = p.pi_sucursal 
	                           and p.pi_sucursal is not null)
	                          or (of_oficina = p.pi_sucursal))),
	 
	   "OFICINA AVALUADOR" 	= (select of_nombre from cobis..cl_oficina where of_oficina = convert(smallint,k.is_regional)),
           "CALIDAD AVALUO" 	= (select valor from cobis..cl_catalogo 
				   where  tabla in (select codigo from cobis..cl_tabla 
						   where  tabla = 'cu_evaluacion')
				   and    codigo = i.in_evaluacion),
	 "NUMERO FACTURA"       = (select in_factura from cu_inspeccion where in_inspector = i.in_inspector and 
                                   in_codigo_externo = p.pi_codigo_externo and in_lote = p.pi_lote
                                   and  in_fecha_insp = i.in_fecha_insp ),

	 "INSTRUCCION"       = (select in_instruccion from cu_inspeccion where in_inspector = i.in_inspector and 
                                   in_codigo_externo = p.pi_codigo_externo and in_lote = p.pi_lote
                                   and  in_fecha_insp = i.in_fecha_insp )

      from cu_por_inspeccionar p, cu_inspector k, cu_inspeccion i
      where (i.in_inspector = @i_inspector or @i_inspector is null)
      and ((p.pi_fenvio_carta  >= @i_fenvio1 or @i_fenvio1 is null)
      and (p.pi_fenvio_carta  <= @i_fenvio2 or @i_fenvio2 is null) or (p.pi_frecep_reporte >= @i_fenvio3 or @i_fenvio3 is null)
      and (p.pi_frecep_reporte <= @i_fenvio4 or @i_fenvio4 is null))
      and  p.pi_inspector_asig	= is_inspector
      and  k.is_tipo_inspector = 'A'
      and   i.in_codigo_externo = p.pi_codigo_externo
      and i.in_inspector = is_inspector
      --and in_sucursal =x.cu_sucursal
      --and in_tipo_cust = x.cu_tipo
      --and in_custodia = x.cu_custodia
      order by in_inspector
      --ci_inspector


      

            
      if @@rowcount = 0
      begin
        /*No existes mas registros */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901004
        return 1 
      end


      set rowcount 0
   end
end 
            
if @i_operacion = 'A'
begin

if @i_cond3 is not null
  select @i_formato_fecha = convert(int,@i_cond3)
else
  select @i_formato_fecha = 101


      set rowcount 20
   
      if @i_inspector is null
         select @i_inspector = convert(int,@i_cond1)
      select distinct
      "AVALUADOR" = ci_inspector,
      "FECHA ENVIO CARTA" = convert(varchar(10),ci_fenvio_carta,@i_formato_fecha)
       from cu_control_inspector
       where (ci_inspector = @i_inspector or @i_inspector is null)
         and (ci_fenvio_carta >= @i_fenvio_carta or @i_fenvio_carta is null)
      if @@rowcount = 0
        /*  begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1901003
           return 1 
         end */
        return 1
end

if @i_operacion = 'V'
begin
   if exists (select * from cu_control_inspector
              where ci_inspector = @i_inspector
              and convert(varchar(10),ci_fenvio_carta,@i_formato_fecha) = 
                  convert(varchar(10),@i_fenvio_carta,@i_formato_fecha))
   begin
      select  @w_aux = @w_valor_facturado
   end
   else
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end
go