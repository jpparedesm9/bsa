/************************************************************************/
/*      Archivo:                bt_pgint.sp                             */
/*      Stored procedure:       sp_batch_pagaint                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gustavo Calderon                        */
/*      Fecha de documentacion: 08/Agt/95                               */
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
/*      Aqui se mandan los depositos que cumplan con los parametros	*/
/*      y que el estado del deposito sea activado o sea 'ACT'. Opcio-   */
/* 	nalmente ciudad, oficina y tipo de dept. son los parametros 	*/
/* 	que permite este batch    	  	 			*/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      8-Agt-95  Erika Sanchez       Creacion                          */
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

if exists (select 1 from sysobjects where name = 'sp_batch_pagaint')
   drop proc sp_batch_pagaint
go

create proc sp_batch_pagaint (
/** VARIABLES DE ENTRADA PARA SELECCION ESPECIFICA **/
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESRV',
@s_lsrv                 varchar(30)     = 'PRESRV',
@s_ofi                  smallint        = 11,   
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = NULL,
@i_fecha_proceso        varchar(10)     = NULL,
@i_toperacion           catalogo        = 'T',		
@i_ciudad               catalogo        = 'T',
@i_oficina	            catalogo        = 'T')
with encryption
as
declare 
  @w_sp_name              descripcion,
  @w_return               int,
  @w_error                int,
	@w_fecha_hoy            datetime,
/** VARIABLES PARA NUMERO DE TRANSACCIONES **/
 	@w_tran_confirmacion	int,
/** VARIABLES PARA PF_OPERACION **/
  @w_num_banco            cuenta

/** DEBUG **/
select @w_sp_name = 'sp_batch_pagaint'

/** CARGADO DE LOS PARAMETROS  talvez no sea utilizado **/
if @i_toperacion = 'T'
	select @i_toperacion = '%'
if @i_ciudad = 'T'
	select @i_ciudad = '%'
if @i_oficina = 'T'
	select @i_oficina = '%'

select @w_tran_confirmacion   = 14921,
       @w_fecha_hoy = convert(datetime,@i_fecha_proceso),
       @w_error = 1

/** DECLARACION DEL CURSOR PARA BARRER PF_OPERACION  **/
declare cursor_operacion cursor
for select  op_num_banco
    from pf_operacion, cobis..cl_oficina 
    where op_estado = 'ACT' 
      and op_accion_sgte <> 'XCAN' 
      and datediff(dd,op_fecha_ven,@w_fecha_hoy) <> 0  
      and convert(varchar(5),op_toperacion) like  @i_toperacion  
      and convert (varchar(5),of_ciudad) like  @i_ciudad  
      and	convert (varchar(5),op_oficina) like  @i_oficina 
      and of_oficina = op_oficina  
for update

open cursor_operacion

/** LECTURA DEL PRIMER REGISTRO **/
fetch cursor_operacion into
  @w_num_banco

while (@@fetch_status = 0)
begin  
  /**                         PAGO DE INTERESES                            **/
  exec @s_ssn = sp_gen_sec		
  
  exec @w_return = sp_paga_int @s_ssn=@s_ssn,
  	         @s_user=@s_user,  @s_term=@s_term,	
  	         @s_date=@s_date,  @s_srv=@s_srv,
   	         @s_lsrv=@s_lsrv,  @s_ofi=@s_ofi,
  	         @s_rol=@s_rol,    @t_debug=@t_debug,
  	         @t_file=@t_file,  @t_from=@w_sp_name,
  	         @t_trn=@t_trn,    @i_operacion     = null,
             @i_en_linea = 'N',@i_fecha_proceso = @w_fecha_hoy,
             @i_num_banco = @w_num_banco
  
  if @w_return <> 0		
  begin	
	  select @w_return	
    
    exec sp_errorlog @i_fecha = @s_date,  
         @i_error = @w_return, @i_usuario=@s_user,
         @i_tran=@t_trn,@i_operacion=@w_num_banco
  end    
  
	/************** LECTURA CADA REGISTRO DE PF_OPERACION *******************/
	fetch cursor_operacion into
       @w_num_banco
  /**          		  FIN: CONFIRMACION      		       **/
  /************************************************************************/
end /*end del while*/    

goto SIGUIENTE

ERROR:
  exec sp_errorlog @i_fecha = @s_date,     
                   @i_error = @w_error, @i_usuario=@s_user,     
                   @i_tran=@t_trn,@i_operacion=@w_num_banco     
	return 1						

SIGUIENTE:

close cursor_operacion
deallocate cursor_operacion
go
