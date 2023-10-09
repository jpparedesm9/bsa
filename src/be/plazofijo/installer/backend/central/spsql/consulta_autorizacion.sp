/************************************************************************/
/*      Archivo:                consaut.sp                               */
/*      Stored procedure:       sp_consulta_autorizacion                */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 18/Sep/95                               */
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
/*      de operaciones 'pf_autorizacion por tipo de autorizacion        */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*                                                                      */
/*      Set-5-05  Clotilde Vargas     Cambio para querys din micos      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_autorizacion')
   drop proc sp_consulta_autorizacion
go

create proc sp_consulta_autorizacion (
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
      @i_valor                varchar(15)= '%',
      @i_moneda               varchar(2) = '%',
      @i_propietario          catalogo = '%',
      @i_tipo_deposito        catalogo  = '%',
      @i_tipo_plazo           catalogo  = '%',
      @i_tipo_monto           catalogo  = '%',
      @i_accion_sgte          catalogo  = '%', --XCA 04/15/98
      @i_num_banco            cuenta    = '0',
      @i_modo                 int       = 0,
      @i_fecha1                   datetime  = '01/01/1900',
      @i_fecha2                   datetime  = '01/01/2200',
      @i_tautorizacion        catalogo = '%',
      @o_consulta             varchar(4500) out
)
with encryption
as
declare
  @w_sp_name              varchar(32),
  @w_criterio             varchar(3000), --I. 1222 CVA Set-05-05
  @w_columnas             varchar(3000), --I. 1222 CVA Set-05-05
  @w_tablas               varchar(250),  --I. 1222 CVA Set-05-05
  @w_ordenamiento   varchar(250)   --I. 1222 CVA Set-05-05

select @w_sp_name = 'sp_consulta_autorizacion'

if @i_fecha2 = '01/01/1900'
   select @i_fecha2 = '01/01/2200'


if @t_debug = 'S'
begin
  exec cobis..sp_begin_debug @t_file = @t_file
  select '/** Stored Procedure **/ ' = @w_sp_name,
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
            i_tautorizacion             = @i_tautorizacion
  exec cobis..sp_end_debug
end

/**  VERIFICAR CODIGO DE TRANSACCION PARA SEARCH  **/
if  @t_trn <> 14703
begin
  /**  ERROR : CODIGO DE TRANSACCION PARA SEARCH NO VALIDO  **/
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end

select b.codigo,b.valor 
into #tmp_autorizacion
from cobis..cl_tabla a,cobis..cl_catalogo b
where a.tabla = 'pf_tipo_aut'
  and a.codigo = b.tabla

-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS COLUMNAS
-------------------------------------------------------------------------
select @w_columnas='select distinct ''Cuenta''              = op_num_banco,
                           ''Tipo de DPF''         = td_descripcion,
                           ''Autorizacion''        = valor,
                           ''Monto''               = op_monto,
                           ''Autorizado por''      = au_autoriza,
                           ''Tasa dias vencidos''  = au_adicional,
                           ''No. de DPF''          = op_operacion,
                           ''aplicado por''        = au_oficial,
                           ''Tipo Operacion''      = op_toperacion,
                           ''Plazo''               = op_num_dias'


-------------------------------------------------------------------------
-- ARMA LA CADENA CON LAS TABLAS
-------------------------------------------------------------------------
select @w_tablas= ' from pf_autorizacion, pf_operacion a , #tmp_autorizacion, pf_tipo_deposito '
select @w_ordenamiento = ' order by op_num_banco' --I. 1222 CVA Set-05-05

-------------------------------------------------------------------------
-- ARMA LA CADENA CON LOS CRITERIOS
-------------------------------------------------------------------------
-----------
-- GENERAL
-----------
select @w_criterio =' where  op_num_banco > ''' + @i_num_banco + ''' and op_operacion = au_operacion and codigo = au_tautorizacion  and td_mnemonico = op_toperacion'

-------------------------
-- FECHA DE AUTORIZACION
-------------------------
if @i_fecha1 IS NOT NULL
begin
   if @i_fecha2 IS NOT NULL
      select @w_criterio = @w_criterio + '  and  au_fecha_crea  between ''' + convert(varchar,@i_fecha1,101) + ''' and ''' + convert(varchar,@i_fecha2,101)+ ''''
   else
      select @w_criterio = @w_criterio + '  and  au_fecha_crea >= ''' + convert(varchar,@i_fecha1,101) + ''''

   select @w_ordenamiento = ' order by op_num_banco ' --I. 1222 CVA Set-05-05
end
else
begin
   if @i_fecha2 IS NOT NULL
      select @w_criterio = @w_criterio + '  and  au_fecha_crea <= ''' + convert(varchar,@i_fecha2,101) + ''''
end

-----------
-- NIVELES
-----------
if @i_nivel  = 'F' 
begin
   select @w_criterio = @w_criterio + '  and au_autoriza = ''' + @i_valor + ''''
end
else if @i_nivel  = 'O' 
begin
   select @w_criterio = @w_criterio + '  and au_oficina = ' + @i_valor
end
else if @i_nivel  = 'C' 
begin
   select @w_tablas = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + '  and of_ciudad = ' + @i_valor + ' and au_oficina = of_oficina '
end


----------------------
-- RESTO DE CRITERIOS
----------------------
if @i_tipo_deposito <> '%'
begin    
   select @w_criterio = @w_criterio + '  and op_toperacion = ''' + @i_tipo_deposito + ''''
end
if @i_tautorizacion <> '%'
begin
   select @w_criterio = @w_criterio + '  and au_tautorizacion = ''' + @i_tautorizacion + ''''
end
if @i_propietario <> '%'
begin
   select @w_tablas = @w_tablas + ' ,pf_beneficiario '
   select @w_criterio = @w_criterio + '  and op_operacion   = be_operacion' +
                                      '  and be_ente        = '+ @i_propietario + 
                                      '  and be_estado_xren = ''N''' +
                                      '  and be_tipo        = ''T''' +
                                      '  and be_estado      = ''I'''
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


-------------------------------------------------------------------------
-- EJECUCION DE LA CONSULTA
-------------------------------------------------------------------------
set rowcount 20

execute (@w_columnas+@w_tablas+@w_criterio+@w_ordenamiento)
select @o_consulta = @w_criterio

set rowcount 0

return 0   
go

