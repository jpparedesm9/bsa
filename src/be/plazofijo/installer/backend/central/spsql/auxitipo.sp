/************************************************************************/
/*  Archivo               : auxiliar_tipo.sp                            */
/*  Stored procedure      : sp_auxiliar_tipo                            */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Carolina Alvarado                           */
/*  Fecha de documentacion: 15/Ago/95                                   */
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
/*  FECHA         AUTOR         RAZON                                   */
/*  03/Nov/2005   L. Im         Considerar tipos op deshabilitadas      */
/*  13-Jun-2016   N. Silva      Porting DAVIVIENDA                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_auxiliar_tipo')
   drop proc sp_auxiliar_tipo 
go

create proc sp_auxiliar_tipo (   
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
@w_sucursal               varchar(10),
@w_regional               varchar(10),
@w_cont_suc               int,
@w_cont_reg               int

select @w_sp_name = 'sp_auxiliar_tipo' 

if (@t_trn <> 14136 or @i_operacion <> 'I') and (@t_trn <> 14336 or @i_operacion <> 'D') and
   (@t_trn <> 14436 or @i_operacion <> 'C') and (@t_trn <> 14536 or @i_operacion <> 'S') and
   (@t_trn <> 14636 or @i_operacion <> 'H') begin
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
   
   if @i_tipo_reg = 'PLA' begin
      select
      @w_val_min = pl_plazo_min, 
      @w_val_max = pl_plazo_max
      from  cob_pfijo..pf_plazo
      where pl_mnemonico = @i_valor
     
     if exists (select 1
                from  cob_pfijo..pf_plazo, cob_pfijo..pf_auxiliar_tip
                where pl_mnemonico     = at_valor
                and   at_tipo          = @i_tipo_reg
                and   at_tipo_deposito = @w_tipo_deposito
                and   at_estado        = 'A'
                and   at_moneda        = @i_moneda
                and  (@w_val_min between pl_plazo_min and pl_plazo_max or @w_val_max between pl_plazo_min and pl_plazo_max)) begin
         select
         @w_error = 141120,
         @w_msg   = '['+@w_sp_name+'] ' + 'Rango de plazo ya existe'
      end
   end
   
   if @i_tipo_reg = 'MOT' begin   
      select
      @w_val_min = mo_monto_min,
      @w_val_max = mo_monto_max
      from  cob_pfijo..pf_monto
      where mo_mnemonico = @i_valor
     
      if exists (select 1
                 from  cob_pfijo..pf_monto, cob_pfijo..pf_auxiliar_tip
                 where mo_mnemonico     = at_valor
                 and   at_tipo          = @i_tipo_reg
                 and   at_tipo_deposito = @w_tipo_deposito
                 and   at_estado        = 'A'
                 and   at_moneda        = @i_moneda
                 and  (@w_val_min between mo_monto_min and mo_monto_max or @w_val_max between mo_monto_min and mo_monto_max)) begin
         select
         @w_error = 141120,
         @w_msg   = '['+@w_sp_name+'] ' + 'Rango de monto ya existe'
      end
   end
   
   if @i_tipo_reg = 'PRO' begin
      select
      @w_val_min = rp_prorroga_min,
      @w_val_max = rp_prorroga_max
      from  cob_pfijo..pf_rango_prorroga
      where rp_mnemonico = @i_valor
     
      if exists (select 1
                 from  cob_pfijo..pf_rango_prorroga, cob_pfijo..pf_auxiliar_tip
                 where rp_mnemonico     = at_valor
                 and   at_tipo          = @i_tipo_reg
                 and   at_tipo_deposito = @w_tipo_deposito
                 and   at_estado        = 'A'
                 and   at_moneda        = @i_moneda
                 and  (@w_val_min between rp_prorroga_min and rp_prorroga_max or @w_val_max between rp_prorroga_min and rp_prorroga_max)) begin
         select
         @w_error = 141120,
         @w_msg   = '['+@w_sp_name+'] ' + 'prorroga de monto ya existe'
      end
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
      
   if @i_tipo_reg = 'OFI' and @w_at_estado <> 'E' begin
      if exists (select 1 from cob_pfijo..pf_conversion where cv_codigo_ofi = @i_valor and cv_moneda = @i_moneda and cv_toperacion = convert(varchar,@w_tipo_deposito))
         select  @w_sp_name = @w_sp_name         
      else begin
         insert into cob_pfijo..pf_conversion(
         cv_oficina,                  cv_codigo_ofi,                      cv_operacion, 
         cv_linea,                    cv_toperacion,                      cv_moneda) 
         values(
         convert(smallint,@i_valor),  @i_valor,                           0, 
         0,                           convert(varchar,@w_tipo_deposito),  @i_moneda)       
         
         if @@error <> 0 begin
            select @w_msg = '['+@w_sp_name+'] ' + 'Error al insertar en pf_conversion'
            select @w_error = 143036
         end           
      end
     
      if @i_cod_dia >= 0 begin
         select @w_ins_ofi_fest = 'N' 
         if exists (select 1
                    from   pf_feriados_oficina
                    where  fo_tipo_deposito        = @w_tipo_deposito
                    and    fo_moneda               = @i_moneda
                    and    fo_oficina              = @i_valor
                    and    fo_cod_dia              = @i_cod_dia
                    and    fo_estado               = 'V') begin
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141256
            return 1
         end
         else begin
            select @w_ins_ofi_fest = 'S' 
            
            if @w_ins_ofi_fest = 'S' begin
               insert into pf_feriados_oficina(
               fo_tipo_deposito,    fo_moneda,          fo_oficina,
               fo_cod_dia,          fo_estado,          fo_fecha_modificacion,
               fo_usuario)
               values(
               @w_tipo_deposito,      @i_moneda,              @i_valor,           
               @i_cod_dia,            'V',                    @s_date,
               @s_user)
            
               if @@error <> 0 begin
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143066
                  return 143005
               end
               select @w_valor = @i_valor + '-' + @i_cod_dia
            end
         end
      end
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
      @w_msg   = 'No existe registro en PF_AUXILIAR_TIP'
      goto ERROR  
   end

   begin tran

   if @i_tipo_reg = 'OFI' begin
      select
	  @w_sucursal = of_zona,
	  @w_regional = of_regional
	  from  cobis..cl_oficina
	  where of_oficina = @i_valor
	  
	  select @w_cont_suc =  count(1)
      from   cobis..cl_oficina, cob_pfijo..pf_auxiliar_tip
      where  at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_valor         = of_oficina
      and    of_zona          = @w_sucursal
      and    at_tipo          = 'OFI'
      and    at_estado        = 'A'
      and    of_oficina      <> @i_valor
	  
	  select @w_cont_reg =  count(1)
      from   cobis..cl_oficina, cob_pfijo..pf_auxiliar_tip
      where  at_tipo_deposito = @w_tipo_deposito 
      and    at_moneda        = @i_moneda 
      and    at_valor         = of_oficina
      and    of_regional      = @w_regional
      and    at_tipo          = 'OFI'
      and    at_estado        = 'A'
      and    of_oficina      <> @i_valor
   
      if exists(select 1 from pf_operacion where op_oficina = convert(smallint,@i_valor) and op_toperacion = @i_mnemonico and op_moneda = @i_moneda) begin
         select
         @w_msg   = '['+@w_sp_name+'] ' + 'No se puede eliminar porque existen depositos asociados a esta oficina',
         @w_error = 147036
      end
      else begin
         delete cob_pfijo..pf_conversion
         where  cv_codigo_ofi = @i_valor
         and    cv_moneda     = @i_moneda
         and    cv_toperacion = convert(varchar,@w_tipo_deposito)
      end
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
   @s_ssn,            @t_trn,           'B',         @s_date,
   @s_user,           @s_term,          @s_srv,      @s_lsrv,
   @w_tipo_deposito,  @i_moneda,        @i_tipo_reg, @i_valor,         
   @w_fecha_crea,     @s_date,          @w_estado)
   
   if @@error <> 0 begin
      select
     @w_error = 143005,
      @w_msg   = 'No puede insertar transaccion de Servicio de PF_AUXILIAR_TIP'
      goto ERROR
   end 

   commit tran
   
   if @w_cont_suc = 0 and @i_tipo_reg = 'OFI' begin
      if exists (select 1 from pf_auxiliar_tip where at_tipo_deposito = @w_tipo_deposito and at_moneda = @i_moneda and at_tipo = 'SUC' and at_valor = @w_sucursal and at_estado = 'A') begin
         exec @w_return = cob_pfijo..sp_reg_sucursal
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
         @t_trn                = 14274,
         @i_operacion          = 'D',
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'SUC',
         @i_valor              = @w_sucursal,
         @i_moneda             = @i_moneda,
         @i_flag               = @i_flag
         
         if @@error <> 0 begin
            select
            @w_error = 147036,
            @w_msg   = 'Error en la eliminacion de registros PF_AUXILIAR_TIP'
            goto ERROR 
         end
	  end
   end
   
   if @w_cont_reg = 0 and @i_tipo_reg = 'OFI' begin
      if exists (select 1 from pf_auxiliar_tip where at_tipo_deposito = @w_tipo_deposito and at_moneda = @i_moneda and at_tipo = 'REG' and at_valor = @w_regional and at_estado = 'A') begin
         exec @w_return = cob_pfijo..sp_reg_sucursal
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
         @t_trn                = 14274,
         @i_operacion          = 'D',
         @i_tipo               = @i_tipo,
         @i_mnemonico          = @i_mnemonico,
         @i_tipo_reg           = 'REG',
         @i_valor              = @w_regional,
         @i_moneda             = @i_moneda,
         @i_flag               = @i_flag
         
         if @@error <> 0 begin
            select
            @w_error = 147036,
            @w_msg   = 'Error en la eliminacion de registros PF_AUXILIAR_TIP'
            goto ERROR 
         end
      end
   end  
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
     if @i_tipo_reg = 'PLA' begin
         select
         'VALOR'       = at_valor,      
         'DESCRIPCION' = pl_descripcion
         from  pf_auxiliar_tip, pf_plazo
         where at_valor         = pl_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   at_valor         > @i_valor
         order by at_valor
      end
     
     if @i_tipo_reg = 'MOT' begin
         select
         'VALOR'       = at_valor,
         'DESCRIPCION' = substring(mo_descripcion,1,30)
         from  pf_auxiliar_tip, pf_monto
         where at_valor         = mo_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   at_valor         > @i_valor
         order by at_valor
      end
     
     if @i_tipo_reg = 'PPE' begin
         select
         'VALOR'       = at_valor,
         'DESCRIPCION' = substring(pp_descripcion,1,30),
         'FACTOR'      = pp_factor_en_meses,
         'PORCENTAJE'  = at_porcentaje,
         'FACTOR DIAS' = pp_factor_dias 
         from  pf_auxiliar_tip, pf_ppago
         where rtrim(at_valor)  = rtrim(pp_codigo)    
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   at_valor         > @i_valor
         order by at_tipo,at_valor
      end
     
     if @i_tipo_reg = 'CAT' begin
         select
         'VALOR'       = a.at_valor,
         'DESCRIPCION' = substring(c.valor,1,30)
         from  pf_auxiliar_tip a, cobis..cl_tabla b, cobis..cl_catalogo c
         where b.tabla            = 'pf_categoria'  
         and   b.codigo           = c.tabla 
         and   c.codigo           = a.at_valor 
         and   a.at_tipo_deposito = @w_tipo_deposito 
         and   a.at_moneda        = @i_moneda 
         and   a.at_tipo          = @i_tipo_reg 
         and   a.at_estado        = 'A' 
         and   a.at_valor         > @i_valor
         order by at_valor
      end
     
     if @i_tipo_reg = 'OFI' begin
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
      end
     
     if @i_tipo_reg = 'PRO' begin
         select distinct
         'VALOR'       = at_valor,      
         'DESCRIPCION' = rp_descripcion
         from   cob_pfijo..pf_auxiliar_tip, cob_pfijo..pf_rango_prorroga
         where  at_valor         = rp_mnemonico
         and    at_tipo_deposito = @w_tipo_deposito 
         and    at_moneda        = @i_moneda 
         and    at_tipo          = @i_tipo_reg 
         and    at_estado        = 'A' 
         and    at_valor         > @i_valor
         order by at_valor
      end
     
     if @i_tipo_reg = 'TPCMOT' begin
        select distinct
         'VALOR'       = ta_tipo_monto,
         'DESCRIPCION' = substring(mo_descripcion ,1,30)
         from  cob_pfijo..pf_tasa, cob_pfijo..pf_monto
         where ta_tipo_deposito = @i_mnemonico
         and   ta_tipo          = 'P'
         and   mo_mnemonico     = ta_tipo_monto
         and   ta_tipo_monto    > @i_valor
         order by ta_tipo_monto
      end
     
     if @i_tipo_reg = 'TPCPLA' begin
         select distinct
         'VALOR'       = ta_tipo_plazo,
         'DESCRIPCION' = substring(pl_descripcion ,1,30)
         from  cob_pfijo..pf_tasa, cob_pfijo..pf_plazo
         where ta_tipo_deposito = @i_mnemonico
         and   ta_tipo          = 'P'
         and   pl_mnemonico     = ta_tipo_plazo
         and   ta_tipo_plazo    > @i_valor
         order by ta_tipo_plazo
      end
     
     if @i_tipo_reg = 'MON' begin
         select distinct 
         'CODIGO' = at_moneda,
         'VALOR'  = mo_descripcion
         from  pf_auxiliar_tip, cobis..cl_moneda
         where at_tipo_deposito = @w_tipo_deposito
         and   at_moneda        = mo_moneda
         and   at_estado        = 'A'
         order by at_moneda 
      end

      set rowcount 0 
      return 0   
   end
   
   if @i_tipo = 'B' begin 
      if @i_tipo_reg = 'PLA' begin
         select
         'VALOR'       = at_valor,      
         'DESCRIPCION' = pl_descripcion
         from  pf_auxiliar_tip, pf_plazo
         where at_valor         = pl_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   pl_descripcion like @i_valor
         order by pl_descripcion
      end
    
     if @i_tipo_reg = 'MOT' begin
         select
         'VALOR'       = at_valor,
         'DESCRIPCION' = substring(mo_descripcion,1,30)
         from  pf_auxiliar_tip, pf_monto
         where at_valor         = mo_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   mo_descripcion like @i_valor
         order by mo_descripcion
      end
     
     if @i_tipo_reg = 'PRO' begin
         select distinct
         'VALOR'       = at_valor,      
         'DESCRIPCION' = rp_descripcion
         from   cob_pfijo..pf_auxiliar_tip, cob_pfijo..pf_rango_prorroga
         where  at_valor         = rp_mnemonico
         and    at_tipo_deposito = @w_tipo_deposito 
         and    at_moneda        = @i_moneda 
         and    at_tipo          = @i_tipo_reg 
         and    at_estado        = 'A' 
         and    rp_descripcion like @i_valor
         order by rp_descripcion
      end
    
     if @i_tipo_reg = 'PPE' begin
         select
         'VALOR'       = at_valor,
         'DESCRIPCION' = substring(pp_descripcion,1,30),
         'FACTOR'      = pp_factor_en_meses,
         'PORCENTAJE'  = at_porcentaje
         from  pf_auxiliar_tip, pf_ppago
         where rtrim(at_valor)  = rtrim(pp_codigo)    
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   pp_descripcion like @i_valor
         order by pp_descripcion
      end  
    
     if @i_tipo_reg = 'CAT' begin
         select
         'VALOR'       = a.at_valor,
         'DESCRIPCION' = substring(c.valor,1,30)
         from  pf_auxiliar_tip a, cobis..cl_tabla b, cobis..cl_catalogo c
         where b.tabla            = 'pf_categoria'  
         and   b.codigo           = c.tabla 
         and   c.codigo           = a.at_valor 
         and   a.at_tipo_deposito = @w_tipo_deposito 
         and   a.at_moneda        = @i_moneda 
         and   a.at_tipo          = @i_tipo_reg 
         and   a.at_estado        = 'A' 
         and   c.valor like @i_valor 
         order by c.valor
      end  
   end
   
   if @i_tipo = 'F' begin
      if @i_tipo_reg = 'PPE' begin
         select
         'VALOR'         = at_valor,
         'DESCRIPCION'   = substring(pp_descripcion,1,30),
         'FACTOR'        = pp_factor_en_meses,
         'PORCENTAJE'    = at_porcentaje
         from  pf_auxiliar_tip, pf_ppago
         where rtrim(at_valor)    = rtrim(pp_codigo)  
         and   at_tipo_deposito   = @w_tipo_deposito 
         and   at_moneda          = @i_moneda 
         and   at_tipo            = @i_tipo_reg 
         and   at_estado          = 'A'
         and   pp_factor_en_meses = @i_factor
         order by pp_descripcion
      end  
   end
   
   if @i_tipo = 'V' begin
      if @i_tipo_reg = 'PLA' begin
         select substring(pl_descripcion,1,30)
         from  pf_auxiliar_tip, pf_plazo
         where at_valor         = pl_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_valor         = @i_valor 
         and   at_estado        = 'A'
       
         if @@rowcount = 0 begin
            select @w_error = 141121
            goto ERROR
         end
      end
     
      if @i_tipo_reg = 'MOT' begin
         select substring(mo_descripcion,1,30)
         from   pf_auxiliar_tip, pf_monto
         where  at_valor         = mo_mnemonico 
         and    at_tipo_deposito = @w_tipo_deposito 
         and    at_moneda        = @i_moneda 
         and    at_tipo          = @i_tipo_reg 
         and    at_valor         = @i_valor 
         and    at_estado        = 'A'
         
         if @@rowcount = 0 begin
            select @w_error = 141121
            goto ERROR
         end
      end
	  
      if @i_tipo_reg = 'PPE' begin
         select
		 substring(pp_descripcion,1,30), 
         pp_factor_en_meses,
         at_porcentaje,
         pp_factor_dias
         from  pf_auxiliar_tip, pf_ppago
         where rtrim(at_valor)  = rtrim(pp_codigo) 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_valor         = @i_valor 
         and   at_estado        = 'A'

         if @@rowcount = 0 begin
            select @w_error = 141199
            goto ERROR
         end
      end
	  
	  if @i_tipo_reg = 'CAT' begin
         select substring(c.valor,1,30)
         from   pf_auxiliar_tip a, cobis..cl_tabla b, cobis..cl_catalogo c
         where  b.tabla            = 'pf_categoria'  
         and    b.codigo           = c.tabla 
         and    c.codigo           = a.at_valor 
         and    a.at_tipo_deposito = @w_tipo_deposito 
         and    a.at_moneda        = @i_moneda 
         and    a.at_tipo          = @i_tipo_reg 
         and    a.at_valor         = @i_valor 
         and    a.at_estado        = 'A'

         if @@rowcount = 0 begin
            select @w_error = 141070
            goto ERROR
         end
      end
	  
	  if @i_tipo_reg = 'OFI' begin
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
	  
	  if @i_tipo_reg = 'MON' begin
         select distinct mo_descripcion
         from   cobis..cl_moneda, pf_auxiliar_tip
         where  at_tipo_deposito = @w_tipo_deposito
         and    at_estado        = 'A'
         and    at_moneda        = mo_moneda
         and    at_moneda        = @i_moneda 
 
         if @@rowcount = 0 begin
            select @w_error = 141143
            goto ERROR
         end
      end
	  
      if @i_tipo_reg = 'PRO' begin
         select substring(rp_descripcion,1,30)
         from   cob_pfijo..pf_auxiliar_tip, cob_pfijo..pf_rango_prorroga
         where  at_valor         = rp_mnemonico 
         and    at_tipo_deposito = @w_tipo_deposito 
         and    at_moneda        = @i_moneda 
         and    at_tipo          = @i_tipo_reg 
         and    at_valor         = @i_valor 
         and    at_estado        = 'A'
       
         if @@rowcount = 0 begin
            select @w_error = 141121
            goto ERROR
         end
      end	  
   end
   
   if @i_tipo = 'H' begin
      select @i_val_sig = case @i_modo when 0 then 0 when 1 then @i_val_sig end
	  set rowcount 20
	  
	  if @i_tipo_reg = 'PLA' begin
         select
         'VALOR'       = at_valor,      
         'DESCRIPCION' = pl_descripcion,
         'PLAZO MIN'   = pl_plazo_min
         from  pf_auxiliar_tip, pf_plazo
         where at_valor         = pl_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   pl_plazo_min     > @i_val_sig
         order by pl_plazo_min
      end
	  
	  if @i_tipo_reg = 'MOT' begin
         select
		 'VALOR'       = at_valor,
         'DESCRIPCION' = substring(mo_descripcion,1,30),
         'MONTO MIN'   = mo_monto_min
         from  pf_auxiliar_tip, pf_monto
         where at_valor         = mo_mnemonico 
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   mo_monto_min     > @i_val_sig
         order by mo_monto_min
      end
	  
	  if @i_tipo_reg = 'PPE' begin
         select
         'VALOR'       = at_valor,
         'DESCRIPCION' = substring(pp_descripcion,1,30),
         'FACTOR DIAS' = pp_factor_dias
         from  pf_auxiliar_tip, pf_ppago
         where rtrim(at_valor)  = rtrim(pp_codigo)    
         and   at_tipo_deposito = @w_tipo_deposito 
         and   at_moneda        = @i_moneda 
         and   at_tipo          = @i_tipo_reg 
         and   at_estado        = 'A' 
         and   pp_factor_dias   > @i_val_sig
         union 
         select
         'VALOR'       = null,
         'DESCRIPCION' = 'VENCIMIENTO',
         'FACTOR DIAS' = 0
         order by pp_factor_dias 
      end
	  
	  if @i_tipo_reg = 'TPCMOT' begin
         select distinct
         'VALOR'       = ta_tipo_monto,
         'DESCRIPCION' = substring(mo_descripcion ,1,30),
         'MONTO MIN'   = mo_monto_min
         from cob_pfijo..pf_tasa, cob_pfijo..pf_monto
         where ta_tipo_deposito = @i_mnemonico
         and ta_tipo          = 'P'
         and mo_mnemonico     = ta_tipo_monto
         and mo_monto_min     > @i_val_sig
         order by mo_monto_min
      end
	  
	  if @i_tipo_reg = 'TPCPLA' begin
         select distinct
		 'VALOR'       = ta_tipo_plazo,
         'DESCRIPCION' = substring(pl_descripcion ,1,30),
         'PLAZO MIN'   = pl_plazo_min
         from  cob_pfijo..pf_tasa, cob_pfijo..pf_plazo
         where ta_tipo_deposito = @i_mnemonico
         and   ta_tipo          = 'P'
         and   pl_mnemonico     = ta_tipo_plazo
         and   pl_plazo_min     > @i_val_sig
         order by pl_plazo_min
      end
	  
	  if @i_tipo_reg = 'PRO' begin
         select
         'VALOR'       = at_valor,      
         'DESCRIPCION' = rp_descripcion,
         'PLAZO MIN'   = rp_prorroga_min
         from   cob_pfijo..pf_auxiliar_tip, cob_pfijo..pf_rango_prorroga
         where  at_valor         = rp_mnemonico
         and    at_tipo_deposito = @w_tipo_deposito 
         and    at_moneda        = @i_moneda 
         and    at_tipo          = @i_tipo_reg 
         and    at_estado        = 'A' 
         and    rp_prorroga_min  > @i_val_sig
         order by rp_prorroga_min
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
      and   at_moneda        = mo_moneda
      and   at_estado        = 'A'
      order by at_moneda 
  
   if @i_tipo = 'V' begin
      select mo_descripcion
      from   cobis..cl_moneda, pf_auxiliar_tip
      where  at_tipo_deposito = @w_tipo_deposito
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
   if @i_tipo_reg = 'PLA' begin
      select
      'MONEDA'      = substring(mo_descripcion,1,30),
      'DESCRIPCION' = substring(pl_descripcion,1,30),
      'COD. MONEDA' = at_moneda,
      'CODIGO'      = at_valor
      from  pf_auxiliar_tip, pf_plazo, cobis..cl_moneda
      where at_valor         = pl_mnemonico 
      and   at_tipo_deposito = @w_tipo_deposito 
      and   at_moneda        = mo_moneda 
      and   at_tipo          = @i_tipo_reg 
      and   at_estado        = 'A' 
      and ((at_moneda        = @i_moneda and at_valor > @i_valor or at_moneda > @i_moneda) or @i_modo = 0)
      order by at_moneda,at_valor
   end
   
   if @i_tipo_reg = 'MOT' begin
      select
	  'MONEDA'      = substring(c.mo_descripcion,1,30),
      'DESCRIPCION' = substring(b.mo_descripcion,1,30),
      'COD. MONEDA' = at_moneda,
      'CODIGO'      = at_valor
	  from  pf_auxiliar_tip a, pf_monto b, cobis..cl_moneda c
      where at_valor         = mo_mnemonico 
      and   at_tipo_deposito = @w_tipo_deposito 
      and   at_moneda        = mo_moneda 
      and   at_tipo          = @i_tipo_reg 
      and   at_estado        = 'A' 
      and ((at_moneda        = @i_moneda and at_valor > @i_valor or at_moneda > @i_moneda) or @i_modo = 0)
      order by at_moneda,at_valor     
   end
   
   if @i_tipo_reg = 'PPE' begin
      select
	  'MONEDA'      = substring(c.mo_descripcion,1,30),
      'DESCRIPCION' = substring(b.pp_descripcion,1,30),
      'COD. MONEDA' = at_moneda,
      'CODIGO'      = at_valor
      from  pf_auxiliar_tip a, pf_ppago b, cobis..cl_moneda c
      where rtrim(at_valor)  = rtrim(pp_codigo)    
      and   at_tipo_deposito = @w_tipo_deposito 
      and   at_moneda        = mo_moneda 
      and   at_tipo          = @i_tipo_reg 
      and   at_estado        = 'A' 
      and ((at_moneda        = @i_moneda and at_valor > @i_valor or at_moneda > @i_moneda) or @i_modo = 0)
      order by at_moneda,at_valor
   end 
  
   if @i_tipo_reg = 'CAT' begin
      select
      'MONEDA'       = substring(d.mo_descripcion,1,30),
      'DESCRIPCION'  = substring(c.valor,1,30),
      'COD. MONEDA'  = at_moneda,
      'CODIGO'       = at_valor
      from  pf_auxiliar_tip a, cobis..cl_tabla b, cobis..cl_catalogo c, cobis..cl_moneda d
      where b.tabla            = 'pf_categoria'  
      and   b.codigo           = c.tabla 
      and   c.codigo           = a.at_valor 
      and   a.at_moneda        = d.mo_moneda 
      and   a.at_tipo_deposito = @w_tipo_deposito 
      and   a.at_tipo          = @i_tipo_reg 
      and   a.at_estado        = 'A' 
      and   ((at_moneda        = @i_moneda and at_valor > @i_valor or at_moneda > @i_moneda) or @i_modo = 0)
      order by at_moneda, at_valor
   end
   
   if @i_tipo_reg = 'OFI' begin
      select @i_valor = isnull(@i_valor, '0000')
      select distinct
	  'MONEDA         ' = substring(c.mo_descripcion,1,30),
      'DESCRIPCION    ' = substring(b.of_nombre,1,30),
      'COD. MONEDA'     = at_moneda,
      'CODIGO'          = at_valor,
      'COD DIA'         = isnull(fo_cod_dia,0)
	  from cob_pfijo..pf_auxiliar_tip left outer join cob_pfijo..pf_feriados_oficina on convert(int,at_valor) = fo_oficina and at_tipo_deposito = fo_tipo_deposito and at_tipo_deposito = fo_tipo_deposito
	                                             join cobis..cl_oficina b            on convert(int,at_valor) = of_oficina
												 join cobis..cl_moneda c             on at_moneda             = mo_moneda 
	  where at_estado              = 'A'
	  and   isnull(fo_estado,'V')  = 'V'
	  and   at_tipo                = @i_tipo_reg 
	  and   at_tipo_deposito       = @w_tipo_deposito
	  and   at_valor               > @i_valor
      order by at_moneda, at_valor     
   end
   if @i_tipo_reg = 'PRO' begin
      select
      'MONEDA'      = substring(mo_descripcion,1,30),
      'DESCRIPCION' = substring(rp_descripcion,1,30),
      'COD. MONEDA' = at_moneda,
      'CODIGO'      = at_valor
      from  pf_auxiliar_tip, cob_pfijo..pf_rango_prorroga, cobis..cl_moneda
      where at_valor         = rp_mnemonico
      and   at_tipo_deposito = @w_tipo_deposito 
      and   at_moneda        = mo_moneda 
      and   at_tipo          = @i_tipo_reg 
      and   at_estado        = 'A' 
      and ((at_moneda        = @i_moneda and at_valor > @i_valor or at_moneda > @i_moneda) or @i_modo = 0)
      order by at_moneda,at_valor
   end
   
   if @i_tipo_reg in ('SUC', 'REG') begin 
      select @i_valor = isnull(@i_valor, '0000')
      select distinct
      'MONEDA         ' = substring(c.mo_descripcion,1,30),
      'DESCRIPCION    ' = substring(b.of_nombre,1,30),
      'COD. MONEDA'     = at_moneda,
      'CODIGO'          = at_valor
      from cob_pfijo..pf_auxiliar_tip left outer join cob_pfijo..pf_feriados_oficina on convert(int,at_valor) = fo_oficina and at_tipo_deposito = fo_tipo_deposito and at_tipo_deposito = fo_tipo_deposito
                                                 join cobis..cl_oficina b            on convert(int,at_valor) = of_oficina
                                                 join cobis..cl_moneda c             on at_moneda             = mo_moneda
      where at_tipo                = @i_tipo_reg
      and   at_tipo_deposito       = @w_tipo_deposito 
      and   at_estado              = 'A' 
      and   isnull(fo_estado,'V')  = 'V'
	  and   at_valor               > @i_valor
      order by at_moneda, at_valor
   end   
end 

ERROR:
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