/************************************************************************/
/*   Archivo:              sp_negative_file.sp                          */
/*   Stored procedure:     sp_negative_file                             */
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
/*   Extrae un archivo de texto e ingresa en la tabla su informaci�n    */
/*                              CAMBIOS                                 */
/*   23/04/2018               A. Chiluisa         Versi�n Inicial       */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_negative_file')
   drop proc sp_negative_file
go

create proc sp_negative_file
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
@w_n_conicidencias int

select @w_sp_name    = 'sp_negative_file'

if @i_ente is null return 0

--Obtener informacion
select 
    @w_ape_paterno  = lower(replace(isnull(p_p_apellido,''),' ', '')),
    @w_ape_materno  = lower(replace(isnull(p_s_apellido,''),' ', '')),
    @w_nombre       = lower(replace(isnull(en_nombre,''),' ', '')) + lower(replace(isnull(p_s_nombre,''),' ', '')),
    @w_razon_social = lower(replace(isnull(c_razon_social,''),' ', ''))
from cobis..cl_ente where en_ente = @i_ente

PRINT 'sp_negative_file-w_ape_paterno:'  + convert(VARCHAR(30),@w_ape_paterno)
PRINT 'sp_negative_file-w_ape_materno:'+ convert(VARCHAR(30),@w_ape_materno)
PRINT 'sp_negative_file-w_nombre:' + convert(VARCHAR(30), @w_nombre)
PRINT 'sp_negative_file-w_razon_social:' + convert(VARCHAR(30), @w_razon_social)

--Obtener # de coinicidencias
select @w_n_conicidencias = count(*) 
from  cob_credito..cr_negative_file 
where lower(replace(isnull(nf_ape_paterno,''),' ', '')) = @w_ape_paterno
and   lower(replace(isnull(nf_ape_materno,''),' ', '')) = @w_ape_materno
and  (lower(replace(isnull(nf_nombre_razon_social,''),' ', '')) = @w_nombre or lower(replace(isnull(nf_nombre_razon_social,''),' ', '')) = @w_razon_social)

--Resultado - Retorno
if(@w_n_conicidencias=0)
    begin
		select @o_resultado  = 1
		update cobis..cl_ente_aux set ea_negative_file='N' where ea_ente=@i_ente
		print 'sp_negative_file-conicidencias==0-Resultado:' + convert(varchar(30), @o_resultado)
	end

if(@w_n_conicidencias = 1 OR @w_n_conicidencias > 1 )
	begin
		select @o_resultado  = 3
		update cobis..cl_ente_aux set ea_negative_file='S' where ea_ente=@i_ente
		print 'sp_negative_file-conicidencias=1 o mayor que 1-#Coinicidencia:' + convert(varchar,@w_n_conicidencias) + '-Resultado:' + convert(varchar(30), @o_resultado)
	end

return 0

go
