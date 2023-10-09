/************************************************************************/
/*	Archivo:                ctrlabg.sp                              */
/*	Stored procedure:       sp_ctrl_abg                             */
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
/*	de abogados                                                     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995   L. Castellanos	Emision inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_ctrl_abg')
    drop proc sp_ctrl_abg

go
create proc sp_ctrl_abg (
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @w_secservicio_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
-- @i_inspector          tinyint  = null, --NUEVA6
   @i_inspector          catalogo  = null,
-- @i_abogado            tinyint  = null, --NUEVA6
   @i_abogado            catalogo  = null,
   @i_fenvio_carta       datetime  = null,
   @i_frecep_reporte     datetime  = null,
   @i_valor_facturado    money  = null,
   @i_valor_pagado       money  = null,
   @i_fecha_pago         datetime  = null,
   @i_inspector1         int  = null,
--   @i_abogado1           tinyint  = null,
   @i_abogado1           catalogo  = null,
   @i_formato_fecha      int       = null,  --PGA 16/06/2000
   @i_fenvio1  		 datetime = null,
   @i_fenvio2            datetime = null,
   @i_param1             varchar(10) = null,
   @i_param2             varchar(10) = null,
   @i_cond1              varchar(15) = null,
   @i_cond2              varchar(15) = null,
   @i_cond3              varchar(15) = null,
   @i_fec_max_rep        datetime    = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
--   @w_inspector          tinyint,
   @w_secservicio        int,
   @w_inspector          catalogo,
--   @w_abogado            tinyint,
   @w_abogado            catalogo,
   @w_fenvio_carta       datetime,
   @w_frecep_reporte     datetime,
   @w_valor_facturado    money,
   @w_valor_pagado       money,
   @w_fecha_pago         datetime,
   @w_aux                money 

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_ctrl_abg'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19840 and @i_operacion = 'I') or
   (@t_trn <> 19841 and @i_operacion = 'U') or
   (@t_trn <> 19842 and @i_operacion = 'D') or
   (@t_trn <> 19843 and @i_operacion = 'V') or
   (@t_trn <> 19844 and @i_operacion = 'S') or
   (@t_trn <> 19845 and @i_operacion = 'Q') or
   (@t_trn <> 19846 and @i_operacion = 'A') 
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
         @w_abogado = ca_abogado,
         @w_fenvio_carta = ca_fenvio_carta,
         @w_frecep_reporte = ca_frecep_reporte,
         @w_valor_facturado = ca_valor_facturado,
         @w_fecha_pago = ca_fecha_pago
    from cob_custodia..cu_control_abogado
    where 
         ca_abogado = @i_abogado and
         ca_fenvio_carta = @i_fenvio_carta

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

--pga 18may2001
select @w_secservicio = @@spid
/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' 
begin
    if 
         @i_abogado is NULL or 
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
         insert into cu_control_abogado(
              ca_abogado,
              ca_fenvio_carta,
              ca_frecep_reporte,
              ca_valor_facturado,
              ca_fecha_pago,
              ca_pago )
         values (
              @i_abogado,
              @i_fenvio_carta,
              @i_frecep_reporte,
              @i_valor_facturado,
              @i_fecha_pago,
              'N' )

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

         insert into ts_control_abogado
         values (@w_secservicio,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cu_control_abogado',
         @i_inspector,
         @i_fenvio_carta,
         @i_frecep_reporte,
         @i_valor_facturado,
         @i_valor_pagado,
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
         update cob_custodia..cu_control_abogado
         set 
              ca_frecep_reporte = @i_frecep_reporte,
              ca_valor_facturado = @i_valor_facturado,
              ca_fecha_pago = @i_fecha_pago
    where 
         ca_abogado = @i_abogado and
         ca_fenvio_carta = @i_fenvio_carta

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

         insert into ts_control_abogado
         values (@w_secservicio,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,'cu_control_abogado',
         @w_abogado,
         @w_fenvio_carta,
         @w_frecep_reporte,
         @w_valor_facturado,
         @w_valor_pagado,
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


         insert into ts_control_abogado
         values (@w_secservicio,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,'cu_control_abogado',
         @i_abogado,
         @i_fenvio_carta,
         @i_frecep_reporte,
         @i_valor_facturado,
         @i_valor_pagado,
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
         delete cob_custodia..cu_control_abogado
    where 
         ca_abogado = @i_abogado and
         ca_fenvio_carta = @i_fenvio_carta

                                          
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

         insert into ts_control_abogado
         values (@w_secservicio,@t_trn,'B',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_control_abogado', @w_abogado,
         @w_fenvio_carta, @w_frecep_reporte, @w_valor_facturado,
         @w_valor_pagado, @w_fecha_pago)

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
      "ABOGADO"=ca_abogado,  --LAL DE AVAL A ABOGADO
      "ENVIO CARTA"=convert(char(10),ca_fenvio_carta,@i_formato_fecha),
      "LOTE"         = ca_lote,
      "FECHA REPORTE"=convert(char(10),ca_frecep_reporte,@i_formato_fecha),
      "VALOR FACTURADO"=ca_valor_facturado,
      "GARANTIA" = ga_codigo_externo,
      "REVISADO" = ga_revisado
      --"FECHA PAGO"=convert(char(10),ca_fecha_pago,@i_formato_fecha)
      from cu_control_abogado ,cu_gar_abogado--, cob_credito..cr_abogado
      where (ca_abogado = @i_abogado or @i_abogado is null)-- LAL CAMBIO DE
      and (ca_fenvio_carta >= @i_fenvio1 or @i_fenvio1 is null)
      and (ca_fenvio_carta <= @i_fenvio2 or @i_fenvio2 is null)
      and ca_abogado = ga_abogado_asig
      and ca_lote = ga_lote
      and ca_fenvio_carta = ga_fenvio_carta
      order by ca_abogado

      if @@rowcount = 0
      begin
        /*No existes registros */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901003
        return 1 
      end

       set rowcount 0

   end
   if @i_modo = 1
   begin

      set rowcount 20
      select
      "ABOGADO"=ca_abogado,
      "ENVIO CARTA"=convert(char(10),ca_fenvio_carta,@i_formato_fecha),
      "LOTE" = ca_lote,
      "FECHA REPORTE"=convert(char(10),ca_frecep_reporte,@i_formato_fecha),
      "VALOR FACTURADO"=ca_valor_facturado,
      "GARANTIA" = ga_codigo_externo,
      "REVISADO" = ga_revisado
      from cu_control_abogado,cu_gar_abogado
      where (ca_abogado = @i_abogado or @i_abogado is null)
      and (ca_fenvio_carta >= @i_fenvio1 or @i_fenvio1 is null)
      and (ca_fenvio_carta <= @i_fenvio2 or @i_fenvio2 is null)
      and ((ca_abogado > @i_abogado) or
          (ca_abogado = @i_abogado1 and ca_fenvio_carta > @i_fenvio_carta)) 
      and ca_abogado = ga_abogado_asig
      and ca_lote = ga_lote
      and ca_fenvio_carta = ga_fenvio_carta
      order by ca_abogado

      if @@rowcount = 0
      begin
        /*No existes mas registros */
        exec cobis..sp_cerror
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
   if @i_fenvio_carta is null
      select @i_fenvio_carta = convert(datetime,@i_cond2,@i_formato_fecha)
   if @i_abogado is null
      select @i_abogado = @i_cond1
      select distinct
      "ABOGADO" = ca_abogado,
      "FECHA ENVIO CARTA" = convert(varchar(15),ca_fenvio_carta,@i_formato_fecha) 
  --   "LOTE"    = ca_lote
      from cu_control_abogado
      where (ca_abogado = @i_abogado or @i_abogado is null)
      and (ca_fenvio_carta >= @i_fenvio_carta or @i_fenvio_carta is null)
      and ca_fenvio_carta is not null
      and ca_lote is not null
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
   if exists (select * from cu_control_abogado
               where ca_abogado = @i_abogado
                 and convert(varchar(10),ca_fenvio_carta,@i_formato_fecha) = 
                     convert(varchar(10),@i_fenvio_carta,@i_formato_fecha))
      select  @w_aux = @w_valor_facturado
   else
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end
end
go