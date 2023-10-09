/*cu_convgar.sp****************************************************/
/*  Archivo:            cu_convgar.sp                             */
/*  Stored procedure:   sp_convenios_garantia                     */
/*  Base de datos:      cob_custodia                              */ 
/*  Producto:           Credito                                   */
/*  Disenado por:       Luis Ponce                                */
/*  Fecha de escritura: 13-Dic-2010                               */
/******************************************************************/
/*                      IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA', representantes exclusivos para el Ecuador de        */
/*  AT&T GIS  .                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                      PROPOSITO                                 */
/*  Este programa hace mantenimiento a la tabla                   */
/*  cu_convenios_garantia de cob_custodia, que guarda los tipos   */
/*  de garantias con los convenios tipo USAID                     */
/******************************************************************/
/*                    MODIFICACIONES                              */
/*  FECHA       AUTOR                 RAZON                       */
/*  13/Dic/10   Alfredo Zuluaga       Emision Inicial             */
/******************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_convenios_garantia')
   drop proc sp_convenios_garantia
go

create proc sp_convenios_garantia(

   @s_ssn                int         = null,
   @s_user               login       = null,
   @s_sesn               int         = null,
   @s_term               varchar(30) = null,
   @s_date               datetime    = null,
   @s_srv                varchar(30) = null,
   @s_lsrv               varchar(30) = null,
   @s_rol                smallint    = null,
   @s_ofi                smallint    = null,
   @s_org_err            char(1)     = null,
   @s_error              int         = null,
   @s_sev                tinyint     = null,
   @s_msg                descripcion = null,
   @s_org                char(1)     = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(10) = null,
   @t_from               varchar(32) = null,
   @t_trn                smallint    = null,
   @i_operacion          char(1),
   @i_modo               tinyint     = null,
   @i_tipo_garantia      varchar(64) = null,
   @i_codigo_convenio    varchar(10) = null,
   @i_moneda             smallint    = null,
   @i_monto              money       = null,
   @i_monto_mn           money       = null,
   @i_monto_aumento      money       = null,
   @i_saldo_disponible   money       = null,
   @i_valor_utilizado    money       = null,
   @i_valor_reservado    money       = null,
   @i_estado             varchar(10) = null
)
as

declare
@w_sp_name            varchar(25),
@w_msg                varchar(255),
@w_tipo_garantia      varchar(64),
@w_codigo_convenio    varchar(10),
@w_moneda             smallint,
@w_monto              money,
@w_monto_mn           money,
@w_monto_aumento      money,
@w_saldo_disponible   money,
@w_valor_utilizado    money,
@w_valor_reservado    money,
@w_estado             varchar(10),
@w_fecha_proceso      datetime,
@w_fecha_cotiz        datetime,
@w_valor_cotiz        money

  
select @w_sp_name = 'sp_convenios_garantia'


if @t_trn <> 19988 begin

   select @w_msg = 'La Transaccion no esta Asignada '

   exec cobis..sp_cerror
   @t_debug    = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_msg      = @w_msg,
   @i_num      = 1903001
   return 1903001

end


-- Validacion Tipo de Garantia
if @i_tipo_garantia is not null begin
   
   if exists (select 1 from cob_custodia..cu_tipo_custodia
              where tc_tipo          = @i_tipo_garantia
              and   tc_tipo_superior is null)
   begin

      select @w_msg = 'El Tipo de Garantia escogido es de tipo Superior. No puede asociar Convenio '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end
end


-- Calcular Cotizacion al dia de proceso

select @i_moneda = isnull(@i_moneda, 0)

if @i_moneda <> 0 begin

   select @w_fecha_proceso = max(ct_fecha)
   from cob_conta..cb_cotizacion
   where ct_moneda = @i_moneda

   select @w_valor_cotiz = ct_valor 
   from cob_conta..cb_cotizacion
   where ct_moneda = @i_moneda
   and   ct_fecha  = @w_fecha_proceso

end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @i_monto = isnull(@i_monto, 0)
select @i_monto_aumento = isnull(@i_monto_aumento, 0)

/* Busqueda de Datos */

if @i_operacion in ('U', 'S')
begin

   select tipo = cg_tipo_garantia
   into #temporal
   from cu_convenios_garantia
   where cg_estado = 'V'

   --Buscar Desembolsados en el dia de proceso para sumar a valor utilizado
   select @w_valor_utilizado = sum(cu_valor_actual)
   from cob_cartera..ca_operacion(nolock), cob_credito..cr_tramite(nolock), cob_credito..cr_gar_propuesta(nolock),
        cob_custodia..cu_custodia(nolock)
   where op_estado    = 1
   and   op_fecha_liq = @w_fecha_proceso
   and   op_tramite   = tr_tramite
   and   tr_estado    not in ('Z')
   and   op_tramite   = gp_tramite
   and   gp_garantia  = cu_codigo_externo
   and   cu_tipo      in (select tipo from #temporal)
   and   gp_procesado is null

   --Buscar Aprobados No Desembolsados en el dia de proceso para sumar a valor reservado
   select @w_valor_reservado = sum(cu_valor_actual)
   from cob_cartera..ca_operacion(nolock), cob_credito..cr_tramite(nolock), cob_credito..cr_gar_propuesta(nolock),
        cob_custodia..cu_custodia(nolock)
   where op_estado    in (99,0)
   and   op_tramite   = tr_tramite
   and   tr_estado    not in ('Z')
   and   op_tramite   = gp_tramite
   and   gp_garantia  = cu_codigo_externo
   and   gp_fecha_mod = @w_fecha_proceso
   and   cu_tipo      in (select tipo from #temporal)
   and   gp_procesado is null

   select @w_valor_utilizado = isnull(@w_valor_utilizado, 0)
   select @w_valor_reservado = isnull(@w_valor_reservado, 0)

end


if @i_operacion = 'I'  begin

   if exists(select 1 
             from cu_convenios_garantia
             where cg_tipo_garantia   = @i_tipo_garantia
             and   cg_codigo_convenio = @i_codigo_convenio
             and   cg_estado          = 'V')
   begin

      select @w_msg = 'El Convenio para el tipo de garantia YA Existe '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

   select @w_valor_cotiz      = isnull(@w_valor_cotiz, 1)
   select @i_monto_mn         = @i_monto * @w_valor_cotiz
   select @i_monto_aumento    = @i_monto_aumento
   select @i_saldo_disponible = @i_monto
   select @i_valor_utilizado  = 0.00
   select @i_valor_reservado  = 0.00

   insert into cu_convenios_garantia
   values (
   @i_tipo_garantia,    @i_codigo_convenio,    @i_moneda,
   @i_monto,            @i_monto_mn,           @i_monto_aumento,
   @i_saldo_disponible, @i_valor_utilizado,    @i_valor_reservado,
   @i_estado
   ) 
         
   if @@error <> 0 begin

      select @w_msg = 'Error Insertando Convenios <cu_convenios_garantia> '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

end


if @i_operacion = 'U'  begin

   if not exists(select 1 
                 from cu_convenios_garantia
                 where cg_tipo_garantia   = @i_tipo_garantia
                 and   cg_codigo_convenio = @i_codigo_convenio
                 and   cg_estado          = 'V')
   begin

      select @w_msg = 'El Convenio a ser Actualizado para la garantia NO Existe '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

   select @w_valor_cotiz      = isnull(@w_valor_cotiz, 1)

   --Actualizar la Informacion
   update cu_convenios_garantia set
   cg_monto            = cg_monto + @i_monto_aumento,
   cg_monto_mn         = cg_monto_mn + (@i_monto_aumento * @w_valor_cotiz),
   cg_monto_aumento    = @i_monto_aumento,
   cg_saldo_disponible = cg_saldo_disponible + @i_monto_aumento,
   cg_estado           = @i_estado
   where cg_tipo_garantia   = @i_tipo_garantia
   and   cg_codigo_convenio = @i_codigo_convenio
   and   cg_estado          = 'V'
         
   if @@error <> 0 begin

      select @w_msg = 'Error Actualizando Convenios <cu_convenios_garantia> '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end
end


if @i_operacion = 'D'  begin


   if not exists(select 1 
                 from cu_convenios_garantia
                 where cg_tipo_garantia   = @i_tipo_garantia
                 and   cg_codigo_convenio = @i_codigo_convenio)
   begin

      select @w_msg = 'El Convenio a Eliminar para el Tipo de Garantia No Existe '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

   if exists(select 1 
             from cu_convenios_garantia
             where cg_tipo_garantia   = @i_tipo_garantia
             and   cg_codigo_convenio = @i_codigo_convenio
             and   cg_estado          = 'V')
   begin

      select @w_msg = 'El Convenio a Eliminar para el Tipo de Garantia es Vigente. No Se Puede Eliminar '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1903001

      return 1903001
   end

   delete cu_convenios_garantia
   where cg_tipo_garantia   = @i_tipo_garantia
   and   cg_codigo_convenio = @i_codigo_convenio
   and   cg_estado          <> 'V'
         
   if @@error <> 0 begin

      select @w_msg = 'Error Eliminando Convenios <cu_convenios_garantia> '

      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_msg      = @w_msg,
      @i_num      = 1907001

      return 1907001
   end

end


if @i_operacion = 'X'  begin

   --Mapear Valor
   select @w_valor_cotiz

end



if @i_operacion = 'S'  begin

   if @w_valor_cotiz is null begin

      select @w_valor_cotiz = 1

      select @i_moneda = cg_moneda
      from cob_custodia..cu_convenios_garantia
      where cg_estado = 'V'
      and   cg_moneda <> 0

      select @w_fecha_proceso = max(ct_fecha)
      from cob_conta..cb_cotizacion
      where ct_moneda = @i_moneda

      select @w_valor_cotiz = ct_valor 
      from cob_conta..cb_cotizacion
      where ct_moneda = @i_moneda
      and   ct_fecha  = @w_fecha_proceso

   end

   set rowcount 10

   select 
   'TIPO GARANTIA   '             = cg_tipo_garantia,
   'DESCRIPCION TIPO GARANTIA'    = (select top 1 tc_descripcion from cob_custodia..cu_tipo_custodia where tc_tipo = x.cg_tipo_garantia),
   'CODIGO CONVENIO '             = cg_codigo_convenio,
   'DESCRIPCION CODIGO CONVENIO'  = (select top 1 b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cu_entidad_convenio' and a.codigo = b.tabla and b.codigo = x.cg_codigo_convenio),
   'MONEDA'                       = cg_moneda,
   'DESCRIPCION MONEDA'           = (select top 1 mo_descripcion from cobis..cl_moneda where mo_moneda = x.cg_moneda),
   'MONTO                      '  = cg_monto,
   'MONTO MONEDA LOCAL         '  = cg_monto_mn, 
   'AUMENTO DE MONTO           '  = cg_monto_aumento,
   'SALDO DISPONIBLE           '  = (((cg_saldo_disponible * @w_valor_cotiz) - @w_valor_utilizado - @w_valor_reservado) / @w_valor_cotiz),
   'VALOR UTILIZADO            '  = cg_valor_utilizado + @w_valor_utilizado,
   'VALOR RESERVADO            '  = cg_valor_reservado + @w_valor_reservado,
   'ESTADO   '                    = cg_estado,
   'DESCRIPCION ESTADO  '         = (select top 1 b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_estado_ser' and a.codigo = b.tabla and b.codigo = x.cg_estado)
   from cu_convenios_garantia x
   where cg_tipo_garantia    >= @i_tipo_garantia
   and   cg_codigo_convenio  >  @i_codigo_convenio
   order by cg_tipo_garantia, cg_codigo_convenio

   set rowcount 0

end


if @i_operacion = 'V'  begin

   select 
   cg_tipo_garantia,
   (select top 1 tc_descripcion from cob_custodia..cu_tipo_custodia where tc_tipo = @i_tipo_garantia),
   cg_codigo_convenio,
   (select top 1 b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cu_entidad_convenio' and a.codigo = b.tabla and b.codigo = @i_codigo_convenio),
   cg_moneda,
   (select top 1 mo_descripcion from cobis..cl_moneda where mo_moneda = x.cg_moneda),
   cg_monto,
   cg_monto_mn,
   cg_monto_aumento,
   (cg_saldo_disponible * @w_valor_cotiz) - @w_valor_utilizado - @w_valor_reservado,
   cg_valor_utilizado + @w_valor_utilizado,
   cg_valor_reservado + @w_valor_reservado,
   cg_estado,
   (select top 1 b.valor from cobis..cl_tabla a, cobis..cl_catalogo b where a.tabla = 'cl_estado_ser' and a.codigo = b.tabla and b.codigo = x.cg_estado)
   from cu_convenios_garantia x
   where cg_tipo_garantia    = @i_tipo_garantia
   and   cg_codigo_convenio  = @i_codigo_convenio
   order by cg_codigo_convenio

end

return 0

go




/*

exec sp_convenios_garantia
@t_trn = 19988,
@i_operacion = 'S',
@i_tipo_garantia = '',
@i_codigo_convenio = ''

select * from cu_convenios_garantia

*/