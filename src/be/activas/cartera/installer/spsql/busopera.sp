/************************************************************************/
/*   Archivo:                 busopera.sp                               */
/*   Stored procedure:        sp_buscar_operaciones                     */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:            Fabian de la Torre                        */
/*   Fecha de Documentacion:  Ene. 98                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Buscar operaciones deacuerdo a criterio                            */
/* 15/May/2019        AGO        Req 113305                             */
/* 11/Sep/2019        DCU        Req.125021                             */
/* 23/Ago/2021        ACH        ERR.#166635-pintar op. padres del ente */
/* 11/May/2022        KVI        Err.#178974-agregar ca_estado          */
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_buscar_operaciones')
   drop proc sp_buscar_operaciones
go

create proc sp_buscar_operaciones
   @s_user              login       = null,
   @i_banco             cuenta      = null,
   @i_tramite           int         = null,
   @i_cliente           int         = null,
   @i_grupo             int         = null,
   @i_oficina           smallint    = null,
   @i_moneda            tinyint     = null,
   @i_oficial           int         = null,
   @i_fecha_ini         datetime    = null,
   @i_toperacion        catalogo    = null,
   @i_estado            descripcion = null,
   @i_migrada           cuenta      = null,
   @i_siguiente         int         = 0,
   @i_formato_fecha     int         = null,
   @i_condicion_est     tinyint     = null,
   @i_num_documento     varchar(30) = NULL,
   @i_web               char(1)     = 'N',
   @i_grupal            char(1)     = 'N',
   @i_categoria	        int	        = null,
   @i_resumen_grupal    char(1)     = 'N'

as
declare
   @w_sp_name        varchar(32),
   @w_opcion         int,
   @w_error          int,
   @w_estado         int,
   @w_redbusca       int,
   @w_oficina_matriz int,
   @w_truta          tinyint,
   @w_regional       SMALLINT,
   @w_en_ente        INT,
   @w_opruta         VARCHAR(10),
   @w_msg            varchar(100),
   @w_grupo          int,
   @w_producto       int
   
declare @w_estados_excluidos table (estado     int)
declare @w_integrantes       table (ente       int)
declare @w_prestamos         table (operacion  int)
declare @w_estados           table (banco cuenta, estado tinyint)
declare @w_estados_grupo     table (grupo int, operacion_grupal int, estado int)

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_abreviatura = 'CCA'
set transaction isolation level read uncommitted

--VALIDA MODULO FUERA DE LINEA
if exists(select 1 from cobis..cl_pro_moneda where pm_producto = @w_producto and  pm_estado  <> 'V')
begin
   select @w_error = 6900070
   select @w_msg   = 'PRODUCTO NO HABILITADO'
   goto ERROR   
end


-- CAPTURA NOMBRE DE STORED PROCEDURE
select @w_sp_name = 'sp_buscar_operaciones'

SELECT @w_opruta = '' 
select @w_oficina_matriz = 900

if  @i_resumen_grupal = 'S' select @i_grupal = 'S'

if @i_categoria = 2 begin 
   insert into @w_estados_excluidos
   select es_codigo
   from cob_cartera..ca_estado
   where es_descripcion <> 'NO VIGENTE'
end

if @i_categoria = 3 begin
   insert into @w_estados_excluidos
   select es_codigo
   from cob_cartera..ca_estado
   where es_descripcion = 'NO VIGENTE'
end
 

if @i_categoria = 4 begin
   insert into @w_estados_excluidos
   select es_codigo
   from cob_cartera..ca_estado
   where es_descripcion in ('NO VIGENTE', 'CANCELADO')
end

if @i_categoria =5 begin
   insert into @w_estados_excluidos
   select es_codigo
   from cob_cartera..ca_estado
   where es_descripcion = 'CANCELADO'	
end



if @i_condicion_est is null  select @i_condicion_est = 0
  
-- CONVERTIR EL ESTADO DESCRIPCION A ESTADO NUMERO
if @i_estado is not null begin

   IF ISNUMERIC(@i_estado) = 1
         select @w_estado = es_codigo from cob_cartera..ca_estado where  es_codigo = convert(INT,@i_estado)
   ELSE 
         select @w_estado = es_codigo
         from   cob_cartera..ca_estado
         where  es_descripcion = @i_estado

end

if @i_siguiente <> 0 goto SIGUIENTE



-- BUSCAR OPCION DE BUSQUEDA
select @w_opcion = 1000

if @i_migrada                                  is not null  select @w_opcion = 7
if @i_oficina                                  is not null  select @w_opcion = 6
if @i_oficial                                  is not null  select @w_opcion = 5
if @i_grupo                                    is not null  select @w_opcion = 4
if @i_num_documento is not null or @i_cliente  is not null  select @w_opcion = 3
if @i_tramite                                  is not null  select @w_opcion = 2
if @i_banco                                    is not null  select @w_opcion = 1

if @w_opcion = 1000 begin --ESTO ES PARA QUE SIEMPRE HAYA UN CAMPO PRIMARIO 
   select @w_error  = 708199
   select @w_msg    = 'ERROR- PARA BUSCAR INGRESE YA SEA: EL BANCO, EL TRAMITE, EL CLIENTE/GRUPO, OFICINA O EL NRO MIGRADO'
   goto ERROR
end


--Cambio por web
if @i_num_documento is not null select @i_cliente = convert(int,@i_num_documento)


-- BUSQUEDAS DE NUMERO DE OPERACIONES
if @w_opcion = 1 begin -- NRO OBLIGACION

   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_banco in (select ci_prestamo from ca_ciclo where ci_prestamo = @i_banco)

   end else begin


      if exists(select 1 from cob_cartera..ca_det_ciclo
      where dc_referencia_grupal = @i_banco)
      begin

         insert into @w_prestamos
         select op_operacion
         from cob_cartera..ca_operacion
         where op_operacion in (select dc_operacion from ca_det_ciclo where dc_referencia_grupal = @i_banco)
         and   op_estado not in (select estado from @w_estados_excluidos)

      end else begin

         insert into @w_prestamos
         select op_operacion
         from cob_cartera..ca_operacion
         where op_banco = @i_banco
         and   op_estado not in (select estado from @w_estados_excluidos)

      end

   end

end


if @w_opcion = 2 begin -- TRAMITE

   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_banco in (select ci_prestamo from ca_ciclo where ci_tramite = @i_tramite)
	  
   end else begin


      if exists(select 1 from ca_ciclo where ci_tramite = @i_tramite)
      begin

         insert into @w_prestamos
         select op_operacion
         from ca_operacion
         where op_operacion in ( select dc_operacion from   ca_ciclo, ca_det_ciclo
                                 where  ci_grupo = dc_grupo
                                 and    ci_ciclo = dc_ciclo_grupo
                                 and    ci_prestamo = dc_referencia_grupal 
                                 and    ci_tramite  = @i_tramite)
         and op_estado not in (select estado from @w_estados_excluidos)

      end else begin

         insert into @w_prestamos
         select op_operacion
         from cob_cartera..ca_operacion
         where op_tramite = @i_tramite
         and op_estado not in (select estado from @w_estados_excluidos)

      end

   end



end


if @w_opcion = 3 begin -- por cliente

   if @i_grupal = 'S' begin

      select @w_grupo = 0
	  select @w_grupo = cg_grupo
      from cobis..cl_cliente_grupo
      where cg_ente = @i_cliente

      select ci_prestamo--caso#166635
      into #w_banco_padre
      from ca_ciclo, cob_credito..cr_tramite_grupal 
      where ci_prestamo = tg_referencia_grupal
      and ci_grupo = @w_grupo
      and tg_cliente = @i_cliente
	  and tg_participa_ciclo = 'S'
	  and tg_monto > 0
      
      insert into @w_prestamos
      select op_operacion
      from ca_operacion	  
      where op_banco in (select ci_prestamo from #w_banco_padre)--caso#166635
      --where op_banco in (select ci_prestamo from ca_ciclo where ci_grupo = @w_grupo)

   end else begin
 
      insert into @w_prestamos
      select op_operacion
      from cob_cartera..ca_operacion
      where op_cliente = @i_cliente
      and op_estado not in (select estado from @w_estados_excluidos)
	  and op_banco not in (select tg_referencia_grupal from cob_credito..cr_tramite_grupal where tg_grupo = @i_cliente) --Exclusión de operaciones que correspondan a un grupo con el mismo código

   end


end


if @w_opcion = 4 begin --por grupo
	  
   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_banco in (select ci_prestamo from ca_ciclo where ci_grupo = @i_grupo)

   end else begin
 
      insert into @w_prestamos
      select op_operacion
      from cob_cartera..ca_operacion
      where op_operacion in (select dc_operacion from ca_det_ciclo where dc_grupo = @i_grupo) 
      and op_estado not in (select estado from @w_estados_excluidos)

   end

end


if @w_opcion = 5 begin --por oficial

   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_oficial = @i_oficial
      and   op_banco in (select ci_prestamo from ca_ciclo)

   end else begin
 
      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_oficial = @i_oficial
      and   op_banco not in (select ci_prestamo from ca_ciclo)
      and op_estado not in (select estado from @w_estados_excluidos)

   end


end  



if @w_opcion = 6 begin --por oficina

   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_oficina = @i_oficina
      and   op_banco in (select ci_prestamo from ca_ciclo)

   end else begin
 
      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_oficina = @i_oficina
      and   op_banco not in (select ci_prestamo from ca_ciclo)
      and op_estado not in (select estado from @w_estados_excluidos)

   end

end  

if @w_opcion = 7 begin --por migrada

   if @i_grupal = 'S' begin

      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_migrada = @i_migrada
      and   op_banco in (select ci_prestamo from ca_ciclo)

   end else begin
 
      insert into @w_prestamos
      select op_operacion
      from ca_operacion
      where op_migrada = @i_migrada
      and   op_banco not in (select ci_prestamo from ca_ciclo)
      and op_estado not in (select estado from @w_estados_excluidos)

   end

end  

if @i_categoria = 6 begin
   delete @w_prestamos
   from  ca_operacion
   where op_operacion = operacion
   and   op_toperacion <> 'REVOLVENTE'
end


if @i_grupal = 'S' begin

   insert into @w_estados_grupo
   select ci_grupo, ci_operacion, min(op_estado)
   from  @w_prestamos, ca_det_ciclo, ca_ciclo, ca_operacion
   where operacion    = ci_operacion
   and   ci_grupo     = dc_grupo
   and   ci_ciclo     = dc_ciclo_grupo
   and   ci_prestamo  = dc_referencia_grupal
   and   dc_operacion = op_operacion
   group by ci_grupo, ci_operacion
   
   delete @w_prestamos
   from  ca_ciclo, @w_estados_grupo
   where ci_grupo     = grupo
   and   ci_operacion = operacion_grupal 
   and   ci_operacion = operacion    
   and   estado in (select estado from @w_estados_excluidos)
   
end


-- LIMPIAR TABLA TEMPORAL
delete ca_buscar_operaciones_tmp where  bot_usuario = @s_user

insert into ca_buscar_operaciones_tmp
select @s_user,
op_operacion,       op_moneda,              op_fecha_liq,
op_lin_credito,     op_estado,              op_migrada,
op_toperacion,      op_oficina,             op_oficial,
op_cliente,         op_tramite,             op_banco,
op_fecha_reajuste,  op_tipo,                op_reajuste_especial,
op_reajustable,     op_monto,               op_monto_aprobado,
op_anterior,        op_fecha_ult_proceso,   op_codigo_externo,
op_ref_exterior,    '',
op_num_comex,
op_tipo_linea,      op_nombre,              op_fecha_fin
from   ca_operacion, @w_prestamos
where op_operacion   = operacion

if (@i_grupal = 'S') 
begin
    insert into @w_estados
    select 
    banco  = dc_referencia_grupal, 
    estado = min(op_estado)
    from ca_operacion, ca_det_ciclo, ca_estado --Err.#178974 
    where op_operacion = dc_operacion
    and dc_referencia_grupal in (select bot_banco from ca_buscar_operaciones_tmp where bot_usuario = @s_user)
    and op_estado = es_codigo --Err.#178974 
    and es_procesa = 'S'      --Err.#178974 
    group by dc_referencia_grupal
    
    if not exists(select 1 from @w_estados) --Err.#178974 
    begin
      insert into @w_estados
      select 
      banco  = dc_referencia_grupal, 
      estado = min(op_estado)
      from ca_operacion, ca_det_ciclo
      where op_operacion = dc_operacion
      and dc_referencia_grupal in (select bot_banco from ca_buscar_operaciones_tmp where bot_usuario = @s_user)
      group by dc_referencia_grupal
    end
    
    update ca_buscar_operaciones_tmp
    set bot_estado = estado
    from @w_estados
    where bot_banco = banco
end



-- RETORNAR DATOS A FRONT END

SIGUIENTE:

if @i_oficina = @w_oficina_matriz  select @i_oficina = null


IF @i_web = 'N' set rowcount 20
else set rowcount 0


select 
'Lin.Credito    '   = substring(bot_toperacion,1,30),
'Moneda'            = bot_moneda,
'No.Operacion'      = bot_banco,
'Monto Operacion'   = convert(float, bot_monto),
'Cliente'           = substring(bot_nombre,1,30),
'Desembolso'        = convert(varchar(16),bot_fecha_ini, @i_formato_fecha),
'Vencimiento'       = convert(varchar(10),bot_fecha_fin, @i_formato_fecha),
'Reg/Oficial'       = bot_oficial,
'Oficina'           = bot_oficina,
'Cup.Crédito'       = bot_monto,
'Op.Migrada'        = substring(bot_migrada,1,20),
'Op.Anterior'       = substring(bot_anterior,1,20),
'Estado'            = substring(es_descripcion,1,20), 
'Tramite'           = convert(varchar(13),bot_tramite),
'Cod.Cli'           = bot_cliente,
'Secuencial'        = bot_operacion,
'Reaj.Especial'     = bot_reajuste_especial,
'Ref.Redescont'     = bot_nro_red,
'Clase Oper.'       = bot_tipo/*,
'Num. Documento'    = bot_num_ident*/
from   ca_buscar_operaciones_tmp, ca_estado
where  bot_usuario = @s_user
and    (bot_moneda         = @i_moneda         or @i_moneda         is null)
and    (bot_fecha_ini      = @i_fecha_ini      or @i_fecha_ini      is null)
and    (bot_estado         = @w_estado         or @w_estado         is null)
and    (bot_migrada        = @i_migrada        or @i_migrada        is null)
and    (bot_toperacion     = @i_toperacion     or @i_toperacion     is null)
and    (bot_oficina        = @i_oficina        or @i_oficina        is null)
and    (bot_oficial        = @i_oficial        or @i_oficial        is null)
and    (bot_tramite        = @i_tramite        or @i_tramite        is null)
and    (bot_banco          = @i_banco          or @i_banco          is null) 
and    bot_estado = es_codigo
and    bot_estado not in (98,99) -- Menos Operaciones de Credito y Comext
and    bot_operacion > @i_siguiente
order  by bot_operacion

if @@rowcount = 0 begin
   select @w_error = 1
   select @w_msg   = 'NO EXISTEN MAS REGISTROS'
   goto ERROR
end

set rowcount 0

return 0

ERROR:

set rowcount 0

IF @i_web = 'N' begin
 

   select 
   'Lin.Crédito    '   = substring(bot_toperacion,1,30),
   'Moneda'            = bot_moneda,
   'No.Operación'      = bot_banco,
   'Monto Operación'   = convert(float, bot_monto),
   'Cliente'           = substring(bot_nombre,1,30),
   'Desembolso'        = convert(varchar(16),bot_fecha_ini, @i_formato_fecha),
   'Vencimiento'       = convert(varchar(10),bot_fecha_fin, @i_formato_fecha),
   'Reg/Oficial'       = bot_oficial,
   'Oficina'           = bot_oficina,
   'Cup.Crédito'       = bot_monto,
   'Op.Migrada'        = substring(bot_migrada,1,20),
   'Op.Anterior'       = substring(bot_anterior,1,20),
   'Estado'            = substring(es_descripcion,1,20), 
   'Trámite'           = convert(varchar(13),bot_tramite),
   'Cod.Cli'           = bot_cliente,
   'Secuencial'        = bot_operacion,
   'Reaj.Especial'     = bot_reajuste_especial,
   'Ref.Redescont'     = bot_nro_red,
   'Clase Oper.'       = bot_tipo
   from   ca_buscar_operaciones_tmp, ca_estado
   where  1=2

   return 1


END 


 exec cobis..sp_cerror 
 @t_debug = 'N', 
 @t_file  = null,
 @t_from  = 'sp_buscar_operaciones',
 @i_num   = 701172,
 @i_msg   = @w_msg

 return @w_error 


GO

