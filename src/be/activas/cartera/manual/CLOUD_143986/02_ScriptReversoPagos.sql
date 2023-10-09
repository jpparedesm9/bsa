use cob_cartera
go

declare 
@w_fecha_proceso  DATETIME,
@w_error          INT,
@w_secuencial     INT,
@w_secuencial_pag INT,
@w_secuencial_ing INT,
@w_banco          VARCHAR(32),
@w_grupo          INT,
@w_oficina        INT,
@w_ab_estado      VARCHAR(10),
@w_operacion      int

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

create table #reverso_pagos(
secuencial       int identity,
estado           varchar(3)  ,
secuencial_pago  int,
secuencial_ing   int,
operacion_hija   int)

select grupo     = tg_grupo, 
       operacion = max(op_operacion),
       secuencial = convert(int,0)
into #operacion_grupales
from cob_cartera..ca_operacion,
     cob_credito..cr_tramite_grupal
where op_cliente in (7881)
and   op_estado  = 3
and   op_banco   = tg_referencia_grupal
and   op_cliente = tg_grupo
group by tg_grupo


update #operacion_grupales set 
secuencial = 449054
where grupo = 7881

select * from #operacion_grupales

select *
into #secuencial_abonos
from cob_cartera..ca_corresponsal_trn,
     #operacion_grupales
where co_codigo_interno = operacion
and   co_secuencial      > secuencial
and   co_estado          = 'P'
and   co_accion          = 'I'
order by co_codigo_interno, co_secuencial


select * from #secuencial_abonos

insert into #reverso_pagos(
                  estado , secuencial_pago  , secuencial_ing   , operacion_hija)
select distinct ab_estado, ab_secuencial_pag, ab_secuencial_ing, ab_operacion   
from #secuencial_abonos,
     cob_cartera..ca_corresponsal_det,
     cob_cartera..ca_abono
where co_secuencial     = cd_secuencial     
and   cd_operacion      = ab_operacion
and   cd_sec_ing        = ab_secuencial_ing
and   ab_estado        not in ('RV', 'E')
order by ab_operacion, ab_secuencial_pag desc

select * from #reverso_pagos

update cobis..cl_parametro set 
pa_char = 'N'
where pa_nemonico = 'PAVACA'
and pa_producto = 'CCA'


SELECT @w_secuencial = 0,
       @w_banco = '', 
       @w_oficina = 0

WHILE 1=1
BEGIN

   SELECT TOP 1 
          @w_secuencial     = secuencial     ,
          @w_ab_estado      = estado    ,
          @w_secuencial_pag = secuencial_pago,
          @w_secuencial_ing = secuencial_ing ,
          @w_operacion      = operacion_hija
     FROM #reverso_pagos 
    WHERE secuencial          > @w_secuencial
    ORDER BY secuencial ASC 
   
   IF @@ROWCOUNT = 0
   BEGIN
      break   
   END
   
   select @w_banco    = op_banco   ,
          @w_oficina  = op_oficina     
   from ca_operacion
   where op_operacion = @w_operacion

   BEGIN TRY
   IF @w_ab_estado = 'A'
   BEGIN
	      PRINT '@w_banco1 ' + @w_banco
	      PRINT '@w_secuencial_ing1 ' + convert(VARCHAR,@w_secuencial_ing) + '  PAG ' + convert(VARCHAR,@w_secuencial_pag)
	      exec @w_error = sp_fecha_valor 
		       @s_date       = @w_fecha_proceso,
			   @s_user       = 'usrbatch',
			   @s_term       = 'consola',
			   @t_trn        = 7049,
			   @i_fecha_mov  = @w_fecha_proceso,
			   @i_banco      = @w_banco,
			   @i_secuencial = @w_secuencial_pag,
			   @i_operacion  = 'R',
			   @s_ofi        = @w_oficina
   END
   ELSE
   BEGIN
	   PRINT '@w_banco2 ' + @w_banco
	   PRINT '@w_secuencial_ing2 ' + convert(VARCHAR,@w_secuencial_ing) + '  PAG ' + convert(VARCHAR,@w_secuencial_pag)
	   
	      exec @w_error           = sp_eliminar_pagos
	           @s_ssn             = 101,
	           @s_srv             = 'srv',
	           @s_date            = @w_fecha_proceso,
	           @s_user            = 'usrbatch',
	           @s_term            = 'consola',
	           @s_ofi             = @w_oficina,
	           @i_banco           = @w_banco,
	           @i_operacion       = 'D',
	           @i_secuencial_ing  = @w_secuencial_ing,
	           @i_en_linea        = 'N',
	           @i_pago_ext        = 'N'
   END
	   if @w_error <> 0 
	   BEGIN
	      print '@w_error: ' + convert(varchar,@w_error)	     
	   END
	   ELSE
	   begin
	     print 'Actualizacion OK: ' 
	   end		
    END TRY
	BEGIN CATCH   
			 print 'Actualizacion Error 2 '
	END CATCH   
END -- while
PRINT 'FIN'


SELECT 'VALIDACION DE PAGOS'
SELECT ab_estado, operacion_hija, ab_secuencial_ing, ab_secuencial_pag
  from ca_abono,
       #reverso_pagos
 where ab_operacion      = operacion_hija 
   AND ab_secuencial_ing = secuencial_ing
   

update cobis..cl_parametro set 
pa_char = 'S'
where pa_nemonico = 'PAVACA'
and pa_producto   = 'CCA'

