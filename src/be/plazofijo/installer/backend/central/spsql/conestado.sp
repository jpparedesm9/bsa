/*sp_conestado*/
/************************************************************************/
/*  Archivo               : conestado.sp                                */
/*  Stored procedure      : sp_conestado                                */
/*  Base de datos         : cobis                                       */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : Gustavo Calderon                            */
/*  Fecha de documentacion: 31/Oct/94                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                          PROPOSITO                                   */
/*  Este programa procesa las transacciones de SEARCH a la tabla        */
/*  de operaciones 'pf_operacion' por su estado.                        */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa procesa las transacciones de SEARCH a la tabla        */
/*  de operaciones 'pf_operacion' por su estado.                        */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */   
/*      03-Nov-94  Ricardo Valencia   Creacion                          */
/*      10-Nov-98  Dolores Guerrero   Control de beneficiario, nivel 'T'*/
/*      12-Feb-01  Gabriela Estupinan Se separa por cada nivel un sp    */
/*                                    para utilizar tabla temporal      */
/*      16-Oct-01  Memito Saborio     Incluye campo para verificaci=n   */
/*                                    de custodias.                     */
/*      08-Ago-16  Nidia Silva        Se adapta a query de busqueda Fie */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_conestado') is not null
   drop proc sp_conestado
go

create proc sp_conestado (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_nivel                char(2)         = NULL, /* F, O,C,R,T */
@i_valor                varchar(256)    = '%',
@i_retenciones          char(1)         = '%',
@i_garantias            char(1)         = '%',
@i_propietario          catalogo        = '%',
@i_tipo_deposito        catalogo        = '%',
@i_tipo_plazo           catalogo        = '%',
@i_tipo_monto           catalogo        = '%',
@i_accion_sgte          catalogo        = '%',
@i_plazo_cont           catalogo        = '%',
@i_num_banco            cuenta          = '0',
@i_operacionpf          int             = 0,
@i_modo                 int             = 0,
@i_opcion               tinyint         = 1,    --1 por fecha valor / 2 por fecha ven
@i_fecha1               datetime        = null,
@i_fecha2               datetime        = null,
@i_fechai1              datetime        = null,
@i_fechai2              datetime        = null,
@i_moneda               varchar(2)      = '%',
@i_estado               catalogo        = '%',
@i_titular              varchar(40)     = '%',
@i_formato_fecha        int             = 101,
@i_custodia             char(1)         = '%',
@i_bloqueo_legal        char(1)         = '%', --GAR GB-DP00027
@i_nuevas               char(1)         = '%', --GAR GB-DP00027 ('Nuevas', 'Renovadas')
@i_desmaterializa       char(1)         = 'N',
@i_deceval              char(1)         = 'N', 
@o_consulta             varchar(2)             out)
with encryption
as
declare
   @w_sp_name              varchar(32),
   @w_num_reg              int,            -- GES 01/29/2001
   @w_criterio             varchar(3000),
   @w_criterio_c           varchar(3000),
   @w_columnas             varchar(1500),
   @w_tablas               varchar(250),
   @w_ordenamiento         varchar(250),    -- I. 1222 CVA Set-05-05
   @w_str_oficina          varchar(1000)    -- string de oficinas segun ambito del s_user que realiza la consulta ---




select @w_sp_name = 'sp_conestado'

-----------------------------------------------------
-- VERIFICAR CODIGO DE TRANSACCION PARA SEARCH  
-----------------------------------------------------
if  @t_trn <> 14702
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA SEARCH NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end
  

-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS COLUMNAS
-------------------------------------------------------------------------
select @w_columnas = 'select op_num_banco,                           
                             op_descripcion,
                             op_monto, 
                             op_tasa,
                             op_num_dias,
                             op_total_int_estimado - op_total_int_pagados,
                             op_int_ganado - op_int_pagados, 
                             op_estado,
                             convert(varchar(10),op_fecha_valor,' + convert(varchar(3),@i_formato_fecha) + '),' + 
                             'convert(varchar(10),op_fecha_ven,' + convert(varchar(3),@i_formato_fecha) + '),' + 
                             'op_telefono,
                             op_oficial_principal,
                             op_ente, 
                             op_operacion,
                             op_toperacion,
                             op_moneda,
                             op_total_int_pagados,
                             case op_estado when ' + '''' + 'CAN'+ '''' + ' then op_total_int_retenido else op_total_retencion end,
                             op_ced_ruc,' +
                            'convert(varchar(10),op_fecha_cancela,' + convert(varchar(3),@i_formato_fecha) + '), op_oficina,' +
                            'op_desmaterializa '

-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS TABLAS
-------------------------------------------------------------------------
select @w_tablas= ' from pf_operacion '
-------------------------------------------------------------------------
-- ARMA LA CADENA CON LOS CRITERIOS
-------------------------------------------------------------------------
------------------------------------
if @i_opcion = 1 
   select @w_criterio     = ' where  op_fecha_valor between ' + '''' + convert(varchar,@i_fechai1,101) + '''' + ' and ' + '''' + convert(varchar,@i_fechai2,101) +  '''' + ' '  + 
                            '   and (op_fecha_valor > ' + '''' + convert(varchar,@i_fechai1,101) + '''' + ' or (op_fecha_valor = ' + '''' + convert(varchar,@i_fechai1,101) + '''' + ' and op_num_banco > ' + '''' + @i_num_banco +  '''' + ')) ', 
          @w_ordenamiento = ' order by op_fecha_valor, op_num_banco '

else
   select @w_criterio     = ' where  op_fecha_ven between ' + '''' + convert(varchar,@i_fecha1,101) + '''' + ' and ' + '''' + convert(varchar,@i_fecha2,101) +  '''' + ' '  + 
                            '   and (op_fecha_ven > ' + '''' + convert(varchar,@i_fecha1,101) + '''' + ' or (op_fecha_ven = ' + '''' + convert(varchar,@i_fecha1,101) + '''' + ' and op_num_banco > ' + '''' + @i_num_banco +  '''' + ')) ', 
          @w_ordenamiento = ' order by op_fecha_ven, op_num_banco '

-----------
-- NIVELES
-----------
if @i_nivel  = 'F' 
begin
   select @w_criterio = @w_criterio + '  and op_oficial_principal = ''' + @i_valor+ ''''
end
else if @i_nivel = 'O'
begin
   select @w_criterio = @w_criterio + '  and op_oficina in (' + @i_valor + ')'
end
else if @i_nivel  = 'Z' -- Zona
begin
   select @w_tablas = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + ' and op_oficina = of_oficina ' + ' and of_zona = ' + @i_valor 
end
else if @i_nivel  = 'R' -- Territorial/Regional
begin
   select @w_tablas = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + ' and op_oficina = of_oficina ' + ' and of_regional = ' + @i_valor 
end
else if @i_nivel  = 'C' 
begin
   select @w_tablas   = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + ' and op_oficina = of_oficina and of_ciudad = ' + @i_valor
end

----------------------
-- RESTO DE CRITERIOS
----------------------
if @i_tipo_deposito <> '%'
begin 
   select @w_criterio = @w_criterio + '  and op_toperacion = ''' + @i_tipo_deposito + ''''
end
if @i_propietario <> '%'
begin
   select @w_tablas = @w_tablas + ' ,pf_beneficiario'
   select @w_criterio = @w_criterio + '  and op_operacion   = be_operacion' + 
                                      '  and be_ente        = '+ @i_propietario +
                                      '  and be_estado_xren = ''N''' +
                                      '  and be_estado      = ''I''' +
                                      '  and be_tipo        = ''T'''
end


if @i_estado <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_estado = ''' + @i_estado + ''''
end
if @i_moneda <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_moneda = ' + @i_moneda
end
if @i_tipo_plazo <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_tipo_plazo = ''' + @i_tipo_plazo + ''''
end
if @i_tipo_monto <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_tipo_monto = ''' + @i_tipo_monto + ''''
end
if @i_accion_sgte <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_accion_sgte = ''' + @i_accion_sgte + ''''
end
if @i_garantias <> '%'
begin
   select @w_criterio = @w_criterio + '  and isnull(op_pignorado, ''N'') = ''' + @i_garantias + ''''
end
if @i_retenciones <> '%'
begin
   select @w_criterio = @w_criterio + '  and isnull(op_retenido, ''N'') = ''' + @i_retenciones + ''''
end
if @i_custodia <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_custodia = ''' + @i_custodia + ''''
end
if @i_bloqueo_legal <> '%'
begin
   select @w_criterio = @w_criterio + '  and isnull(op_bloqueo_legal,''N'') = ''' + @i_bloqueo_legal + ''''
end
if @i_titular <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_descripcion like ''' + @i_titular + ''''
end
if @i_plazo_cont <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_plazo_cont like ' + '''' + @i_plazo_cont + ''''
end

if @i_nuevas = 'N' --GAR GB-DP00067
begin
   --------------------------------------
   --Operaciones que NO est n RENOVADAS
   --------------------------------------
   select @w_criterio = @w_criterio + ' and (op_num_prorroga = 0 or op_operacion not in (select re_operacion from pf_renovacion where re_estado = ''A'')) '

end
 
if @i_nuevas = 'R'
begin
   --------------------------------------
   --Operaciones que SI estan RENOVADAS
   --------------------------------------
   select @w_criterio = @w_criterio + ' and op_renovaciones > 0 '                                   
   select @w_criterio = @w_criterio + ' and op_renovada  = ' + '''' + 'S' +  ''''
   select @w_criterio = @w_criterio + ' and op_estado  in (' + '''' + 'ACT' +  '''' + ',' + '''' + 'VEN' +  '''' + ')'

end

if @i_nuevas = 'P'
begin
   --------------------------------------
   --Operaciones que SI estan Prorrogadas
   --------------------------------------
   select @w_criterio = @w_criterio + ' and op_num_prorroga > 0 '
   select @w_criterio = @w_criterio + ' and op_estado  in (' + '''' + 'ACT' +  '''' + ',' + '''' + 'VEN' +  '''' + ')'

end

if @i_nuevas = 'E'
begin
   --------------------------------------
   --Operaciones que SI estan Endosadas
   --------------------------------------
   select @w_criterio = @w_criterio + ' and op_operacion in (select distinct en_operacion from cob_pfijo..pf_endoso_prop) '
end

---------------------------------
-- Operaciones Desmaterializadas
---------------------------------
 if @i_desmaterializa <> '%'
    select @w_criterio = @w_criterio + 'and op_desmaterializa = ''' + @i_desmaterializa + ''''
  

 if @i_deceval = 'S'
    select @w_criterio =  @w_criterio + ' and (op_isin is not null or op_fungible is not null)'

-------------------------------------------------------------------------
-- EJECUCION DE LA CONSULTA
-------------------------------------------------------------------------
select @o_consulta = '15'
set rowcount 15
execute (@w_columnas + @w_tablas + @w_criterio + @w_ordenamiento)

return 0   
go