/************************************************************************/
/*  Archivo               : reg_sucursal.sp                             */
/*  Stored procedure      : sp_reg_sucursal                             */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 12 de Octubre de 2016                       */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa procesa el mantenimiento de la tabla                  */
/*  de auxiliares de tipos de depositos                                 */
/*  Insercion de pf_auxiliar_tip                                        */
/*  Eliminacion de pf_auxiliar_tip                                      */
/*  Search de la tabla pf_auxiliar_tip                                  */
/*  Query sobre pf_auxiliar_tip                                         */
/*  Help a la tabla pf_auxiliar_tip                                     */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  12/Oct/2016    Oscar Saavedra     Emision Inicial DPF-H85256        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_reg_sucursal')
   drop proc sp_reg_sucursal 
go

create proc sp_reg_sucursal (   
@s_ssn                    int          = null,
@s_user                   login        = null,
@s_term                   varchar(30)  = null,
@s_date                   datetime     = null,
@s_srv                    varchar(30)  = null,
@s_lsrv                   varchar(30)  = null,
@s_ofi                    smallint     = null,
@s_rol                    smallint     = null,
@t_debug                  char(1)      = 'N',
@t_file                   varchar(10)  = null,
@t_from                   varchar(32)  = null,
@t_trn                    smallint     = null,
@i_operacion              char(1),     
@i_tipo                   char(1)      = null,
@i_mnemonico              catalogo     = null,
@i_tipo_reg               catalogo     = null,
@i_valor                  catalogo     = null,     
@i_moneda                 smallint     = null,       
@i_modo                   smallint     = 0,
@i_factor                 tinyint      = null,
@i_porcentaje             money        = null,     
@i_flag                   char(1)      = 'N',
@i_val_sig                money        = 0,
@i_cod_dia                char(1)      = 0)
with encryption
as
declare
@w_sp_name                varchar(32),
@w_return                 int,
@w_tipo_deposito          int,
@w_moneda                 smallint,       
@w_tipo_reg               catalogo,   
@w_valor                  varchar(5),
@w_fecha_crea             datetime,
@w_estado                 char(1), 
@w_codigo                 char(1),
@w_descripcion            descripcion,
@w_msg                    varchar(255),
@w_error                  int,
@w_val_min                money,
@w_val_max                money,
@w_ins_ofi_fest           varchar(2), 
@w_at_estado              char(1),
@w_oficina                smallint,
@w_nombre                 descripcion

select @w_sp_name = 'sp_reg_sucursal' 

if (@t_trn <> 14174 or @i_operacion <> 'I') and (@t_trn <> 14274 or @i_operacion <> 'D') and
   (@t_trn <> 14374 or @i_operacion <> 'C') and (@t_trn <> 14474 or @i_operacion <> 'S') and
   (@t_trn <> 14574 or @i_operacion <> 'H') begin
   select @w_error = 141112
   goto ERROR
end
if @i_operacion = 'I' begin
   select @w_tipo_deposito = td_tipo_deposito
   from   pf_tipo_deposito 
   where  td_mnemonico = @i_mnemonico 
   and   (td_estado    = 'A' or @i_flag = 'S')
  
   if @@rowcount = 0 begin
      select @w_error = 141115
      goto ERROR
   end
   
   select @w_msg = '['+@w_sp_name+'] ' + mensaje
   from   cobis..cl_errores
   where  numero = 141120
   
   if @i_tipo_reg = 'REG' begin
      if OBJECT_ID(N'tempdb..#OficinaRegional', N'U') is not null
         drop table #OficinaRegional
      
      create table #OficinaRegional(
      or_oficina     smallint,
      or_nombre      descripcion)
      
      insert into #OficinaRegional
      select of_oficina, of_nombre
      from   cobis..cl_oficina
      where  of_subtipo  = 'O'
      and    of_regional = @i_valor
	  and    of_oficina not in (select at_valor from cob_pfijo..pf_auxiliar_tip where at_tipo = 'OFI' and at_tipo_deposito = @w_tipo_deposito and at_estado = 'A')
	  
	  begin tran
      
      while 1 = 1 begin
         select
         @w_oficina = or_oficina,
         @w_nombre  = or_nombre
         from #OficinaRegional
         order by or_oficina
      
         if @@rowcount = 0
            break
      
         exec @w_return = cob_pfijo..sp_auxiliar_tipo
         @s_ssn                = @s_ssn,
         @s_user               = @s_user,
         @s_term               = @s_term,
         @s_date               = @s_date,
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,
         @s_ofi                = @s_ofi,
         @s_rol                = @s_rol,
         @t_debug              = @t_debug,
         @t_file               = @t_file,
         @t_from               = @t_from,
         @t_trn                = 14136,
         @i_operacion          = @i_operacion,
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'OFI',
         @i_valor              = @w_oficina,
         @i_moneda             = @i_moneda,
         @i_modo               = @i_modo,
         @i_factor             = @i_factor,
         @i_porcentaje         = @i_porcentaje,
         @i_flag               = @i_flag,
         @i_val_sig            = @i_val_sig,
         @i_cod_dia            = 0
      
         if @w_return <> 0 begin
            select @w_error = 143036
            goto ERROR
         end
		 
         delete
         from  #OficinaRegional
         where or_oficina = @w_oficina
      end
	  
	  while @@trancount > 0
         commit tran
   end
   
   if @i_tipo_reg = 'SUC' begin
      if OBJECT_ID(N'tempdb..#OficinaSucursal', N'U') is not null
         drop table #OficinaSucursal
      
      create table #OficinaSucursal(
      or_oficina     smallint,
      or_nombre      descripcion)
      
      insert into #OficinaSucursal
      select of_oficina, of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'O'
      and    of_zona    = @i_valor
	  and    of_oficina not in (select at_valor from cob_pfijo..pf_auxiliar_tip where at_tipo = 'OFI' and at_tipo_deposito = @w_tipo_deposito and at_estado = 'A')
	  
	  begin tran
      
      while 1 = 1 begin
         select
         @w_oficina = or_oficina,
         @w_nombre  = or_nombre
         from #OficinaSucursal
         order by or_oficina
      
         if @@rowcount = 0
            break
      
         exec @w_return = cob_pfijo..sp_auxiliar_tipo
         @s_ssn                = @s_ssn,
         @s_user               = @s_user,
         @s_term               = @s_term,
         @s_date               = @s_date,
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,
         @s_ofi                = @s_ofi,
         @s_rol                = @s_rol,
         @t_debug              = @t_debug,
         @t_file               = @t_file,
         @t_from               = @t_from,
         @t_trn                = 14136,
         @i_operacion          = @i_operacion,
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'OFI',
         @i_valor              = @w_oficina,
         @i_moneda             = @i_moneda,
         @i_modo               = @i_modo,
         @i_factor             = @i_factor,
         @i_porcentaje         = @i_porcentaje,
         @i_flag               = @i_flag,
         @i_val_sig            = @i_val_sig,
         @i_cod_dia            = 0
      
         if @w_return <> 0 begin
            select @w_error = 143036
            goto ERROR
         end
		 
         delete
         from  #OficinaSucursal
         where or_oficina = @w_oficina
      end
	  
	  while @@trancount > 0
         commit tran
   end
   
   select @w_at_estado = at_estado
   from   pf_auxiliar_tip 
   where  at_tipo_deposito = @w_tipo_deposito 
   and    at_moneda        = @i_moneda 
   and    at_tipo          = @i_tipo_reg 
   and    at_valor         = @i_valor 
   and    at_estado in ('A','E')
                
   if @@rowcount <> 0 begin
      if @w_at_estado = 'A' or isnull(@w_error,0) <> 0 begin
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_msg    = @w_msg,
         @i_num    = 141120
         return 1     
      end
   end  
   
   begin tran
   
   if isnull(@w_at_estado,'A') = 'A' begin   
      insert into pf_auxiliar_tip(
      at_tipo_deposito, at_moneda,     at_tipo,       at_valor,      
      at_fecha_crea,    at_fecha_elim, at_estado,     at_porcentaje)
      values(
      @w_tipo_deposito, @i_moneda,     @i_tipo_reg,   @i_valor,      
      @s_date,          @s_date,       'A',           @i_porcentaje)
     
      if @@error <> 0 begin
         select
         @w_error = 143036,
         @w_msg   = 'Errror Insertando Tipo de Auxiliar'
         goto ERROR
      end
   end
   else begin
      update pf_auxiliar_tip
      set    at_estado = 'A'
      where  at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_tipo          = @i_tipo_reg 
      and    at_valor         = @i_valor 
         
      if @@error <> 0 begin
         select
         @w_error = 143036,
         @w_msg   = 'N0 puede insertar, en PF_AUXILIAR_TIP'
         goto ERROR
      end
   end

   if @w_at_estado is null begin
      select @w_at_estado = at_estado
      from   pf_auxiliar_tip 
      where  at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_tipo          = @i_tipo_reg 
      and    at_valor         = @i_valor 
      and    at_estado in ('A','E')
   end
   
   insert into ts_auxiliar_tip(
   secuencial,       tipo_transaccion, clase,       fecha,
   usuario,          terminal,         srv,         lsrv,
   tipo_deposito,    moneda,           tipo,        valor,          
   fecha_crea,       fecha_elim,       estado,      porcentaje)
   values(
   @s_ssn,           @t_trn,           'N',         @s_date,
   @s_user,          @s_term,          @s_srv,      @s_lsrv,
   @w_tipo_deposito, @i_moneda,        @i_tipo_reg, @i_valor,                  
   @s_date,          null,             'A',         @i_porcentaje)
   
   if @@error <> 0 begin
      select
      @w_error = 143005,
      @w_msg   = 'No puede insertar transaccion de Servicio de PF_AUXILIAR_TIP'
      goto ERROR
   end
   
   while @@trancount > 0
      commit tran
   return 0
end

if @i_operacion = 'D' begin
   select @w_tipo_deposito = td_tipo_deposito 
   from   pf_tipo_deposito 
   where  td_mnemonico = @i_mnemonico 
   and   (td_estado    = 'A' or @i_flag = 'S')
        
   if @@rowcount = 0 begin
      select
     @w_error = 141115,
      @w_msg   = 'No existe Tipo de Deposito'
      goto ERROR
   end

   select
   @w_estado     = at_estado,          
   @w_fecha_crea = at_fecha_crea
   from  pf_auxiliar_tip
   where at_tipo_deposito = @w_tipo_deposito 
   and   at_moneda        = @i_moneda 
   and   at_tipo          = @i_tipo_reg 
   and   at_valor         = @i_valor 
   and   at_estado        = 'A'

   if @@rowcount = 0 begin
      select
      @w_error = 141121,
      @w_msg   = 'No existe registro en PF_AUXILIAR_TIP - REGIONAL'
      goto ERROR  
   end
   
   if @i_tipo_reg = 'REG' begin

      if OBJECT_ID(N'tempdb..#OficinaRegionalD', N'U') is not null
         drop table #OficinaRegionalD
      
      create table #OficinaRegionalD(
      or_oficina     smallint,
      or_nombre      descripcion)
     
      insert into #OficinaRegionalD
      select of_oficina, of_nombre
      from   cobis..cl_oficina
      where  of_subtipo  = 'O'
      and    of_regional = @i_valor
	  and    of_oficina in (select at_valor from cob_pfijo..pf_auxiliar_tip where at_tipo = 'OFI' and at_tipo_deposito = @w_tipo_deposito and at_estado = 'A')

	  begin tran
      
      while 1 = 1 begin
         select
         @w_oficina = or_oficina,
         @w_nombre  = or_nombre
         from #OficinaRegionalD
         order by or_oficina
      
         if @@rowcount = 0
            break

         exec @w_return = cob_pfijo..sp_auxiliar_tipo
         @s_ssn                = @s_ssn,
         @s_user               = @s_user,
         @s_term               = @s_term,
         @s_date               = @s_date,
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,
         @s_ofi                = @s_ofi,
         @s_rol                = @s_rol,
         @t_debug              = @t_debug,
         @t_file               = @t_file,
         @t_from               = @t_from,
         @t_trn                = 14336,
         @i_operacion          = @i_operacion,
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'OFI',
         @i_valor              = @w_oficina,
         @i_moneda             = @i_moneda,
         @i_modo               = @i_modo,
         @i_factor             = @i_factor,
         @i_porcentaje         = @i_porcentaje,
         @i_flag               = @i_flag,
         @i_val_sig            = @i_val_sig,
         @i_cod_dia            = @i_cod_dia
      
         if @w_return <> 0 begin
            return 0
         end
		 
         delete
         from  #OficinaRegionalD
         where or_oficina = @w_oficina
      end
	  
	  while @@trancount > 0
         commit tran   
   end

   if @i_tipo_reg = 'SUC' begin
      if OBJECT_ID(N'tempdb..#OficinaSucursalD', N'U') is not null
         drop table #OficinaSucursalD
      
      create table #OficinaSucursalD(
      or_oficina     smallint,
      or_nombre      descripcion)
      
      insert into #OficinaSucursalD
      select of_oficina, of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'O'
      and    of_zona    = @i_valor
	  and    of_oficina in (select at_valor from cob_pfijo..pf_auxiliar_tip where at_tipo = 'OFI' and at_tipo_deposito = @w_tipo_deposito and at_moneda = @i_moneda and at_estado = 'A')
	  
	  begin tran
      
      while 1 = 1 begin
         select
         @w_oficina = or_oficina,
         @w_nombre  = or_nombre
         from #OficinaSucursalD
         order by or_oficina
      
         if @@rowcount = 0
            break
      
         exec @w_return = cob_pfijo..sp_auxiliar_tipo
         @s_ssn                = @s_ssn,
         @s_user               = @s_user,
         @s_term               = @s_term,
         @s_date               = @s_date,
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,
         @s_ofi                = @s_ofi,
         @s_rol                = @s_rol,
         @t_debug              = @t_debug,
         @t_file               = @t_file,
         @t_from               = @t_from,
         @t_trn                = 14336,
         @i_operacion          = @i_operacion,
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'OFI',
         @i_valor              = @w_oficina,
         @i_moneda             = @i_moneda,
         @i_modo               = @i_modo,
         @i_factor             = @i_factor,
         @i_porcentaje         = @i_porcentaje,
         @i_flag               = @i_flag,
         @i_val_sig            = @i_val_sig,
         @i_cod_dia            = @i_cod_dia
      
         if @w_return <> 0 begin
            return 0
         end
		 
         delete
         from  #OficinaSucursalD
         where or_oficina = @w_oficina
      end
	  
	  while @@trancount > 0
         commit tran
   end
   
   delete pf_auxiliar_tip
   where  at_tipo_deposito = @w_tipo_deposito 
   and    at_moneda        = @i_moneda 
   and    at_tipo          = @i_tipo_reg 
   and    at_valor         = @i_valor   
   and    at_estado        = 'E'
   
   if @@error <> 0 begin
      select
      @w_error = 147036,
      @w_msg   = 'Error en la eliminacion de registros PF_AUXILIAR_TIP'
      goto ERROR 
   end

   update pf_auxiliar_tip
   set    at_estado        = 'E'
   where  at_tipo_deposito = @w_tipo_deposito 
   and    at_moneda        = @i_moneda 
   and    at_tipo          = @i_tipo_reg 
   and    at_valor         = @i_valor
   
   if @@error <> 0 begin
      select
      @w_error = 147036,
      @w_msg   = 'No puede actualizar PF_AUXILIAR_TIP'
      goto ERROR 
   end
   
   insert into ts_auxiliar_tip(
   secuencial,        tipo_transaccion, clase,       fecha,
   usuario,           terminal,         srv,         lsrv,
   tipo_deposito,     moneda,           tipo,        valor,
   fecha_crea,        fecha_elim,       estado)
   values(
   @s_ssn,           @t_trn,           'B',         @s_date,
   @s_user,          @s_term,          @s_srv,      @s_lsrv,
   @w_tipo_deposito, @i_moneda,        @i_tipo_reg, @i_valor,         
   @w_fecha_crea,    @s_date,          @w_estado)
   
   if @@error <> 0 begin
      select
     @w_error = 143005,
      @w_msg   = 'No puede insertar transaccion de Servicio de PF_AUXILIAR_TIP'
      goto ERROR
   end 

   while @@trancount > 0
      commit tran
   return 0
end

if @i_operacion in ('H','S','C') begin
   select @w_tipo_deposito = td_tipo_deposito 
   from   pf_tipo_deposito 
   where  td_mnemonico     = @i_mnemonico 
   and  ((td_estado        = 'A' and @i_flag = 'S') or isnull(@i_flag,'N') <> 'S') 

   if @@rowcount = 0 begin
      select
     @w_error = 141155,
      @w_msg   = 'No se encontro tipo de deposito'
      goto ERROR
   end
end

if @i_operacion = 'H' begin
   if @i_tipo = 'A' begin
      select @i_valor = case @i_modo when 0 then '' when 1 then @i_valor end
	  
      set rowcount 20	 
      select
      'VALOR'       = at_valor,      
      'DESCRIPCION' = substring(of_nombre,1,30)
      from  pf_auxiliar_tip, cobis..cl_oficina
      where convert(int,at_valor) = of_oficina
      and   at_tipo_deposito      = @w_tipo_deposito 
      and   at_moneda             = @i_moneda 
      and   at_tipo               = @i_tipo_reg 
      and   at_estado             = 'A'
      and   at_valor              > @i_valor
      order by at_valor
      set rowcount 0 
      return 0  
   end
   
   if @i_tipo = 'V' begin
      select of_nombre 
      from   pf_auxiliar_tip,cobis..cl_oficina
      where  convert(smallint,at_valor)  = of_oficina
      and    at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_tipo          = @i_tipo_reg 
      and    at_valor         = @i_valor 
      and    at_estado        = 'A'

      if @@rowcount = 0 begin
         select @w_error = 141143
         goto ERROR
      end
   end
end

if @i_operacion = 'S' begin
   if @i_tipo = 'A'
      select distinct 
      'CODIGO' = at_moneda,
      'VALOR'  = mo_descripcion
      from  pf_auxiliar_tip, cobis..cl_moneda
      where at_tipo_deposito = @w_tipo_deposito
	  and   at_tipo          = @i_tipo_reg 
      and   at_moneda        = mo_moneda
      and   at_estado        = 'A'
      order by at_moneda 
  
   if @i_tipo = 'V' begin
      select mo_descripcion
      from   cobis..cl_moneda, pf_auxiliar_tip
      where  at_tipo_deposito = @w_tipo_deposito
	  and   at_tipo          = @i_tipo_reg 
      and    at_estado        = 'A'
      and    at_moneda        = mo_moneda
      and    at_moneda        = @i_moneda
	  
	  if @@rowcount = 0 begin
	     exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141123
         return 1
     end                                                                                                                                              
  end
end

if @i_operacion = 'C' begin
  
   set rowcount 20
   
   select
   'MONEDA         ' = substring(c.mo_descripcion,1,30),
   'DESCRIPCION    ' = substring(b.of_nombre,1,30),
   'COD. MONEDA'     = at_moneda,
   'CODIGO'          = at_valor,
   'COD DIA'         = isnull(fo_cod_dia,0)
   from cob_pfijo..pf_auxiliar_tip left outer join cob_pfijo..pf_feriados_oficina on convert(int,at_valor) = fo_oficina and at_tipo_deposito = fo_tipo_deposito and at_tipo_deposito = fo_tipo_deposito
                                              join cobis..cl_oficina b            on convert(int,at_valor) = of_oficina
                                              join cobis..cl_moneda c             on at_moneda             = mo_moneda
   where at_tipo                = @i_tipo_reg
   and   at_tipo_deposito       = @w_tipo_deposito 
   and   at_estado              = 'A' 
   and   isnull(fo_estado,'V')  = 'V'
   order by at_moneda, at_valor
   set rowcount 0
end

ERROR:
while @@trancount > 0
   rollback tran
   
if isnull(@w_error,0) <> 0 begin
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = @w_error
   return 1
end
  
return 0
go