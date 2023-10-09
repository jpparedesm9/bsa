/********************************************************************/
/* Fecha:   28-JUN-2017                                             */
/* Objeto:  Script de creacion de Tablas                            */
/* Formato: [2 iniciales modulo]_[nombre_tabla]                     */
/* Modulo:  COBIS Clientes                                          */
/********************************************************************/
use cob_sincroniza
go

if Object_id('si_tabla_control') != null
  drop table si_tabla_control
go

print 'si_tabla_control'
go

create table si_tabla_control
  (      
     tc_id_sync		     int identity,
     tc_id_entidad           int 				not null,
     tc_entidad              varchar(24) 		not null,
     tc_usuario              login 				not null, -- login del oficial
     tc_fecha                datetime 			not null,
     tc_nro_registros        int  			    not null,
     tc_estado               char(1) 			not null  --P (Pendiente)
  )

go

