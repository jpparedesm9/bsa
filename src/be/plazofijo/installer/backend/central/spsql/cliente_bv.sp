/************************************************************************/
/*	Archivo:		cliente_bv.sp				*/
/*	Stored procedure:	sp_cliente_bv   			*/
/*	Base de datos: 	        cob_pfijo	                        */
/*	Producto:               Plazo Fijo-Banca Virtual       		*/
/*	Disenado por:           Ricardo Alvarez				*/
/*	Fecha de escritura:     04/18/2000				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes  exclusivos  para el  Ecuador  de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa busca los depositos de un cliente para interface  */
/*      con banca virtual y cartera.                                	*/
/************************************************************************/
/*                           MODIFICACIONES                         	*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/18/2000      R. Alvarez      Emision Inicial                 */ 
/*	09/20/2001      J. Saborio      Cambio para que funcione con un */ 
/*                                  estado y incluya la descripcion 	*/
/*                                  del tipo de depósito.           	*/
/*	13/Dic/2001    F. Velasco aumentar el @i_presenta_error para BV */ 
/*	27/Jun/2006    P. Coello  Devolver nombre del cliente dado el numero de operacion */ 
/************************************************************************/
/*                           EJEMPLOS                               	*/
/*  Si la moneda va NULL escoje las operaciones para todas las mo-  	*/
/*  das existentes, caso contrario escoje la de la moneda ingresada 	*/
/*  si no se envía nada escoje la moneda 1 por omisión.             	*/
/*  Si deja el estado en NULL saldran todos los depósitos con cual- 	*/
/*  quier estado, si lo omite salen únicamente los activos o puede  	*/
/*  ingresar alguno en particular para obtener los datos de este.   	*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cliente_bv')
   drop proc sp_cliente_bv
go

create proc sp_cliente_bv (
@s_ssn                     int           = NULL,
@s_user                    login         = NULL,
@s_sesn                    int           = NULL,
@s_term                    varchar(30)   = NULL,
@s_date                    datetime      = NULL,
@s_srv                     varchar(30)   = NULL,
@s_lsrv                    varchar(30)   = NULL, 
@s_rol                     smallint      = NULL,
@s_ofi                     smallint      = NULL,
@s_org_err                 char(1)       = NULL,
@s_error                   int           = NULL,
@s_sev                     tinyint       = NULL,
@s_msg                     descripcion   = NULL,
@s_org                     char(1)       = NULL,
@t_debug                   char(1)       = 'N',
@t_file                    varchar(14)   = NULL,
@t_from                    varchar(32)   = NULL,
@t_trn                     smallint      = NULL,
@i_operacion               char(2),
@i_ente                    int           = NULL,
@i_modo                    smallint      = 0,
@i_num_banco               cuenta        = NULL,
@i_moneda                  tinyint       = NULL,
@i_op_estado               catalogo      = 'ACT',
@i_formato_fecha           int           = 101,
@i_presenta_error          char(1)       = 'N',    -- FVE 13/Dic/2001: No desplegar errores en BV. 
@o_descripcion             descripcion   = NULL out
)
with encryption
as
declare
@w_return                  int,
@w_sp_name	               varchar(32)

select @w_sp_name = 'sp_cliente_bv'

if (@t_trn <> 14448 or (@i_operacion <> 'Q'  and @i_operacion <> 'V'))
begin
  /* 'Tipo de transaccion no corresponde' */
  exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141112
  return 1
end                     

if @i_operacion = 'Q'
begin
  set rowcount 20
  if @i_modo = 0
  begin
    select 'Nombre' 	= td_descripcion,
    'Operacion' 	= op_num_banco,
    'Cliente'           = substring(op_descripcion,1,20),
    'Monto'         = op_monto,
     --'Tipo de Operacion' = op_toperacion,
    'Moneda' 	    = substring(mo_descripcion,1,7),
    'Pignorado'     = isnull(op_pignorado,'N'),
    'Retenido'      = isnull(op_retenido, 'N'),
    'Custodia'      = isnull(op_custodia, 'N'),
    'Frecuencia'    = isnull(pp_descripcion, 'AL VENCIMIENTO'),
    'Apertura'      = convert(varchar, op_fecha_valor, @i_formato_fecha),
    'Vencimiento'   = convert(varchar, op_fecha_ven, @i_formato_fecha),
    'Tasa'          = op_tasa,
    'Intereses'     = op_int_estimado,
    'Cupones'       = (select count(*) from pf_cuotas 
                      where cu_operacion = pf_operacion.op_operacion
                      and pf_operacion.op_cupon = 'S')
    from  pf_operacion
    inner join pf_tipo_deposito on 
       op_toperacion = td_mnemonico 
       inner join cobis..cl_moneda on
          op_moneda = mo_moneda
          left outer join pf_ppago on
             op_ppago = pp_codigo 
    where op_ente = @i_ente
    and op_estado = isnull('ACT' , op_estado)
    and op_moneda = isnull(0, op_moneda)    

    if @@rowcount = 0 and @i_presenta_error = 'S'
    begin
       exec cobis..sp_cerror
       @t_debug	 = @t_debug,
       @t_file	 = @t_file,
       @t_from	 = @w_sp_name,
       @i_num	 = 141044
      /*  'No corresponde codigo de transaccion' */
       return 1
    end
  end

  if @i_modo = 1
  begin
    select 'Nombre' 	= td_descripcion,
    'Operacion' 	= op_num_banco,
    'Cliente'           = substring(op_descripcion,1,20),
    'Monto'             = op_monto,
    --'Tipo de Operacion' = op_toperacion,
    'Moneda' 	    = substring(mo_descripcion,1,7),
    'Pignorado'     = isnull(op_pignorado,'N'),
    'Retenido'      = isnull(op_retenido, 'N'),
    'Custodia'      = isnull(op_custodia, 'N'),
    'Frecuencia'    = isnull(pp_descripcion, 'AL VENCIMIENTO'),
    'Apertura'      = convert(varchar, op_fecha_valor, @i_formato_fecha),
    'Vencimiento'   = convert(varchar, op_fecha_ven, @i_formato_fecha),
    'Tasa'          = op_tasa,
    'Intereses'     = op_int_estimado,
    'Cupones'       = (select count(*) from pf_cuotas 
    where cu_operacion = pf_operacion.op_operacion
    and pf_operacion.op_cupon = 'S')
    from  pf_operacion
    inner join pf_tipo_deposito on
       op_toperacion = td_mnemonico
       inner join cobis..cl_moneda on
          op_moneda = mo_moneda
          left outer join pf_ppago on
             op_ppago = pp_codigo 
    where op_ente = @i_ente
    and op_estado = isnull(@i_op_estado, op_estado)
    and op_num_banco > @i_num_banco 
    and op_moneda = isnull(@i_moneda, op_moneda)
         
    if @@rowcount = 0 and @i_presenta_error = 'S'
    begin
      exec cobis..sp_cerror
          @t_debug         = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141044
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end
  set rowcount 0
  return 0
end 

if @i_operacion = 'V'
begin
	select @o_descripcion = op_descripcion
	from pf_operacion
	where op_num_banco = @i_num_banco
	if @@rowcount = 0
   	begin
      	   exec cobis..sp_cerror
        	@t_debug = @t_debug,
           	@t_file  = @t_file,
           	@t_from  = @w_sp_name,
           	@i_num   = 141051
      		return 141051
   	end
end

go
