use cobis
go

delete from cobis..cl_parametro
where pa_nemonico='CPSATC'
and pa_producto='REC'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLAVE DE PRODUCTO SAT COMPLEMENTO', 'CPSATC', 'C', '84111506', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')


select * from cobis..cl_parametro
where pa_nemonico='CPSATC'
and pa_producto='REC'

go

use cobis
go

select * from cl_parametro where pa_nemonico = 'NUFAEM'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NUFAEM')
begin
   insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo,   pa_int,  pa_producto)
   values ('NUMERO FACTURAS EMPAQUETAR'  , 'NUFAEM'   , 'I'    ,   10000 ,  'ADM')
end

select  top 1 * from cl_parametro where pa_nemonico = 'NUFAEM'



select * from cl_parametro where pa_nemonico = 'NOPAFA'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NOPAFA')
begin
   insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char  , pa_producto)
   values ('NOMBRE PAQUETE FACTURAS'         , 'NOPAFA'   , 'C'    , 'BSA_I_1', 'ADM')
end

select * from cl_parametro where pa_nemonico = 'NOPAFA'



select * from cl_parametro where pa_nemonico = 'NOPACO'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NOPACO')
begin
   insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char  , pa_producto)
   values ('NOMBRE PAQUETE COMPLEMENTOS'         , 'NOPACO'   , 'C'    , 'BSA_C_1', 'ADM')
end

select * from cl_parametro where pa_nemonico = 'NOPACO'


use cobis
go

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'

insert into dbo.cl_seqnos (bdatos, tabla, siguiente) values ('cob_conta_super', 'sb_facturacion', 207)

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'

insert into dbo.cl_seqnos (bdatos, tabla, siguiente) values ('cob_conta_super', 'sb_facturacion_complemento', 114)


select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'
select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'

use cobis
go

delete from cobis..cl_parametro where pa_nemonico='SMCLP' and pa_producto='REC'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SIMULACION COMPLEMENTO PAGO', 'SMCLP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')

select * from cobis..cl_parametro where pa_nemonico='SMCLP' and pa_producto='REC'

go