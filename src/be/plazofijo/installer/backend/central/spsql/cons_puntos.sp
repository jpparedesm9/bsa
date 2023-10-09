/************************************************************************/
/*      Archivo:                cons_puntos.sp                          */
/*      Stored procedure:       sp_cons_puntos                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gustavo Calderon                        */
/*      Fecha de documentacion: 31/Oct/94                               */
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
/*      de operaciones pf_operacion por su puntos.                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      05-Sep-05  C. Vargas          Cambio para queries dinamicos     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_puntos')
  drop proc sp_cons_puntos
go

create proc sp_cons_puntos (
       @s_ssn                  int             = null,
       @s_user                 login           = null,
       @s_term                 varchar(30)     = null,
       @s_date                 datetime        = null,
       @s_srv                  varchar(30)     = null,
       @s_lsrv                 varchar(30)     = null,
       @s_ofi                  smallint        = null,
       @s_rol                  smallint        = null,
       @t_debug                char(1)         = 'N',
       @t_file                 varchar(10)     = null,
       @t_from                 varchar(32)     = null,
       @t_trn                  smallint        = null,
       @i_nivel                char(2)         = null, /* F, O,C,R,T */
       @i_valor                varchar(15)     = '%',        
       @i_propietario          varchar(64)     = '%',
       @i_tipo_deposito        varchar(10)     = '%',
       @i_tipo_plazo           varchar(10)     = '%',
       @i_tipo_monto           varchar(10)     = '%',
       @i_accion_sgte          varchar(10)     = '%',
       @i_num_banco            varchar(20)     = '0',
       @i_modo                 int             = 0,
       @i_moneda               varchar(2)      = '%',
       @i_fecha1               datetime        = '01/01/1900',
       @i_fecha2               datetime        = '01/01/9999',
       @i_formato_fecha        int             = 103,
       @i_estado               varchar(10)     = '%',
       @o_consulta             varchar(2)        out
)
with encryption
as
declare @w_sp_name             varchar(32),
        @c_tautorizacion       varchar(10), 
        @w_criterio            varchar(3000), --I. 1222 CVA Set-05-05
        @w_columnas            varchar(3000), 
        @w_tablas              varchar(500),  
        @w_ordenamiento        varchar(500)   


select @c_tautorizacion = 'ASP'

select @w_sp_name = 'sp_cons_puntos'

if @i_fecha2 = '01/01/1900'
   select @i_fecha2 = '01/01/9999'


if  @t_trn <> 14704
begin
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
select @w_columnas = 'select      ''No. de DPF''   = op_num_banco,
                        ''Tipo de DPF''          = td_descripcion,                            
                        ''Tasa''                 = au_tasa,
                        ''Monto''                = op_monto,
                        ''Puntos''               = au_spread,
                        ''Sec. DPF''             = op_operacion,
                        ''Tasa Base''            = au_tasa_base,
                        ''Spread''               = au_spread,
                        ''Titular''              = op_descripcion,
                        ''Saldo Disponible''     = isnull(isnull(op_monto,0) - isnull(op_monto_blq,0) - isnull(op_monto_pgdo,0) - isnull(op_monto_blqlegal,0),0),
                        ''Login Usuario''        = au_autoriza,
                        ''Tipo Operacion''       = op_toperacion, 
                        ''Fecha Autoriza''       = convert(varchar(10),au_fecha_crea,' + convert(varchar,@i_formato_fecha) + ')'


---------------------------------
-- ARMA LA CADENA CON LAS TABLAS
---------------------------------
select @w_tablas       = ' from pf_autorizacion, pf_operacion, pf_tipo_deposito '
select @w_ordenamiento = ' order by op_num_banco, au_secuencial' 

-------------------------------------------------------------------------
-- ARMA LA CADENA CON LOS CRITERIOS
-------------------------------------------------------------------------
-----------
-- GENERAL
-----------
select @w_criterio =' where  op_num_banco > ''' + @i_num_banco + ''' and op_operacion = au_operacion and td_mnemonico = op_toperacion ' 

-------------------------
-- FECHA DE EMISION
-------------------------
if @i_fecha1 is not null
begin
   if @i_fecha2 is not null
      select @w_criterio = @w_criterio + '  and  au_fecha_crea  between '''+convert(varchar,@i_fecha1,101)+''' and '''+convert(varchar,@i_fecha2,101)+ ''''
   else
      select @w_criterio = @w_criterio + '  and  au_fecha_crea >= '''+convert(varchar,@i_fecha1,101)+''

   select @w_ordenamiento = ' order by au_fecha_crea ' 
end
else
begin
   if @i_fecha2 is not null
      select @w_criterio = @w_criterio + '  and  au_fecha_crea <= '''+convert(varchar,@i_fecha2,101)+''
end

-----------
-- NIVELES
-----------
if @i_nivel  = 'F' 
begin
   select @w_criterio = @w_criterio + '  and op_oficial = ''' + @i_valor + '''' +  ' and op_oficial = au_autoriza '   --CDP 02/OCT/09
end
else if @i_nivel  = 'O' 
begin
   select @w_criterio = @w_criterio + '  and op_oficina = ' + @i_valor
end
else if @i_nivel  = 'C' 
begin
   select @w_tablas = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + '  and of_ciudad = ' + @i_valor + ' and op_oficina = of_oficina '
end
else if @i_nivel  = 'R' 
begin
   select @w_tablas = @w_tablas + ', cobis..cl_oficina'
   select @w_criterio = @w_criterio + '  and of_regional = ' + '''' + @i_valor + ''''  +  ' and op_oficina = of_oficina '
end
  
----------------------
-- OTROS CRITERIOS
----------------------
if @i_tipo_deposito <> '%'
begin    
   select @w_criterio = @w_criterio + '  and op_toperacion = ''' + @i_tipo_deposito + ''''
end
if @c_tautorizacion <> '%'
begin
   select @w_criterio = @w_criterio + '  and au_tautorizacion = ''' + @c_tautorizacion + ''''
end
if @i_propietario <> '%'
begin
   select @w_tablas = @w_tablas + ' ,pf_beneficiario '
   select @w_criterio = @w_criterio + '  and op_operacion = be_operacion'+ 
                                      '  and be_ente = '+ @i_propietario + 
                                      '  and be_estado_xren = ''N''' +
                                      '  and be_tipo = ''T'''        +
                                      '  and be_estado = ''I'''
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
if @i_estado <> '%'
begin
   select @w_criterio = @w_criterio + '  and op_estado = ''' + @i_estado + ''''
end

-------------------------------------------------------------------------
-- EJECUCION DE LA CONSULTA
-------------------------------------------------------------------------
select @o_consulta = '15'

set rowcount 15

execute (@w_columnas + @w_tablas + @w_criterio + @w_ordenamiento)

set rowcount 0

return 0   
go
