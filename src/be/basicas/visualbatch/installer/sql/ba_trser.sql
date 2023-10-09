/*                            */
/*      Transaccion de Servicios    */
/*                            */

use cobis
go

/* ba_tran_servicio */
print 'ba_tran_servicio'
go

if exists (select 1 from sysobjects where name = 'ba_tran_servicio')
    drop TABLE ba_tran_servicio
go

create table ba_tran_servicio (
       ts_secuencial         int           not null,
       ts_tipo_transaccion   smallint      not null,
       ts_clase              char(1)       not null,
       ts_fecha              datetime      null,
       ts_usuario            login         null,
       ts_terminal           descripcion   null,
       ts_correccion         char(1)       null,
       ts_ssn_corr           int           null,
       ts_reentry            char(1)       null,
       ts_origen             char(1)       null,
       ts_nodo               varchar(30)   null,
       ts_remoto_ssn         int           null,
       ts_oficina            smallint      null,
       ts_batch              int           null,
       ts_sarta              int           null,
       ts_nombre             descripcion   null,
       ts_descripcion        varchar(255)  null,
       ts_lenguaje           char(2)       null,
       ts_fecha_creacion     datetime      null,
       ts_producto           tinyint       null,
       ts_tipo_batch         char(1)       null,
       ts_sec_corrida        smallint      null,
       ts_ente_procesado     descripcion   null,
       ts_arch_resultado     descripcion   null,
       ts_arch_fuente        descripcion   null,
       ts_secuencial_sb      smallint      null,
       ts_dependencia        smallint      null,
       ts_frec_reg_proc      int           null,
       ts_login              varchar(10)   null,
       ts_acceso             char(1)       null
)
go

CREATE UNIQUE CLUSTERED INDEX ba_trser_Key ON ba_tran_servicio (
       ts_secuencial,
       ts_tipo_transaccion,
       ts_clase)
WITH FILLFACTOR = 60
go


/**************************************************/
print 'Vista: ts_batch'
go

if exists (select 1 from sysobjects where name = 'ts_batch')
    drop view ts_batch
go

create view ts_batch (
       secuencial,  tipo_transaccion, clase,          fecha,       usuario,        terminal, oficina,
       batch,       nombre,           descripcion,    lenguaje,    fecha_creacion, producto, tipo_batch,
       sec_corrida, ente_procesado,   arch_resultado, arch_fuente, frec_reg_proc
)
as
select ts_secuencial,    ts_tipo_transaccion,   ts_clase,       ts_fecha,          ts_usuario,        ts_terminal,   
       ts_oficina,       ts_batch,              ts_nombre,      ts_descripcion,    ts_lenguaje,       ts_fecha_creacion,
       ts_producto,      ts_tipo_batch,         ts_sec_corrida, ts_ente_procesado, ts_arch_resultado, ts_arch_fuente,
       ts_frec_reg_proc
  from ba_tran_servicio
 where ts_tipo_transaccion in (8001, 8002, 8003, 8004, 8005, 8006, 8007)
go

/**************************************************/
print 'Vista: ts_sarta'
go

if exists (select 1 from sysobjects where name = 'ts_sarta')
    drop view ts_sarta
go

create view ts_sarta (
       secuencial, tipo_transaccion, clase,       fecha,          usuario,         terminal,
       oficina,    sarta,            nombre,      descripcion,    fecha_creacion,  creador
) 
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,   ts_fecha,       ts_usuario,        ts_terminal,
       ts_oficina,    ts_batch,            ts_nombre,  ts_descripcion, ts_fecha_creacion, ts_arch_fuente
  from ba_tran_servicio
 where ts_tipo_transaccion in (8011, 8012, 8013, 8014, 8015, 8016, 8017)
go

/**************************************************/
print 'Vista: ts_sarta_batch'
go

if exists (select * from sysobjects where name = 'ts_sarta_batch')
    drop view ts_sarta_batch
go

create view ts_sarta_batch (
       secuencial,   tipo_transaccion,   clase,   fecha,          usuario,     terminal,
       oficina,      sarta,              batch,   sb_secuencial,  dependencia)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,        ts_fecha,         ts_usuario,     ts_terminal,
       ts_oficina,    ts_batch,            ts_sec_corrida,  ts_secuencial_sb, ts_dependencia
  from ba_tran_servicio 
 where ts_tipo_transaccion in (8021, 8022, 8023, 8025, 8027)
go

/**************************************************/
print 'Vista: ts_batch_param'
go

if exists (select * from sysobjects where name = 'ts_batch_param')
    drop view ts_batch_param
go

create view ts_batch_param (
       secuencial,    tipo_transaccion,   clase,      fecha,      usuario,    terminal,   oficina,
       sarta,         batch,              ejecucion,  parametro,  nombre,     tipo,       valor)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,       ts_fecha,         ts_usuario, ts_terminal,   ts_oficina,
       ts_sarta,      ts_batch,            ts_sec_corrida, ts_secuencial_sb, ts_nombre,  ts_tipo_batch, ts_ente_procesado 
  from ba_tran_servicio 
 where ts_tipo_transaccion in (8031, 8032, 8033, 8035, 8036)
go

/**************************************************/
print 'Vista: ts_lectura'
go

if exists (select * from sysobjects where name = 'ts_lectura')
    drop view ts_lectura
go

create view ts_lectura (
       secuencial,    tipo_transaccion,    clase,    fecha,   usuario,  terminal,
       oficina,       batch,               tipo,     rol,     login,    acceso)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,       ts_fecha,  ts_usuario, ts_terminal,
       ts_oficina,    ts_batch,            ts_tipo_batch,  ts_sarta,  ts_login,   ts_acceso
  from ba_tran_servicio 
 where ts_tipo_transaccion in (8061, 8062, 8063)
go
