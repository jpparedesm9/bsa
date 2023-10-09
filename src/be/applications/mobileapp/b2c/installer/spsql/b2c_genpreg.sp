/************************************************************************/
/*      Archivo:                b2c_genpreg.sp                          */
/*      Stored procedure:       sp_b2c_generar_preguntas                */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Nov/2018                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Genera preguntas de verificacion para recuperacion de clave.    */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    15/Nov/2018           TBA              Emision Inicial            */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_generar_preguntas')
    drop proc sp_b2c_generar_preguntas
go

create proc sp_b2c_generar_preguntas(
@s_ssn           int          = null,
@s_sesn          int          = null,
@s_date          datetime     = null,
@s_user          varchar(14)  = null,
@s_term          varchar(30)  = null,
@s_ofi           smallint     = null,
@s_srv           varchar(30)  = null,
@s_lsrv          varchar(30)  = null,
@s_rol           smallint     = null,
@s_org           varchar(15)  = null,
@s_culture       varchar(15)  = null,
@t_rty           char(1)      = null,
@t_debug         char(1)      = 'N',
@t_file          varchar(14)  = null,
@t_trn           int     = null,
@i_cliente       int,
@o_msg           varchar(200) = null output
)
as
declare
@w_sp_name            varchar(25), 
@w_num_aleatorio      int,
@w_cont               int,
@w_pregunta_id        int,
@w_texto              varchar(200),
@w_tipo_respuesta     varchar(1),
@w_no_tengo           varchar(1),
@w_error              int,
@w_num_preguntas      int,
@w_cont_preguntas     int,
@w_num_preguntas_bco int

select  @w_sp_name = 'sp_b2c_generar_preguntas'


IF OBJECT_ID('tempdb..#preguntas') IS NOT NULL
    DROP TABLE preguntas


create table  #preguntas(
id                 int,
cliente            int,
texto              varchar(200),
tipo_respueta      varchar,
no_tengo           varchar(1)
)


select @w_cont_preguntas = count(1) from bv_b2c_banco_preguntas

select @w_num_preguntas = pa_tinyint
from cobis..cl_parametro 
where pa_nemonico = 'B2CNPV'
and   pa_producto = 'BVI'


select @w_num_preguntas_bco = count(1)
from bv_b2c_banco_preguntas 
where bp_estado = 'V'

if @w_num_preguntas_bco < @w_num_preguntas begin
    select @o_msg = 'ERROR: AL CONSULTAR PREGUNTAS '
	select @w_error = 1850066
	
	goto ERROR
	
end

select @w_cont = 0

while (@w_cont<@w_num_preguntas)
begin
	select @w_num_aleatorio = (floor(RAND()*@w_cont_preguntas)) + 1--número del 1 al 10

    if not exists (select 1 from bv_b2c_banco_preguntas where bp_pregunta_id = @w_num_aleatorio and bp_estado = 'V') continue
	
	if exists (select 1 from #preguntas where id = @w_num_aleatorio) continue
	
	select 
	@w_pregunta_id    = bp_pregunta_id,
	@w_texto          = bp_texto,
	@w_tipo_respuesta = bp_tipo_respuesta,
	@w_no_tengo       = bp_no_tengo		
	from bv_b2c_banco_preguntas 
	where bp_pregunta_id = @w_num_aleatorio
	
	insert into #preguntas(
	id,             cliente,    texto,
    tipo_respueta, 	no_tengo)
	values(
	@w_pregunta_id,    @i_cliente, @w_texto,   
	@w_tipo_respuesta, @w_no_tengo)
	
	if @@error <> 0	begin
	    select @o_msg = 'ERROR: AL INSERTAR PREGUNTA '
		select @w_error = 1850071
		
		goto ERROR
	end
	
	select @w_cont = @w_cont+ 1
	
end

select 
id,
texto,
tipo_respueta,
no_tengo
from #preguntas 

return 0

ERROR:

		
return @w_error

go
