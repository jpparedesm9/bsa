use cobis
go

select *
from cobis..cl_errores
where numero in (724589, 724591)

if not exists(select 1 from cobis..cl_errores where numero = 724589)
   insert into cl_errores (numero, severidad, mensaje)
                   values (724589, 0        , 'No se puede reversar transaccion, contiene pagos con sobrantes')

if not exists(select 1 from cobis..cl_errores where numero = 724591)
   insert into cl_errores (numero, severidad, mensaje)
                   values (724591, 0        , 'No se puede reversar transaccion, operacion cancelada')


select *
from cobis..cl_errores
where numero in (724589, 724591)

go

/**********************************************************/
/* Parametro Reverso                                      */
/**********************************************************/


select *
from cobis..cl_parametro 
where pa_nemonico = 'PAVACA'


if not exists(select 1
              from  cobis..cl_parametro 
              where pa_nemonico = 'PAVACA')
begin              
     insert into cl_parametro (pa_parametro                         , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
                       values ('PARAMETRO VALIDA REVERSO CANCELADAS', 'PAVACA'  , 'C'    , 'S'    , NULL      , NULL       , NULL  , NULL    , NULL       , NULL    , 'CCA')
end

select *
from cobis..cl_parametro 
where pa_nemonico = 'PAVACA'
