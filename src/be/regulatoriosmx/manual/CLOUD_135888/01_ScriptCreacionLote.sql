use cobis
go

select * from cobis..ba_sarta where sa_sarta = 23

insert into dbo.ba_sarta (sa_sarta, sa_nombre        , sa_descripcion                           , sa_fecha_creacion        , sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
                  values (23      , 'PROCESOS ESPEJO', 'LOTE PARA PROCESAMIENTO REPORTES ESPEJO', '2020-03-13 15:22:01.803', 'usrbatch', 8          , NULL          , NULL           )
go

select * from cobis..ba_sarta where sa_sarta = 23