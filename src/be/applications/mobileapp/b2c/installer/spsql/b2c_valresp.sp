/************************************************************************/
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               B2C                                     */
/*      Disenado por:           DFu                                     */
/*      archivo:                b2c_valresp.sp                          */
/*      Fecha de escritura:     15/11/2018                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Valida  las respuestas del cliente a las preguntas de desafio.  */
/*                        MOFICIACIONES                                 */
/* 15/11/2018         DFU                  Emision inicial              */
/************************************************************************/  
use cob_bvirtual
go

IF OBJECT_ID ('dbo.sp_b2c_validar_respuestas') IS NOT NULL
    DROP PROCEDURE dbo.sp_b2c_validar_respuestas
GO

create proc sp_b2c_validar_respuestas
(
@s_ssn           int         = null,
@s_sesn          int         = null,
@s_date          datetime    = null,
@s_user          login       = null,
@s_term          varchar(30) = null,
@s_ofi           smallint    = null,
@s_srv           varchar(30) = null,
@s_lsrv          varchar(30) = null,
@s_rol           smallint    = null,
@s_org           varchar(15) = null,
@s_culture       varchar(15) = null,
@t_rty           char(1)     = null,
@t_debug         char(1)     = 'N',
@t_file          varchar(14) = null,
@t_trn           int    = null,     
@i_cliente       int,
@i_id_pregunta1  int,
@i_respuesta1    varchar(255),
@i_id_pregunta2  int,
@i_respuesta2    varchar(255),
@i_id_pregunta3  int,
@i_respuesta3    varchar(255),
@o_resultado     char(1) = 'N' OUT,
@o_msg           varchar(255)= null OUT
)
as 

declare 
@w_error             int,
@w_sp_name           varchar(30),
@w_programa          varchar(100),
@w_id_pregunta       int,
@w_respuesta         varchar(255),
@w_nro_pregunta      tinyint,
@w_total_preguntas   tinyint,
@w_resultado         varchar(255),
@w_no_tengo          char(1),
@w_intentos          int,
@w_fecha_proceso     datetime,
@w_intentos_fallidos int,
@w_maximo_intentos      int,
@w_intentos_fallidos_cc int

select 
@w_sp_name         = 'sp_b2c_validar_respuestas',
@w_nro_pregunta    = 1,
@o_resultado = 'S'

if not exists ( select 1 from cobis..cl_ente where en_ente = @i_cliente) begin
   select 
   @w_error =  1, --Error cuando no existe cliente
   @o_msg   =  'APLICACION NO ASOCIADA A UN CLIENTE, CONTACTE AL BANCO'
   goto ERROR
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

delete from bv_b2c_intento_desafio
where id_cliente = @i_cliente
and id_fecha_proceso < @w_fecha_proceso

if @@error <> 0
begin
   select 
   @w_error =  1850069, --Error al eliminar registro
   @o_msg   =  'EXISTE UN FALLO EN LA APLICACIÓN, POR FAVOR INTENTE MAS TARDE'
   goto ERROR
end

select @w_maximo_intentos = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico = 'B2CMIF' 
and   pa_producto = 'BVI' 


select @w_intentos_fallidos = isnull(count (1),0)
from bv_b2c_intento_desafio
where id_cliente     = @i_cliente
and id_fecha_proceso = @w_fecha_proceso
and id_resultado     = 'N'

set @w_intentos_fallidos_cc=@w_intentos_fallidos+1

if @w_intentos_fallidos >= @w_maximo_intentos begin
   select
   @w_error     = 1850072, 
   @o_msg       = 'HA SUPERADO EL NUMERO DE INTENTOS DE HOY, INTENTELO MAÑANA'
   goto ERROR
end

select @w_total_preguntas = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico = 'B2CNPV' 
and   pa_producto = 'BVI' 

select @w_total_preguntas = isnull(@w_total_preguntas, 3)

while @w_nro_pregunta <= @w_total_preguntas 
begin
    
   if @w_nro_pregunta = 1 select @w_id_pregunta = @i_id_pregunta1, @w_respuesta = ISNULL(LTRIM(RTRIM(@i_respuesta1)),'')
   if @w_nro_pregunta = 2 select @w_id_pregunta = @i_id_pregunta2, @w_respuesta = ISNULL(LTRIM(RTRIM(@i_respuesta2)),'')
   if @w_nro_pregunta = 3 select @w_id_pregunta = @i_id_pregunta3, @w_respuesta = ISNULL(LTRIM(RTRIM(@i_respuesta3)),'')
   
   select @w_respuesta = upper(@w_respuesta)
   
   select 
   @w_programa = bp_sp_validador,
   @w_no_tengo = bp_no_tengo
   from bv_b2c_banco_preguntas 
   where bp_pregunta_id = @w_id_pregunta
 
   
   exec @w_error  = @w_programa 
   @i_cliente     = @i_cliente,
   @i_respuesta   = @w_respuesta,
   @o_resultado   = @w_resultado out,
   @o_msg         = @o_msg out
      
   if @w_error != 0 goto ERROR
   
   
   if @w_resultado = 'N' begin
      select @o_resultado = 'N'
      break
   end
	  
   select @w_nro_pregunta = @w_nro_pregunta + 1
   
end

insert into bv_b2c_intento_desafio(
id_cliente, id_fecha_proceso, id_hora, 
id_resultado)
values (
@i_cliente, @w_fecha_proceso, getdate(), 
@o_resultado)

if @@error <> 0
begin
   select 
   @w_error =  1, --Error al eliminar registro
   @o_msg   =  'EXISTE UN FALLO EN LA APLICACIÓN, POR FAVOR INTENTE MAS TARDE.'
   goto ERROR
end

if(@o_resultado = 'N')
begin
    set @w_intentos_fallidos_cc=@w_intentos_fallidos+1
    select @o_msg ='LAS RESPUESTAS NO SON CORRECTAS, ESTE ES EL INTENTO '+' '+convert(VARCHAR(10),@w_intentos_fallidos_cc)+' '+
               '. RECUERDE QUE AL INTENTO'+' '+convert(VARCHAR(10),@w_maximo_intentos)+' '+' ESTA AUTORIZACIÓN SOLO SE PODRA HACER EL DÍA DE MAÑANA.'
end


return 0

ERROR:
if @o_msg is null 
   select @o_msg = mensaje
   from cobis..cl_errores 
   where numero = @w_error

select @o_resultado = 'N'

insert into bv_b2c_intento_desafio (
id_cliente, id_fecha_proceso, id_hora, 
id_resultado)
values (
@i_cliente, @w_fecha_proceso, getdate(), 
@o_resultado)

   
return @w_error

go


