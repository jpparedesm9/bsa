use cobis
go

IF OBJECT_ID ('dbo.caso151387_tmp') IS NOT NULL
    DROP TABLE dbo.caso151387_tmp
GO

create table caso151387_tmp(
    ib_cliente int,
    ib_fecha   datetime
)

insert caso151387_tmp
select ib_cliente, ib_fecha
from cob_credito..cr_interface_buro
where ib_cliente in (94650,94652,96689,98165,
98175,101038,101173,101400,102173,102181,102187,102778,
60726,61567,62231,62251,96570,96623,137160,137166,
137191,137203,137218,137234,137244,137780,102846,102856,
102922,102927,103020,103031,103068,103510)
ORDER BY ib_cliente

select 'antes', ea_fecha_report, * from cobis..cl_ente_aux,  caso151387_tmp
where  ea_ente =  ib_cliente ORDER BY ib_cliente

update cobis..cl_ente_aux
set ea_fecha_report = convert(date,ib_fecha,103)
from caso151387_tmp
where ib_cliente = ea_ente

select 'desp', ea_fecha_report, * from cobis..cl_ente_aux,  caso151387_tmp
where  ea_ente =  ib_cliente ORDER BY ib_cliente

go
