/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */

use cobis 
go
delete from cl_seqnos 
where tabla = 'ts_conexion_login'

insert into cl_seqnos 
        values ('cobis', 'ts_conexion_login', 0, 'secuencia')
        
        
go

drop  VIEW ts_conexion_login 
go
CREATE VIEW ts_conexion_login (
   usuario, terminal, fecha, autenticacion, id_estado_usuario , observacion, 
   secuencia, servidor,tipo_transaccion,clase
)
as
select ts.ts_user, ts.ts_term, ts.ts_fecha,  ts.ts_char, ts.ts_estado ,  ts.ts_desc_larga , 
    ts.ts_secuencia, ts_srv ,ts_tipo_transaccion ,ts_clase   
    from cobis..ad_tran_servicio ts
    where  ts_tipo_transaccion = 15417
go
        
