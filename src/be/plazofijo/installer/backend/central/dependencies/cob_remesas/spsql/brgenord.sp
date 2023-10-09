/* **********************************************************************/
/*      Archivo:                brgenord.sp                             */
/*      Stored procedure:       sp_genera_orden                         */
/*      Base de datos:          cob_remesas                             */
/*      Producto:               Cobis Branch                            */
/*      Disenado por:           Alexandra Correa R                      */
/*      Fecha de escritura:     03-09-2009                              */
/* **********************************************************************/
/*                            IMPORTANTE                                */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes  exclusivos  para el  Ecuador  de la     */
/*    'NCR CORPORATION'.                                                */
/*    Su  uso no autorizado  queda expresamente  prohibido asi como     */
/*    cualquier   alteracion  o  agregado  hecho por  alguno de sus     */
/*    usuarios   sin el debido  consentimiento  por  escrito  de la     */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/* **********************************************************************/
/*                             PROPOSITO                                */
/*    Inserta ordenes de pago(egreso) / cobro(ingreso)                  */
/* **********************************************************************/

use cob_remesas
go
if exists(select 1 from sysobjects where name = 'sp_genera_orden')
    drop proc sp_genera_orden
go
create proc sp_genera_orden
(
   @s_date        datetime,
   @s_user        login,
   @s_ofi         smallint    = null,
   @i_ofi         smallint    = null,
   @i_operacion   char(1),
   @i_causa       varchar(10) = null,
   @i_ente        int         = 0,
   @i_cedruc      varchar(30) = null,
   @i_valor       money       = 0,
   @i_tipo        char(1)     = '', --'C' -> Orden de Cobro/Ingreso, 'P' -> Orden de Pago/Egreso
   @i_idorden     int         = 0, 
   @i_ref1        int         = 0,
   @i_ref2        int         = 0,
   @i_ref3        varchar(30) = '',
   @i_debug       char(1)     = 'N',
   @i_interfaz    char(1)     = 'N',
   @o_idorden     int         = null out,
   @o_pendiente   char(1)     = null out,
   @o_oficina     smallint    = null out,
   @o_valor       money       = null out
)
as
declare 
    @w_return     int,
    @w_sp_name    varchar(30),
    @w_tipodoc    varchar(10),
    @w_cedruc     varchar(30),
    @w_error      int,
    @w_trn        smallint,
    @w_orden      int,
    @w_estado     char(1),
    @w_programa   varchar(40),
    @w_ref1       int,
    @w_ref2       int,
    @w_ref3       varchar(30),
    @w_tipo       char(1),
    @w_debug      char(1),
    @w_tabla      smallint,  
    @w_tabla_oi   smallint, 
    @w_tabla_oe   smallint
    
select @w_sp_name = 'sp_genera_orden'

select @w_debug = 'N'

if @i_operacion = 'I'
begin
   if @i_valor = 0 or @i_tipo = ''
   begin
      --Campos deben tener valor
      select @w_error = 2600100
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   
   if @i_tipo not in ('C', 'P')
   begin
      --Tipo de Orden Errada
      select @w_error = 2600101
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   
   if @i_tipo = 'C'
      select @w_trn = 32
   else
      select @w_trn = 86

   select @w_tipodoc = en_tipo_ced,
          @w_cedruc  = en_ced_ruc
   from   cobis..cl_ente
   where  en_ente = @i_ente
         
   if exists (select 1 from cob_remesas..re_tran_contable
              where tc_producto  = 3
              and   tc_tipo_tran = @w_trn
              and   tc_causa_org = @i_causa)
   begin
      if @i_ente = 0
      begin
         --Cliente es obligatorio
         select @w_error = 2600102
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
      
      if @w_tipodoc is null or @w_cedruc is null
      begin
         --Cliente debe existir
         select @w_error = 208126
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
   end
   
   exec @w_return = cobis..sp_cseqnos
   @i_tabla     = 're_orden_caja',
   @o_siguiente = @w_orden out
   
   if @w_return <> 0
   begin
      --Error generando secuencial de la orden
      select @w_error = 355004
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   
   insert into cob_remesas..re_orden_caja (
   oc_idorden,   oc_cliente,   oc_tipodoc,   oc_numdoc,
   oc_tipo,      oc_causa,     oc_valor,     oc_ref1,
   oc_ref2,      oc_ref3,      oc_estado,    oc_fecha_reg,
   oc_usuario,   oc_oficina)
   values   (
   @w_orden,     @i_ente,      @w_tipodoc,   @w_cedruc,
   @i_tipo,      @i_causa,     @i_valor,     @i_ref1,
   @i_ref2,      @i_ref3,      'I',          @s_date,
   @s_user,      @i_ofi)
   
   if @@error <> 0
   begin
      --Error insertando orden
      select @w_error = 2600107
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   select @o_idorden =  @w_orden
   return 0
end   


if @i_operacion = 'S'
begin

   select  @w_tabla_oi = codigo
   from    cobis..cl_tabla
   where   tabla = 'cc_causa_oioe_caja'
 
   select  @w_tabla_oe = codigo
   from    cobis..cl_tabla
   where   tabla = 'cc_causa_oe_caja'

   if @i_tipo = 'C'
      select @w_tabla = @w_tabla_oi
   else
      select @w_tabla = @w_tabla_oe
   
     select 
   'ID ORDEN  ' = oc_idorden,
   'CLIENTE   ' = oc_cliente,
   'ID CLIENTE' = substring(en_ced_ruc,1,14),
   'NOMBRE    ' = substring ((ltrim(rtrim(en_nombre)) + ' ' + ltrim(rtrim(p_p_apellido))+ ' ' + ltrim(rtrim(p_s_apellido))),1,50),
   'CAUSA     ' = oc_causa,
   'DESC CAUSA' = substring (valor,1,40),
   'VALOR     ' = oc_valor,
   'REFERENCIA' = case isnull(oc_ref3, '')
                     when '' then convert(varchar(10),oc_ref1)
                     else oc_ref3
                  end
   from  cob_remesas..re_orden_caja o,
         cobis..cl_ente,
         cobis..cl_catalogo
   where oc_cliente = en_ente
   and   oc_tipo    = @i_tipo
   and   codigo     = o.oc_causa
   and   ((oc_cliente = @i_ente    and isnull(@i_ente,0) > 0) or
          (oc_numdoc  = @i_cedruc  and isnull(@i_cedruc, '') <> '') or
          (oc_idorden = @i_idorden and isnull(@i_idorden,0) > 0))
   and   tabla      = @w_tabla
   and   oc_estado  = 'I'
   and   estado     = 'V'
   order by oc_idorden

   return 0
end

if @i_operacion = 'H'
begin

   select  @w_tabla_oi = codigo
   from    cobis..cl_tabla
   where   tabla = 'cc_causa_oioe_caja'
 
   select  @w_tabla_oe = codigo
   from    cobis..cl_tabla
   where   tabla = 'cc_causa_oe_caja'

   if @i_tipo = 'C'
      select @w_tabla = @w_tabla_oi
   else
      select @w_tabla = @w_tabla_oe
   
     select 
   'ID ORDEN  ' = oc_idorden,
   'CLIENTE   ' = oc_cliente,
   'ID CLIENTE' = substring(en_ced_ruc,1,14),
   'NOMBRE    ' = substring ((ltrim(rtrim(en_nombre)) + ' ' + ltrim(rtrim(p_p_apellido))+ ' ' + ltrim(rtrim(p_s_apellido))),1,50),
   'CAUSA     ' = oc_causa,
   'DESC CAUSA' = substring (valor,1,40),
   'VALOR     ' = oc_valor,
   'REFERENCIA' = case isnull(oc_ref3, '')
                     when '' then convert(varchar(10),oc_ref1)
                     else oc_ref3
                  end
   from  cob_remesas..re_orden_caja o,
         cobis..cl_ente,
         cobis..cl_catalogo
   where oc_cliente = en_ente
   and   oc_tipo    = @i_tipo
   and   codigo     = o.oc_causa
   and   oc_numdoc  = @i_cedruc
   and   oc_ref3    = @i_ref3    
   and   tabla      = @w_tabla
   and   oc_estado  = 'I'
   and   estado     = 'V'
   order by oc_idorden
   
   return 0
end

if @i_operacion = 'V'
begin
   select @o_pendiente = 'N'
   
   select
   @o_pendiente = 'S'
   from  cob_remesas..re_orden_caja o,
         cobis..cl_ente
   where oc_cliente = en_ente
   and   oc_tipo    = @i_tipo
   and   oc_causa   = @i_causa
   and   ((oc_cliente = @i_ente    and isnull(@i_ente,0) > 0) or
          (oc_numdoc  = @i_cedruc  and isnull(@i_cedruc, '') <> ''))
   and   oc_estado  = 'I'
   
   if @w_debug = 'S'
      print @i_tipo + '-' + @i_causa + '-' + @i_cedruc
   
   return 0
end


if isnull(@i_idorden,0) = 0 and @i_operacion <> 'V'
begin
   --Numero de orden es obligatorio
   select @w_error = 2600103
   if @i_interfaz = 'S'
      return @w_error 
   else
      goto ERROR
end

select 
@w_estado  = oc_estado,
@w_ref1    = oc_ref1,
@w_ref2    = oc_ref2,
@w_ref3    = oc_ref3,
@o_oficina = oc_oficina,
@o_valor   = oc_valor
from  cob_remesas..re_orden_caja
where oc_idorden = @i_idorden

if @w_estado is null
begin
   --Orden a procesar no existe
   select @w_error = 2600104
   if @i_interfaz = 'S'
      return @w_error 
   else
      goto ERROR
end

if @i_operacion = 'A'
begin
   
   if @w_estado = 'A'
   begin
      --Orden ya anulada
      select @w_error = 2600108
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end

   if isnull(@w_estado, '')  = 'E'
   begin
      --Orden en estado no procesable
      select @w_error = 2600105
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end

   
   update cob_remesas..re_orden_caja set
   oc_estado         = 'A',
   oc_fecha_cambio   = getdate()
   where  oc_idorden = @i_idorden
   
   if @@error <> 0  
   begin
      --Error al actualizar Orden
      select @w_error = 2600106
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
end

/* Ejecutar orden de pago/compra */
if @i_operacion = 'E' 
begin
   if isnull(@w_estado, '')  <> 'I'
   begin
      --Orden en estado no procesable
      select @w_error = 2600105
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   
   if @i_tipo = 'P'
      select @w_tipo = 'E'
   else
      select @w_tipo = 'I'
   
   select @w_programa = ci_programa
   from   cob_cuentas..cc_causa_ingegr
   where  ci_causal = @i_causa
   and    ci_tipo   = @w_tipo
   
   if @w_debug = 'S'
      print '@i_causa: ' + @i_causa + ' @i_tipo: ' + @i_tipo + ' @w_programa: ' + @w_programa
   
   if isnull(@w_programa, '') <> ''
   begin
      select @w_return = null
      
      exec @w_return = @w_programa
      @s_date      = @s_date,
      @s_user      = @s_user,
      @s_ofi       = @s_ofi,
      @i_operacion = @i_operacion,
      @i_idorden   = @i_idorden,
      @i_ref1      = @w_ref1,
      @i_ref2      = @w_ref2,
      @i_ref3      = @w_ref3
      
      if @@error <> 0 or @w_return <> 0
      begin
         select @w_error = isnull(@w_return, 205000)
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
   end
   
   update cob_remesas..re_orden_caja set
   oc_estado         = @i_operacion,
   oc_fecha_cambio   = getdate(),
   oc_usuar_cambio   = @s_user
   where  oc_idorden = @i_idorden
   
   if @@error <> 0  
   begin
      --Error al actualizar Orden
      select @w_error = 2600106
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
end

/* Reversar orden de pago/compra ejecutada*/
if @i_operacion = 'R'
begin
   if isnull(@w_estado, '')  <> 'E'
   begin
      --Orden en estado no procesable
      select @w_error = 2600105
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end
   if @i_tipo = 'P'
      select @w_tipo = 'E'
   else
      select @w_tipo = 'I'
   
   select @w_programa = ci_programa
   from   cob_cuentas..cc_causa_ingegr
   where  ci_causal = @i_causa
   and    ci_tipo   = @w_tipo
   
   if isnull(@w_programa, '') <> ''
   begin
      exec @w_return = @w_programa
      @s_date      = @s_date,
      @s_user      = @s_user,
      @s_ofi       = @s_ofi,
      @i_operacion = @i_operacion,
      @i_idorden   = @i_idorden,
      @i_ref1      = @w_ref1,
      @i_ref2      = @w_ref2,
      @i_ref3      = @w_ref3
      
      if @w_return <> 0
      begin
         select @w_error = @w_return
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
   end
   
   update cob_remesas..re_orden_caja set
   oc_estado         = 'I',
   oc_fecha_cambio   = getdate(),
   oc_usuar_cambio   = @s_user
   where  oc_idorden = @i_idorden
   
   if @@error <> 0  
   begin
      --Error al actualizar Orden
      select @w_error = 2600106
      if @i_interfaz = 'S'
         return @w_error 
      else
         goto ERROR
   end

end

return 0
ERROR:

if @w_error < 32000
   select @w_error = 205000
exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error
return @w_error
