/************************************************************************/
/*      Archivo:                bt_confi.sp                             */
/*      Stored procedure:       sp_batch_confirma                       */
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
/*      y que el estado del deposito sea por activar 'XACT'.  Opcio-    */
/* 	nalmente ciudad, oficina y tipo de dept. son los parametros 	*/
/* 	que permite este batch    	  	 			*/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      8-Agt-95     Erika Sanchez       Creacion                       */
/*      25-Abr-2005  N. Silva            Correccion e identacion        */
/*      13/08/2009   JBQ                 Adaptacion MSSQLServer         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_batch_confirma' and type = 'P')
   drop proc sp_batch_confirma
go

create proc sp_batch_confirma (
/** VARIABLES DE ENTRADA PARA SELECCION ESPECIFICA **/
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESRV',
@s_lsrv                 varchar(30)     = 'PRESRV',
@s_ofi                  smallint        = 1,   
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14924,
@i_fecha_proceso        varchar(10)     = NULL,
@i_toperacion           catalogo        = 'T',		
@i_ciudad               catalogo        = 'T',
@i_oficina              catalogo        = 'T',
@i_en_linea		        char(1)         = 'N')
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
        @w_num_banco            cuenta,
        @w_num_dias             int, 
	@w_operacion		int,
	@w_fecha_ven            datetime,
	@w_fecha_pg_int         datetime,
        @w_moneda               tinyint,
	@w_moneda_pg            char(2), 
	@w_mon_pg               tinyint, 
	@w_ente                 int, 
	@w_fecha_mod            datetime,
	@w_fecha_valor          datetime,
	@w_causa_mod            catalogo,
	@w_toperacion           catalogo,
	@w_monto_pg_int		money,
	@w_total_int_estimado	money,
	@w_fpago		catalogo,
	@w_historia	        smallint,
	@w_accion_sgte		catalogo,
	@w_estado		catalogo,  
	@w_retienimp		char(1),
	@w_renova_todo		char(1),
	@w_mon_sgte             smallint, 
	@w_ppago                catalogo,
	@w_tcapitalizacion	char(1),
	@w_dias_anio		smallint,
 	@w_tasa			float	

/*---------*/
/** DEBUG **/
/*---------*/
select @w_sp_name = 'sp_batch_confirma'

-----------------------
-- Carga de parametros 
-----------------------
if @i_toperacion = 'T'
	select @i_toperacion = '%'
if @i_ciudad = 'T'
	select @i_ciudad = '%'
if @i_oficina = 'T'
	select @i_oficina = '%'

select @w_tran_confirmacion   = 14921,
       @w_fecha_hoy = convert(datetime,@i_fecha_proceso,101),
       @w_error = 0

update pf_operacion 
set op_causa_mod = 'NULL' 
where op_causa_mod = 'CACT'

----------------------------------
-- Acceso a la tabla pf_operacion
----------------------------------
declare cursor_operacion_confirma cursor local
for select op_num_banco      , op_num_dias    , op_operacion         , op_mon_sgte,
           op_fecha_ven      , op_fecha_pg_int, op_accion_sgte       , op_moneda,
           op_moneda_pg      , op_ente        , op_total_int_estimado, op_estado,
           op_fecha_mod      , op_causa_mod   , op_monto_pg_int      , op_fpago,
           op_historia       , op_retienimp   , op_renova_todo       , op_ppago,
           op_tcapitalizacion, op_tasa        , op_base_calculo      , op_fecha_valor,
           op_toperacion     
      from pf_operacion, cobis..cl_oficina 
     where datediff(dd,convert(datetime,op_fecha_valor,101), @w_fecha_hoy) = 0
       and op_estado = 'XACT' 
       and convert(varchar(5),op_toperacion) like  @i_toperacion  
       and convert (varchar(5),of_ciudad) like  @i_ciudad  
       and convert (varchar(5),op_oficina) like  @i_oficina 
       and of_oficina = op_oficina 
for update

open cursor_operacion_confirma

-----------------------------
-- Acceso al primer registro
-----------------------------
fetch cursor_operacion_confirma into
            @w_num_banco      , @w_num_dias    , @w_operacion         , @w_mon_sgte,
            @w_fecha_ven      , @w_fecha_pg_int, @w_accion_sgte       , @w_moneda, 
            @w_moneda_pg      , @w_ente        , @w_total_int_estimado, @w_estado,
            @w_fecha_mod      , @w_causa_mod   , @w_monto_pg_int      , @w_fpago,
            @w_historia       , @w_retienimp   , @w_renova_todo       , @w_ppago,
            @w_tcapitalizacion, @w_tasa	       , @w_dias_anio         , @w_fecha_valor,
	    @w_toperacion   
  
while @@fetch_status = 0
begin  
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @s_ssn = ADMIN...rp_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

        select @w_mon_pg = convert(tinyint,@w_moneda_pg)
  
        --I.CVA Ene-10-07
	select @s_ofi = hi_oficina
        from pf_historia
        where hi_operacion = @w_operacion
          and hi_trn_code  = 14914 --Activaci¢n del DPF.
        --I.CVA Ene-10-07

        exec @w_return = sp_confirma_op 
	 @s_ssn                = @s_ssn, 
  	 @s_user               = @s_user,     
         @s_term               = @s_term,	
  	 @s_date               = @s_date,     
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,   
         @s_ofi                = @s_ofi,
  	 @s_rol                = @s_rol,     
         @t_debug              = @t_debug,
  	 @t_file               = @t_file,    
         @t_from               = @w_sp_name,
  	 @t_trn                = @t_trn, 
         @i_fecha_valor        = @w_fecha_valor,
	 @i_fecha_hoy          = @w_fecha_hoy,
  	 @i_num_banco          = @w_num_banco,	
  	 @i_num_dias           = @w_num_dias,	
	 @i_operacion          = @w_operacion,
         @i_estado	       = @w_estado,
         @i_moneda	       = @w_moneda,
         @i_moneda_pg	       = @w_mon_pg,
	 @i_ente               = @w_ente,
         @i_total_int_estimado = @w_total_int_estimado,
         @i_mon_sgte           = @w_mon_sgte,
         @i_fecha_mod          = @w_fecha_mod  ,   
         @i_fecha_pg_int       = @w_fecha_pg_int,   
         @i_causa_mod          = @w_causa_mod,  
         @i_monto_pg_int       = @w_monto_pg_int,
         @i_fpago              = @w_fpago,
         @i_en_linea           = 'N',
         @i_retienimp          = @w_retienimp,
         @i_renova_todo        = @w_renova_todo,
         @i_historia           = @w_historia,
	 @i_ppago	       = @w_ppago,
         @i_tcapitalizacion    = @w_tcapitalizacion,
         @i_tasa	       = @w_tasa,
         @i_dias_anio	       = @w_dias_anio,
         @i_toperacion	       = @w_toperacion  
         if @w_return <> 0		
         begin
             exec sp_errorlog 
                  @i_fecha   = @s_date,  
                  @i_error   = @w_return,
                  @i_usuario = @s_user,
                  @i_tran    = @t_trn,
                  @i_cuenta  = @w_num_banco

             select @w_error = @w_return
         end   

   --------------------------------	
   -- Acceso al siguiente registro
   --------------------------------
   fetch cursor_operacion_confirma into
               @w_num_banco      , @w_num_dias    , @w_operacion         , @w_mon_sgte,
               @w_fecha_ven      , @w_fecha_pg_int, @w_accion_sgte       , @w_moneda, 
               @w_moneda_pg      , @w_ente        , @w_total_int_estimado, @w_estado,
               @w_fecha_mod      , @w_causa_mod   , @w_monto_pg_int      , @w_fpago,
               @w_historia       , @w_retienimp   , @w_renova_todo       , @w_ppago,
               @w_tcapitalizacion, @w_tasa	  , @w_dias_anio         , @w_fecha_valor,
	       @w_toperacion   
end /*end del while*/

close cursor_operacion_confirma
deallocate cursor_operacion_confirma

return @w_error

go
