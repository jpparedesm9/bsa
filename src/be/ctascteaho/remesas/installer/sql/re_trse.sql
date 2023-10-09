use cob_remesas
go

/* re_ts_causales_impuestos */
set ANSI_NULLS OFF
go
set QUOTED_IDENTIFIER OFF
go

CREATE VIEW re_ts_causales_impuestos (
            secuencial, tipo_transaccion, fecha, causa, referencia,
            usuario, terminal, oficina, producto, hora)
as
select  ts_secuencial,
        ts_tipo_transaccion,
        ts_tsfecha,
        ts_char5,
        ts_varchar7,
        ts_login,
        ts_terminal,
        ts_oficina,
        ts_tinyint1,
        ts_datetime1
  from  re_tran_servicio
  where ts_tipo_transaccion in (698, 699, 701)

go

/* ts_par_perfil */
set ANSI_NULLS OFF
go
set QUOTED_IDENTIFIER OFF
go
create view ts_par_perfil
(
    secuencial,  tipo_transaccion, oficina,   usuario,
    terminal,    nodo,             operacion, clase,
    fecha_proc,  fecha_sis,        sec_reg,   producto,
    transaccion, perfil,           tipo_trn
)
as
select ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_operador,
       ts_terminal,   ts_nodo,             ts_origen,  ts_clase,
       ts_tsfecha,    ts_datetime1,        ts_int1,    ts_tinyint1,
       ts_smallint1,  ts_varchar2,         ts_varchar4
from   re_tran_servicio
where  ts_tipo_transaccion in (720, 721)

go

