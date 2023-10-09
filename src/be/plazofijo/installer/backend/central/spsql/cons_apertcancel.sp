/************************************************************************/
/*      Archivo:                conapertcancel.sp                       */
/*      Stored procedure:       sp_cons_apertcancel                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 01/Abr/05                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de SEARCH a la tabla    */
/*      de operaciones 'pf_operacion' para hallar informacion de        */
/*      las aperturas y cancelaciones de las operacions                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      01-Abr-05  Gabriela Arboleda  Creacion                          */
/*      14-Nov-05  Luis Im            Busqueda por oficial apertura, of.*/
/*                                    y tipo dep. al momento de apertura*/
/*      05/Jun-06  Clotilde Vargas    Correci¢n de inclusi¢n por estado */
/*                                    de cancelaci¢n                    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_cons_apertcancel') is not null
   drop proc sp_cons_apertcancel
go

create proc sp_cons_apertcancel (
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
@i_valor                varchar(15)     = '%',
@i_propietario          catalogo        = '%',
@i_tipo_deposito        catalogo        = '%',
@i_tipo_plazo           catalogo        = '%',
@i_tipo_monto           catalogo        = '%',
@i_accion_sgte          catalogo        = '%',
@i_num_banco            cuenta          = '0',
@i_fecha1               datetime        = null,
@i_fecha2               datetime        = null,
@i_moneda               varchar(2)      = '%',
@i_estado               varchar(30)     = '%',
@i_titular              varchar(40)     = '%',
@i_formato_fecha        int             = 0,
@i_tipo_consulta        char(1),
@i_modo                 int             = 0, 
@o_consulta             varchar(4500) out)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_criterio             varchar(5000),
@w_criterio_c           varchar(3000),  
@w_columnas             varchar(1000),
@w_tablas               varchar(500),
@w_transacciones        varchar(30),
@w_desc_fecha           varchar(30),
@w_ordenamiento         varchar(500)

select @w_sp_name = 'sp_cons_apertcancel'

if @i_fecha2 = '01/01/1900'
   select @i_fecha2 = '01/01/2200'

if @t_debug = 'S'
begin
  exec cobis..sp_begin_debug @t_file = @t_file
  select 
            '/** Stored Procedure **/ ' = @w_sp_name,
            s_ssn                       = @s_ssn,
            s_user                      = @s_user,
            s_term                      = @s_term,
            s_date                      = @s_date,
            s_srv                       = @s_srv,
            s_lsrv                      = @s_lsrv,
            s_ofi                       = @s_ofi,
            s_rol                       = @s_rol,
            t_trn                       = @t_trn,
            t_file                      = @t_file,
            t_from                      = @t_from,
            i_estado                    = @i_estado
  exec cobis..sp_end_debug
end
-----------------------------------------------------
-- VERIFICAR CODIGO DE TRANSACCION PARA SEARCH  
-----------------------------------------------------

if  @t_trn <> 14555
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
-- VERIFICA SI ES APERTURA O ES CANCELACION
-------------------------------------------------------------------------
select @w_ordenamiento = ' order by op_num_banco '

if @i_tipo_consulta = 'A' --Apertura
begin
   select @w_transacciones = ' (14901, 14953) ' 
   select @w_desc_fecha = 'op_fecha_ingreso'
   if @i_fecha1 is not null 
      select @w_ordenamiento = ' order by op_num_banco '
end
else
begin -- Cancelacion
   select @w_transacciones = '14903'
   select @w_desc_fecha = ' op_fecha_cancela '
   if @i_fecha1 is not null 
      select @w_ordenamiento = ' order by op_num_banco '
end
-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS COLUMNAS
-------------------------------------------------------------------------

if @i_tipo_consulta = 'A'                    --LIM 16/DIC/2005
   select @w_columnas='select distinct ''op_num_banco''      = op_num_banco,'+--'select distinct ''No._de_DPF''      = op_num_banco,'+
                      '       ''Titular''         = oh_descripcion,'+      
                      '       ''Oficial''         = op_oficial_apertura,'     
else
   select @w_columnas='select distinct ''op_num_banco''      = op_num_banco,'+--'select distinct ''No._de_DPF''      = op_num_banco,'+
                      '       ''Titular''         = op_descripcion,'+
                      '       ''Oficial''         = op_oficial_principal,'
                      
if @i_tipo_consulta = 'A'
begin
   --Apertura
   --select @w_columnas= @w_columnas + ' ''Fecha_Aper/Canc'' = convert(varchar(10),op_fecha_ingreso, '+convert(varchar,@i_formato_fecha)+'),'
   select @w_columnas= @w_columnas + ' ''op_fecha_ingreso'' = convert(varchar(10),op_fecha_ingreso, '+convert(varchar,@i_formato_fecha)+'),'
end
else
begin
   --Cancelacion
   --select @w_columnas= @w_columnas + ' ''Fecha_Aper/Canc'' = convert(varchar(10),op_fecha_cancela, '+convert(varchar,@i_formato_fecha)+'),'
   select @w_columnas= @w_columnas + '''' + 'op_fecha_cancela' + '''' + ' = convert(varchar(10),op_fecha_cancela, '+convert(varchar,@i_formato_fecha)+'),'
end
--select @w_columnas= @w_columnas + '       'Fecha Valor Aper'= convert(varchar(10),op_fecha_valor, '+convert(varchar,@i_formato_fecha)+'),'+
/******LIM 16/DIC/2005 ****/
if @i_tipo_consulta = 'A'
   select @w_columnas= @w_columnas + '       ''Fecha Valor Aper''= convert(varchar(10),oh_fecha_valor, '+convert(varchar,@i_formato_fecha)+'),'+   --LIM 15/DIC/2005
                                     '       ''Monto Aper/Canc'' = hi_valor,'+
                                     '       ''Plazo''           = oh_num_dias,'+
                                     '       ''Tasa''            = oh_tasa,'+
                                     '       ''Observaciones''   = oh_instruccion_especial,'+
                                     '       ''Login Usuario''   = hi_funcionario'
else
   select @w_columnas= @w_columnas + '       ''Fecha Valor Aper''= convert(varchar(10),op_fecha_valor, '+convert(varchar,@i_formato_fecha)+'),'+   
                                     '       ''Monto Aper/Canc'' = hi_valor,'+
                                     '       ''Plazo''           = op_num_dias,'+
                                     '       ''Tasa''            = op_tasa,'+
                                     '       ''Observaciones''   = in_instruccion,'+
                                     '       ''Login Usuario''   = hi_funcionario'


-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS TABLAS
-------------------------------------------------------------------------

if @i_tipo_consulta = 'A'                       --LIM 16/DIC/2005
   select @w_tablas= ' into #resultados from cob_pfijo..pf_operacion, cob_pfijo..pf_historia, cob_pfijo..pf_operacion_his'      --LIM 15/DIC/2005
else
   select @w_tablas= ' into #resultados from cob_pfijo..pf_operacion left outer join cob_pfijo..pf_instruccion on op_operacion = in_operacion' +
                     ' inner join cob_pfijo..pf_historia on op_operacion   = hi_operacion' + 
                     ' inner join cob_pfijo..pf_cancelacion on ca_operacion   = op_operacion and  hi_funcionario = ca_funcionario'
-------------------------------------------------------------------------
-- ARMA LA CADENA CON LOS CRITERIOS
-------------------------------------------------------------------------
-----------
-- GENERAL
-----------
if @i_fecha1 is not null and @i_modo = 1
begin
   if @i_tipo_consulta = 'A'  
   select @w_criterio = ' where  op_num_banco   > ''' + @i_num_banco + '''' +
                           '   and  op_operacion   = oh_operacion'+     --LIM 15/DIC/2005
                           '   and  op_operacion   = hi_operacion'+
                           '   and  hi_trn_code   in ' + @w_transacciones       --LIM 10/ENE/2005        
   else
      select @w_criterio = ' where  op_num_banco   > ''' + @i_num_banco + '''' +
                           '   and  hi_trn_code    = ' + @w_transacciones +
                           '   and  ca_estado      = ''A'' ' 
                             
end
else
   if @i_tipo_consulta = 'A'
      select @w_criterio = ' where  op_num_banco   > ''' + @i_num_banco + '''' +
                           '   and  op_operacion   = oh_operacion'+     --LIM 15/DIC/2005
                           '   and  op_operacion   = hi_operacion'+
                           '   and  hi_trn_code   in ' + @w_transacciones       --LIM 10/ENE/2005        
   else
      select @w_criterio = ' where  op_num_banco   > ''' + @i_num_banco + '''' +
                           '   and  hi_trn_code    = ' + @w_transacciones +
                           '   and  ca_estado      = ''A'' ' 
                                                    
-----------------------------------
-- FECHA DE APERTURA CANCELACION
-----------------------------------
if @i_fecha1 IS NOT NULL
begin
   if @i_fecha2 IS NOT NULL
   begin
      if @i_modo = 0
          select @w_criterio = @w_criterio + '  and ' + @w_desc_fecha + ' between ''' + convert(varchar,@i_fecha1,101) + ''' and ''' + convert(varchar,@i_fecha2,101)+ ''''
      else
      select @w_criterio = @w_criterio + '  and ' + @w_desc_fecha + ' between ''' + convert(varchar,@i_fecha1,101) + ''' and ''' + convert(varchar,@i_fecha2,101)+ ''''
   end
   else
      select @w_criterio = @w_criterio + '  and ' + @w_desc_fecha + ' >= ''' + convert(varchar,@i_fecha1,101) + ''''
end
else
begin
   if @i_fecha2 IS NOT NULL
      select @w_criterio = @w_criterio + '  and ' + @w_desc_fecha + ' <= ''' + convert(varchar,@i_fecha2,101) + ''''
end

-----------
-- NIVELES
-----------
if @i_nivel  = 'F' 
begin
   if @i_tipo_consulta = 'A'                             --LIM 16/DIC/2005
      select @w_criterio = @w_criterio + '  and op_oficial_apertura = ''' + @i_valor + ''''      --LIM 14/NOV/2005 Busqueda por oficial principal de la Apertura del dpf
   else
      select @w_criterio = @w_criterio + '  and op_oficial_principal = ''' + @i_valor + ''''
end
else if @i_nivel  = 'O' 
begin
   if @i_tipo_consulta = 'A'   
      select @w_criterio = @w_criterio + '  and op_oficina_apertura = ' + @i_valor        --LIM 14/NOV/2005 Busqueda por oficina de la apertura del dpf
   else
      select @w_criterio = @w_criterio + '  and op_oficina = ' + @i_valor
end
else if @i_nivel  = 'C' 
begin
   if @i_tipo_consulta = 'A'   
   begin   
      select @w_tablas = @w_tablas + ', cobis..cl_oficina '                 --LIM 15/DIC/2005
      select @w_criterio = @w_criterio + '  and of_ciudad  = ' + @i_valor +
                                         '  and oh_oficina = of_oficina '                  --LIM 15/DIC/2005
   end   
   else
   begin
      select @w_tablas = @w_tablas + ' inner join cobis..cl_oficina on op_oficina = of_oficina '                  --LIM 16/DIC/2005
      select @w_criterio = @w_criterio + '  and of_ciudad  = ' + @i_valor + ' ' 
   end   
end


----------------------
-- RESTO DE CRITERIOS
----------------------
if @i_tipo_deposito <> '%'
begin 
   
   if @i_tipo_consulta = 'A'
      select @w_criterio = @w_criterio + '  and op_toperacion_apertura = ''' + @i_tipo_deposito + ''''      --LIM 14/NOV/2005 Busqueda por tipo de deposito de la apertura
   else
      select @w_criterio = @w_criterio + '  and op_toperacion = ''' + @i_tipo_deposito + ''''
   
end
if @i_propietario <> '%'
begin
   select @w_tablas = @w_tablas + ' ,cob_pfijo..pf_beneficiario'
   select @w_criterio = @w_criterio + '  and op_operacion   = be_operacion' + 
                                      '  and be_ente        = ' + @i_propietario + 
                                      '  and be_estado_xren = ''N''' +
                                      '  and be_estado      = ''I''' + 
                                      '  and be_tipo        = ''T'''
end
if @i_estado <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_estado = ''' + @i_estado + ''''
end
else
begin
   if @i_tipo_consulta = 'A' --Apertura
   begin
      select @i_estado = ' (''ACT'',''XACT'',''CAN'') '
      select @w_criterio = @w_criterio + '  and op_estado in  ' + @i_estado 
   end
end


if @i_moneda <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_moneda = ' + @i_moneda
end
if @i_tipo_plazo <> '%'
begin
   
   if @i_tipo_consulta = 'A'                                   --LIM 16/NOV/2005
      select @w_criterio = @w_criterio + '  and op_tipo_plazo_apertura = ''' + @i_tipo_plazo + ''''    --LIM 15/NOV/2005
   else
      select @w_criterio = @w_criterio + '  and op_tipo_plazo = ''' + @i_tipo_plazo + ''''
end
if @i_tipo_monto <> '%'
begin
   
   if @i_tipo_consulta = 'A'
      select @w_criterio = @w_criterio + '  and op_tipo_monto_apertura = ''' + @i_tipo_monto + ''''    --LIM 15/NOV/2005
   else
      select @w_criterio = @w_criterio + '  and op_tipo_monto = ''' + @i_tipo_monto + ''''
end
if @i_accion_sgte <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_accion_sgte = ''' + @i_accion_sgte + ''''
end
if @i_titular <> '%'
begin
   
   if @i_tipo_consulta = 'A'
      select @w_criterio = @w_criterio + '  and oh_descripcion like ''' + @i_titular + ''''         --LIM 15/DIC/2005
   else
      select @w_criterio = @w_criterio + '  and op_descripcion like ''' + @i_titular + ''''
end


-------------------------------------------------------------------------
-- EJECUCION DE LA CONSULTA
-------------------------------------------------------------------------
set rowcount 20

execute (@w_columnas + @w_tablas + @w_criterio+  @w_ordenamiento + ' select * from #resultados ') -- + @w_ordenamiento)

select @o_consulta = @w_criterio

set rowcount 0

return 0   
go
