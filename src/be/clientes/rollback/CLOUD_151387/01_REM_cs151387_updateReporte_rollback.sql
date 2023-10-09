use cobis
go

select 'antes_rollback', ea_fecha_report, * from cobis..cl_ente_aux,  caso151387_tmp
where  ea_ente =  ib_cliente ORDER BY ib_cliente

update cobis..cl_ente_aux
set ea_fecha_report = convert(date,ib_fecha,103)
from caso151387_tmp
where ib_cliente = ea_ente

select 'desp_rollback', ea_fecha_report, * from cobis..cl_ente_aux,  caso151387_tmp
where  ea_ente =  ib_cliente ORDER BY ib_cliente

IF OBJECT_ID ('dbo.caso151387_tmp') IS NOT NULL
    DROP TABLE dbo.caso151387_tmp

go
