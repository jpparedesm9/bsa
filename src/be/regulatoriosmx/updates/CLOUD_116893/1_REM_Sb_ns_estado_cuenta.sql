use cob_conta_super
go
---Actualizo todos los registros  a T
UPDATE cob_conta_super..sb_ns_estado_cuenta
SET nec_estado='T'
WHERE nec_estado='P'


DECLARE
@num_codigo_rfc           INT,
@num_operacion_rfc varchar(24),
@rfc_ente          varchar(30),
@codigo_tabla      INT

declare @operaciones_rfc
table(
    codigo              int identity,
    operation           varchar(24),
    rfc_ente            varchar(30),
    codigo_tabla        int 

    )
    
    
insert into @operaciones_rfc
select  nec_banco,in_cliente_rfc,nec_codigo
from cob_conta_super..sb_ns_estado_cuenta 
where nec_banco IN
(210370018769,
 210320011633,
 210320014363,
 224040033891,
 224040033909
)

SELECT * FROM @operaciones_rfc

select @num_codigo_rfc = 0

	   while (1 = 1) 
	   begin
         select  TOP 1 @num_operacion_rfc = operation ,
                       @rfc_ente          = rfc_ente,
                       @codigo_tabla      = codigo_tabla,
                       @num_codigo_rfc    =codigo  
	     from @operaciones_rfc 
	     where codigo > @num_codigo_rfc 
	     order by codigo asc
		 
         if @@rowcount = 0 BREAK
         
         PRINT '@codigo_tabla'+ convert(VARCHAR(50),@codigo_tabla)
         UPDATE cob_conta_super..sb_ns_estado_cuenta 
         SET nec_estado='P'
         WHERE nec_codigo=@codigo_tabla
         
         END--fin while
--- select de los registros a procesar 
       select *
       from cob_conta_super..sb_ns_estado_cuenta 
       where nec_estado='P'   

go