/* ************************************************************************** */
/*  Archivo:            cr_parametria.sql                                  */
/*  Base de datos:      cr_parametria.sql                                  */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  Insercion de parametria ns_template para notificador                      */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 12-AGO-2019                JHCH            Emision Inicial B2C             */
/* ************************************************************************** */

use cobis
go

declare  @w_secuencial int
print 'Inicio de insercion NotificacionIntegranteGrupo '
if exists (select * from cobis..ns_template where te_nombre ='NotificacionIntegranteGrupo.xslt')
begin   
	delete from ns_template where te_nombre ='NotificacionIntegranteGrupo.xslt'
end

print 'Insertando NotificacionIntegranteGrupo'
select @w_secuencial=max(te_id)
from cobis..ns_template

insert into  cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre ,te_estado,te_version)    
    values(@w_secuencial+1,'XSLT' ,'NEUTRAL' ,'NotificacionIntegranteGrupo.xslt','A','1.0.0')        

print 'Fin de insercion NotificacionIntegranteGrupo'