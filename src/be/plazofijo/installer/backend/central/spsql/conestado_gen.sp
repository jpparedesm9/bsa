/************************************************************************/
/*      Archivo:                cones_ge.sp 	                        */
/*      Stored procedure:       sp_conestado_gen                        */
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
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de SEARCH a la tabla    */
/*      de operaciones 'pf_operacion' por su estado.                    */
/*                                                                      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */   
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de SEARCH a la tabla    */
/*      de operaciones 'pf_operacion' por su estado.                    */
/*                                                                      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */   
/*      03-Nov-94  Ricardo Valencia   Creacion                          */
/*      10-Nov-98  Dolores Guerrero   Control de beneficiario, nivel 'T'*/
/*      31-Ene-01  Gabriela Estupinan Utilizacion de tabla temporal     */
/*                                    para nivel general unicamente     */
/*      16-Oct-01  Memito Saborio     Incluye campo para verificacion   */
/*                                    de custodias.                     */
/*      25-Ene-02  Gabriela Estupinan Se comenta el campo de direccion  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_conestado_gen') is not null
   drop proc sp_conestado_gen
go

create proc sp_conestado_gen (
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
@i_retenciones          char(1)         = '%',
@i_garantias            char(1)         = '%',
@i_propietario          catalogo	    = '%',
@i_tipo_deposito        catalogo        = '%',
@i_tipo_plazo           catalogo        = '%',
@i_tipo_monto           catalogo        = '%',
@i_accion_sgte          catalogo        = '%',
@i_num_banco            cuenta          = '0',
@i_modo                 int             = 0,
@i_fecha1               datetime        = null,
@i_fecha2               datetime        = null,
@i_fechai1	            datetime        = null,
@i_fechai2     	        datetime        = null,
@i_moneda               varchar(2)      = '%',
@i_estado               catalogo        = '%',
@i_titular              varchar(40)     = '%',
@i_formato_fecha        int             = 0,
@i_custodia             char(1)         = '%')
with encryption
as
declare
@w_sp_name              varchar(32),
@w_num_reg              int            -- GES 01/29/2001
--if @i_propietario = '%' -- para que no saque claves duplicadas
	--select @i_propietario = 'AAAAA'

select @w_sp_name = 'sp_conestado_gen'

--if @i_fecha2 = '01/01/1900'
--	select @i_fecha2 = '01/01/2200'
	
--if @i_fechai2 = '01/01/1900'
--	select @i_fechai2 = '01/01/2200'
	
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
            i_estado                    = @i_estado
  exec cobis..sp_end_debug
end

/*************************************************
   create table #operacion(
   operacion int,
   num_banco cuenta,
   titular descripcion,
   toperacion catalogo,
   estado catalogo,
   oficial login,
   moneda tinyint,
   tasa float,
   tipo_plazo  catalogo,
   tipo_monto  catalogo,
   accion_sgte catalogo, 
   pignorado char(1),
   retenido char(1),
   total_int_ganados money,
   total_int_pagados money,
   fecha_ven datetime,
   fecha_ingreso datetime,
   telefono varchar(8),
   num_dias int,
   monto money)
-- direccion varchar(254) null  )
**************************************************/

if @i_num_banco = ''
   print 'i_num_banco'

if @i_num_banco is null
   print 'nulo'

select operacion = op_operacion, num_banco = op_num_banco,
   	titular = op_descripcion, toperacion = op_toperacion,
   	estado = op_estado, oficial = op_oficial, moneda = op_moneda,
   	tasa = op_tasa, tipo_plazo = op_tipo_plazo,
   	tipo_monto = op_tipo_monto, accion_sgte = op_accion_sgte,
   	pignorado = op_pignorado, retenido = op_retenido,
   	total_int_ganados = op_total_int_ganados,
   	total_int_pagados = op_total_int_pagados,
   	fecha_ven = op_fecha_ven,
   	fecha_ingreso = op_fecha_ingreso, telefono = op_telefono ,
   	num_dias = op_num_dias, monto = op_monto, 
   	custodia = isnull(op_custodia, 'N'),
   	ejecutivo = op_oficial
into #operacion
from pf_operacion 
where op_num_banco > @i_num_banco
  and op_fecha_ven between isnull(@i_fecha1, op_fecha_ven) and isnull(@i_fecha2, op_fecha_ven)
  and op_fecha_ingreso between isnull(@i_fechai1, op_fecha_ingreso) and isnull(@i_fechai2, op_fecha_ingreso)
--  and op_ente *=  di_ente
--  and op_direccion  *= di_direccion   
 
select @w_num_reg = count(*) from #operacion

if @w_num_reg > 0
begin
  if @i_tipo_deposito <> '%'
  begin 
    delete #operacion 
    where toperacion <> @i_tipo_deposito      
  end
   
  if @i_propietario <> '%'
  begin
    delete #operacion
    from #operacion
    where operacion not in (select distinct be_operacion
                        from pf_beneficiario 
                        where be_ente = convert(int, @i_propietario)
                          and be_estado_xren = 'N'
                       )
  end

  if @i_estado <> '%'
  begin
    delete #operacion
    from #operacion
    where estado <> @i_estado    
  end

  if @i_moneda <> '%'
  begin
    delete #operacion
    from #operacion
    where convert(varchar(2),moneda) <> @i_moneda
  end

  if @i_tipo_plazo <> '%'
  begin
    delete #operacion
    from #operacion
    where tipo_plazo <> @i_tipo_plazo
  end

  if @i_tipo_monto <> '%'
  begin
    delete #operacion
    from #operacion
    where tipo_monto <> @i_tipo_monto 
  end

  if @i_accion_sgte <> '%'
  begin
    delete #operacion
    from #operacion
    where accion_sgte <> @i_accion_sgte
  end

  if @i_garantias <> '%'
  begin
    delete #operacion
    from #operacion
    where pignorado <> @i_garantias 
  end
   
  if @i_retenciones <> '%'
  begin
    delete #operacion
    from #operacion
    where retenido <> @i_retenciones 
  end

  if @i_titular <> '%'
  begin
    delete #operacion
    from #operacion
    where titular not like @i_titular 
  end

  if @i_custodia <> '%'
  begin
    delete #operacion
    from #operacion
    where custodia <> @i_custodia
  end

  set rowcount 20

  /**  EXTRAE LAS PRIMEROS 20 OPERACIONES   **/
  select 'Cuenta'              = num_banco,
             'Titular'             = titular,
             'Monto'               = monto, --GAR GB-DP00027 Cambio de Orden
             'Tasa'                = tasa,
             'Plazo'               = num_dias,
            'Int a pagar'         = total_int_ganados - total_int_pagados,
             'Total Intereses'     = total_int_ganados,
             'Estado'               = estado,
             'Fecha Venc.'       = convert(varchar(10),fecha_ven,
             @i_formato_fecha),
             'Fecha Ing.'         = convert(varchar(10),fecha_ingreso,
             @i_formato_fecha),
             /* GESCY2K B211 */
         -- 'Direccion '  =    direccion, 
             'Telefono '   =    telefono,
            'Ejecutivo'   =    ejecutivo
  from #operacion
end

set rowcount 0
return 0   

go
