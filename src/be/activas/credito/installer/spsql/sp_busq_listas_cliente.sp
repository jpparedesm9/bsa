/************************************************************************/
/*   Archivo:              sp_busq_listas_cliente.sp                    */
/*   Stored procedure:     sp_busq_listas_cliente.sp                    */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Adriana Chiluisa                             */
/*   Fecha de escritura:   Abril 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Extrae un archivo de texto e ingresa en la tabla su información    */
/*                              CAMBIOS                                 */
/*   23/04/2018               A. Chiluisa         Versión Inicial       */
/*   28/03/2023               KVI                 R203112-Val. defecto  */      
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_busq_listas_cliente')
   drop proc sp_busq_listas_cliente
go

create proc sp_busq_listas_cliente
(
 @s_ssn        int         = 1,
 @s_user       login       = 'OPERADOR',
 @s_sesn       int         = 1,
 @s_term       varchar(30) = 'CONSOLA',
 @s_date       datetime    = null,
 @s_srv        varchar(30) = 'HOST',
 @s_lsrv       varchar(30) = 'LOCAL HOST',
 @s_ofi        smallint    = null,
 @s_servicio   int         = null,
 @s_cliente    int         = null,
 @s_rol        smallint    = null,
 @s_culture    varchar(10) = null,
 @s_org        char(1)     = null,
 @i_ente       int,
 @o_resultado  smallint    = NULL out
)
as
declare
@w_sp_name       varchar(100),
@w_error         int,
@w_msg_error     varchar(255),
@w_ape_paterno   varchar(16),
@w_ape_materno   varchar(16),
@w_nombre        varchar(64),
@w_razon_social  varchar(128),
@w_resultado_ng     int,
@w_resultado_ln     int,
@w_resultado        int,
@w_origen_lista     varchar(2),
@w_fecha_proceso    datetime -- R203112


select @w_sp_name    = 'sp_busq_listas_cliente'

if @i_ente is null return 0

EXEC sp_negative_file
@i_ente      = @i_ente ,
@o_resultado = @w_resultado_ng OUT

if(@w_resultado_ng = 1)
begin
    print 'Ingreso a consultar Listas Negras'
	EXEC sp_li_negra_cliente
    @i_ente      = @i_ente ,
    @o_resultado = @w_resultado_ln OUT
	
	if(@w_resultado_ln = 1)
	begin
        select @o_resultado  = 1
	end
	else if(@w_resultado_ln = 3 )
	begin
	    select @w_origen_lista = 'LN'
        select @o_resultado  = 3
	end
	
end
else if(@w_resultado_ng>1 )
begin
    select @w_origen_lista = 'NG'
    select @o_resultado  = 3
end
	print '@w_origen_lista: '+@w_origen_lista

--Inicio R203112
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	
if @o_resultado  = 3
begin 
    update cobis..cl_ente_aux 
	set ea_nivel_riesgo_cg  = 'F',
	ea_puntaje_riesgo_cg 	= 'S/C',
	ea_fecha_evaluacion  	= @w_fecha_proceso,
	ea_nivel_riesgo_1       = 'F',
    ea_nivel_riesgo_2       = 'LN',
    ea_tipo_calif_eva_cli   = null
	where ea_ente = @i_ente
	
	update cobis..cl_ente 
	set p_calif_cliente = 'ROJO'          
	where en_ente = @i_ente
	and en_subtipo = 'P'
end
--Fin R203112

return 0

go
