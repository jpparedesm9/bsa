/************************************************************************/
/*      Archivo:                conlote.sp                              */
/*      Stored procedure:       sp_consulta_lote                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Mireya Jarrin                           */
/*      Fecha de documentacion: 15/Feb/96                               */
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
/*      Este programa consulta los papeles comerciales pertenecientes   */
/*      a un lote especifico                                            */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*     15/Feb/96     Mireya Jarrin      Emision Inicial                 */
/*                                                                      */
/*     Transaccion  :   14643      Help                                 */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_lote')
   drop proc sp_consulta_lote
go

create proc sp_consulta_lote (
@s_ssn                  int         = null,
@s_user                 login       = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint    = null,
@i_operacion            char(1),
@i_tipo                 char(1),
@i_num_banco            cuenta      = null,
@i_lote                 cuenta,
@i_modo                 smallint    = 0,
@i_empresa              tinyint     = 1)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_return               int,
@w_numdeci              tinyint,
@w_moneda               smallint,
@w_usadeci              char(1),
@w_moneda_base          tinyint    

select @w_sp_name = 'sp_consulta_lote'

if @i_operacion <> 'H' or @t_trn <> 14643
begin
  exec cobis..sp_cerror
     @t_debug	= @t_debug,
	   @t_file	= @t_file,
	   @t_from	= @w_sp_name,
	   @i_num	= 141112
	/* 'No existe categoria de operacion' */
	return 1
end

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
  exec cobis..sp_cerror
     @t_debug=@t_debug,
     @t_file=@t_file,
     @t_from=@w_sp_name,
     @i_num = 601018
  return  1
end 

select @w_moneda = @w_moneda_base

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
  select @w_numdeci = isnull (pa_tinyint,0)
  from cobis..cl_parametro
  where pa_nemonico = 'DCI'
    and pa_producto = 'PFI'
end
else
  select @w_numdeci = 0
                                                       
/** Help **/
If @i_operacion = 'H'
begin
  if @i_tipo = 'A' 
  begin  
    set rowcount 20
    if @i_modo = 0
    begin
      /* Extrae los primeros veinte tipos de plazo */
      select /* 'LOTE'       	  = dl_lote, */
                'OPERACION'      	  = dl_num_banco,
		            'PREIMPRESO'	=  dl_preimpreso,
	              'MONTO'             = round(dl_monto,@w_numdeci),
	              'INTERES'           = round(dl_interes,@w_numdeci),
	              'IMPUESTO'          = round(dl_impuesto,@w_numdeci),
                'ESTADO'            = dl_estado
      from pf_det_lote 
      where dl_lote = @i_lote 
      order by dl_num_banco
    end

    if @i_modo = 1
    begin
      /* Extrae los siguientes 20 tipos de plazo */
      select /* 'LOTE'      	  = dl_lote,  */
            'OPERACION'     	  = dl_num_banco,
		        'PREIMPRESO'	=  dl_preimpreso,
	          'MONTO'             = round(dl_monto,@w_numdeci),
	          'INTERES'           = round(dl_interes,@w_numdeci),
	          'IMPUESTO'          = round(dl_impuesto,@w_numdeci),
            'ESTADO'            = dl_estado
      from pf_det_lote 
      where dl_lote = @i_lote and dl_num_banco > @i_num_banco
      order by dl_num_banco
    end
    set rowcount 0 
    return 0   
  end

  if @i_tipo = 'V' 
  begin  
    set rowcount 0
    
    /* Extrae los primeros veinte tipos de plazo */
    select /* 'LOTE'      	  = dl_lote, */
	            'OPERACION'      	  = dl_num_banco,
	            'MONTO'             = dl_monto,
	            'INTERES'           = dl_interes,
	            'IMPUESTO'          = dl_impuesto,
              'ESTADO'            = dl_estado
    from pf_det_lote 
    where dl_num_banco = @i_num_banco

    return 0   
  end
end

go

