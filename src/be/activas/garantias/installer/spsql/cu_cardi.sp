/************************************************************************/
/*      Archivo:                cu_cardi.sp                             */
/*      Stored procedure:       sp_cdiaria_custodia                     */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Silvia Portilla S.                      */
/*      Fecha de escritura:     10/02/2006                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes  exclusivos  para el  Ecuador  de la   */
/*      'NCR CORPORATION'.                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite la carga diaria de las garantias a la     */
/*      tabla para la central de custodia                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      09/Mayo/2006    Silvia Portilla S.      Emision Inicial         */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_cdiaria_custodia')
   drop proc sp_cdiaria_custodia
go

create proc sp_cdiaria_custodia
   @i_fecha   datetime
as
declare
   @w_oficina        smallint,
   @w_tipo_cte       varchar(30),
   @w_tipo_tcr       varchar(30),
   @w_item           smallint,
   @w_codigo_externo varchar(64),
   @w_ofi_gar        smallint, 
   @w_descripcion    varchar(255),
   @w_tipo           descripcion,
   @w_codigo_gar     varchar(64),
   @w_cliente        int,
   @w_banco          char(24),
   @w_item_c         smallint,
   @w_regional       smallint,
   @w_error          int,
   @w_sp_name        varchar(32),  /* nombre stored proc*/
   @w_return         int

select @w_tipo_cte = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'COGCTE'
set transaction isolation level read uncommitted

if @w_tipo_cte is null
begin
   print 'No existe parametro definido'
   return 1
end

select @w_tipo_tcr = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'COGTCR'
set transaction isolation level read uncommitted

if @w_tipo_tcr is null
begin
   print 'No existe parametro definido'
   return 1
end

declare
   cur_operaciones cursor
   for select op_banco, cu_codigo_externo, cu_descripcion, cu_tipo, cu_oficina
       from   cob_cartera..ca_operacion, cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia
       where  op_tramite   = gp_tramite
       and    gp_garantia  = cu_codigo_externo
       and    cu_estado    = 'V'
       and    op_fecha_liq = @i_fecha
       and    op_operacion > 0
       and    op_banco like '725%'
       and    op_estado    = 1
       union
       select '', cu_codigo_externo, cu_descripcion, cu_tipo, cu_oficina
       from   cob_custodia..cu_custodia C
       where  cu_tipo          in (@w_tipo_cte,@w_tipo_tcr)
       and    cu_custodia      > 0
       and    cu_fecha_ingreso = @i_fecha
       and    cu_estado        = 'V'
   for read only
   
open cur_operaciones

fetch cur_operaciones
into  @w_banco, @w_codigo_externo, @w_descripcion, @w_tipo, @w_oficina

while @@fetch_status = 0
begin
   if @@fetch_status = -1
   begin
      close cur_regional
      deallocate cur_regional
      select @w_error = 21000
      goto ERROR
   end
   
   --CODIGO EXTERNO DE LA GARANTIA
   select @w_codigo_gar = ''
   
   if @w_tipo in (@w_tipo_cte,@w_tipo_tcr)
   begin
      if @w_tipo = @w_tipo_cte
         select @w_item = 3, @w_item_c = 2
      else
         select @w_item = 2, @w_item_c = 3
      
      select @w_codigo_gar = ic_valor_item
      from   cob_custodia..cu_item_custodia
      where  ic_codigo_externo = @w_codigo_externo
      and    ic_item             = @w_item
      
      select @w_banco = isnull(ic_valor_item,'')
      from  cob_custodia..cu_item_custodia
      where ic_codigo_externo = @w_codigo_externo
      and   ic_item             = @w_item_c
   end
   
   --CLIENTE DE LA GARANTIA
   select @w_cliente = cg_ente 
   from   cob_custodia..cu_cliente_garantia 
   where  cg_codigo_externo = @w_codigo_externo 
   and    cg_tipo_garante   = 'J'
   
   select @w_descripcion = isnull(@w_descripcion,'')
   
   if not exists(select 1 from cu_garantias_custodia where gc_codigo_externo = @w_codigo_externo and gc_operacion = @w_banco)
   begin
      select @w_regional = 0
      
      select @w_regional = of_regional
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina
      
      insert into cu_garantias_custodia
            (gc_codigo_externo,  gc_tipo,             gc_cliente,       gc_operacion,
             gc_depend_origen,   gc_depend_destino,   gc_estado,        gc_dependencia,
             gc_usuario,         gc_oficina,          gc_fecha_ingreso, gc_descripcion,        
             gc_motivo,          gc_fecha_modif,      gc_documento,     gc_regional)
      values(@w_codigo_externo,  @w_tipo,             @w_cliente,       @w_banco,
             'B',                '',                  'GPE',            '',
             'garbatch',         @w_oficina,          @i_fecha,         @w_descripcion,
             '',                 @i_fecha,            @w_codigo_gar,    @w_regional)
   end
   
   exec @w_return = cob_custodia..sp_historial_custodia
        @i_codigo_externo = @w_codigo_externo, 
        @s_date           = @i_fecha, 
        @i_estado         = 'GPE', 
        @i_dep_origen     = 'B',
        @i_dep_destino    = '',
        @s_user           = 'garbatch',
        @i_comentario     = '',
        @i_dependencia    = ''
   
   fetch cur_operaciones
   into  @w_banco, @w_codigo_externo, @w_descripcion, @w_tipo, @w_oficina
end --CURSOR DE LAS OPERACIONES

close cur_operaciones
deallocate cur_operaciones

insert into cu_cabecera_custodia
values(@i_fecha, 'D')

return 0

ERROR:
exec cobis..sp_cerror
     @t_debug  = 'N',
     @t_file   = null,
     @t_from   = @w_sp_name,
     @i_num    = @w_error
return @w_error

go

