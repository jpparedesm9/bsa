
use cob_credito
go


set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @w_cli_apellidos   varchar(64) = 'nombre1369',
        @w_cli_nombres     varchar(128)= 'apellido1369',
        @w_n_conicidencias int = 2

SELECT @w_n_conicidencias=count(*) FROM cob_credito..cr_lista_negra 
WHERE lower(replace(ln_nombre,' ', ''))              =@w_cli_nombres
AND   lower(replace(isnull(ln_apellidos,''),' ', ''))=isnull( @w_cli_apellidos,'')

go

--select top 10   FROM cob_credito..cr_lista_negra 