USE cob_cartera
GO

DECLARE 
@w_fecha_proceso  DATETIME,
@w_error          INT,
@w_secuencial     INT,
@w_secuencial_des INT,
@w_secuencial_ing INT,
@w_banco          VARCHAR(32),
@w_grupo          INT,
@w_oficina        INT,
@w_ab_estado      VARCHAR(10),
@w_operacion      int,
@w_fecha_valor    datetime


SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

create table #operaciones
( secuencial  INT IDENTITY,
  grupo       INT 		   NULL,
  operacion   int          null,
  banco       varchar(20)  NULL,
  oficina     INT          null,
  monto_total MONEY        NULL,
  fecha_valor DATETIME     NULL,
  procesa     char(1)      null)


CREATE INDEX #operaciones_idx
ON #operaciones (operacion)


INSERT into   #operaciones
select 'grupo' = tg_grupo,        
       'operacion' = op_operacion,
       'banco' = op_banco,
       'oficina' = op_oficina,
       'monto_total' = sum(op_cuota),
       'fecha_valor' = '06/30/2020',
       'procesa' = 'N'
from   cob_credito..cr_tramite_grupal,
       ca_operacion
where  tg_operacion         = op_operacion
AND    tg_participa_ciclo   = 'S' 
AND    tg_monto > 0
AND    tg_prestamo <> tg_referencia_grupal
AND    tg_grupo in (7881 )
AND    op_estado not in (0,3,6) 
group  BY tg_grupo, op_operacion, op_banco,op_oficina
order  by tg_grupo


SELECT * FROM #operaciones
SELECT @w_secuencial = 0

--BEGIN TRAN
while 1 = 1
begin
  select top 1
      @w_secuencial = secuencial,
      @w_operacion = operacion,
      @w_banco     = banco,
      @w_oficina   = oficina,
      @w_grupo     = grupo,
      @w_fecha_valor = fecha_valor
   from #operaciones
   where secuencial > @w_secuencial
   and   procesa = 'N'
   ORDER BY secuencial
         
   if @@ROWCOUNT = 0
      break
				     
    select 'Grupo'     = @w_grupo    ,
          'Operacion' = @w_operacion,
          'Banco'     = @w_banco,
          'Fecha'     = @w_fecha_valor
          
begin try

   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = @w_oficina,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_valor,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'            
       
      
       
     if @w_error <> 0
      BEGIN
         SELECT @w_error
		 select 	'Error al ejecutar sp_fecha_valor ATRAS ' = @w_error , 
			    	'Banco ' = @w_banco 
   			
		 update #operaciones
		 set    procesa = 'N'
		 where  operacion = @w_operacion
				
		 goto SIGUIENTE
      end 			
      select 'PARTE 1 GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' OP: '+convert(VARCHAR, @w_operacion)
	  update #operaciones
      set    procesa = 'S'
	  where  operacion = @w_operacion
   END TRY
   BEGIN CATCH
	  update #operaciones
	  set    procesa = 'N'
	  where  operacion = @w_operacion
	  
	  PRINT 'Termina: '+ convert (VARCHAR,@w_error)
	  --PRINT 'Termina: '+ convert (VARCHAR,@w_error)
				
	  goto SIGUIENTE
   END CATCH

   SIGUIENTE:		
END


SELECT * FROM #operaciones

SELECT op_fecha_ult_proceso,op_operacion, op_banco
FROM ca_operacion,
     #operaciones
WHERE op_operacion = operacion


select ab_estado, *
from ca_abono, #operaciones
where operacion = ab_operacion
order by ab_fecha_pag




--ROLLBACK TRAN
go