USE cob_cartera
GO


-- PARAMETRO SENSIBILIDAD PARA LIMITES EN DISTRIBUCION DE PAGOS 
select w_sensibilidad = pa_float
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'SENSI'
and    pa_producto = 'CCA'

update cobis..cl_parametro 
set pa_float  = '5.0'
where pa_nemonico = 'SENSI'
and pa_producto = 'CCA'

-- PARAMETRO SENSIBILIDAD PARA LIMITES EN DISTRIBUCION DE PAGOS 
select w_sensibilidad = pa_float
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'SENSI'
and    pa_producto = 'CCA'


CREATE TABLE #grupos (grupo INT)
CREATE TABLE #pagos_g  ( banco cuenta,operacion INT, secuencial INT, referencia varchar(64))

GO
--insert into #grupos values(127)
insert into #grupos values(228)
insert into #grupos values(226)
insert into #grupos values(164)


GO

DECLARE
@w_grupo          INT,
@w_operacionca    INT,
@w_error          INT,
@w_fecha_proceso  DATETIME,
@w_referencia     VARCHAR(64),
@w_banco          VARCHAR(24),
@w_secuencial_pag INT,
@w_secuencial     INT,
@w_fecha_valor    datetime

SELECT @w_grupo = 0
select @w_referencia = ''

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

WHILE 1=1 
BEGIN

   SET ROWCOUNT 1
   
   SELECT @w_grupo = grupo
   FROM #grupos
   WHERE grupo > @w_grupo
   ORDER BY grupo
   
   IF @@ROWCOUNT = 0 
   BEGIN   
      SET ROWCOUNT 0
      BREAK
   END
   
   SET ROWCOUNT 0
   
   SELECT @w_operacionca = 0
   select 'PROCESANDO GRUPO '= @w_grupo
   
   TRUNCATE TABLE #pagos_g
   
   
   
   INSERT INTO #pagos_g
   SELECT cd_banco, cd_operacion, max(cd_sec_ing), max(cd_referencia)
   FROM ca_corresponsal_det
   WHERE cd_operacion IN (SELECT dc_operacion FROM ca_det_ciclo WHERE dc_grupo = @w_grupo )
   AND cd_referencia LIKE 'PG%'
   group by cd_banco, cd_operacion
   
   SELECT @w_referencia = max(referencia) FROM #pagos_g
   SELECT @w_fecha_valor =  max(co_fecha_valor) FROM ca_corresponsal_trn WHERE co_referencia= @w_referencia
   
   SELECT * FROM #pagos_g
   
   WHILE 2=2
   BEGIN

      SET ROWCOUNT 1   
   
      SELECT @w_banco       =banco, 
             @w_operacionca = operacion, 
             @w_secuencial  = secuencial, 
             @w_referencia  = referencia
      FROM #pagos_g
      WHERE  operacion > @w_operacionca
      ORDER BY operacion
      
      IF @@ROWCOUNT =0
      BEGIN
         SET ROWCOUNT 0
         break
      END
      
      SET ROWCOUNT 0   
      select @w_secuencial_pag = ab_secuencial_pag
      from ca_abono 
      where ab_secuencial_ing = @w_secuencial
      and ab_operacion        = @w_operacionca
      AND ab_estado = 'A'
      
	  if @@ROWCOUNT =0
	   continue
	   
      --APLICAR REVERSOS  
	  select 'Prestamo procesado' = @w_banco , 'secuencial del pago ' = @w_secuencial_pag 
      exec @w_error = sp_fecha_valor 
      @s_date        = @w_fecha_proceso,
      @s_user        = 'usrbatch',
      @s_term        = 'consola',
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha_proceso,
      --@i_fecha_valor = @w_fecha_pro,
      @i_banco       = @w_banco,
      @i_secuencial  = @w_secuencial_pag,
      @i_operacion   = 'R'

      if @w_error <> 0 
	  begin
         select 'Error al ejecutar sp_fecha_valor' = @w_error 
		 goto SIGUIENTE_GRUPO
      end

   end   
   
   --ACTUALIZAR ESTADO 
   
   select 'Referencia  ' = @w_referencia, 'fecha valor' =  @w_fecha_valor

   
   UPDATE ca_corresponsal_trn SET co_estado  ='I', co_error_msg ='' 
   WHERE co_referencia = @w_referencia and co_fecha_valor  = @w_fecha_valor

   select * from ca_corresponsal_trn where co_referencia = @w_referencia and co_fecha_valor  = @w_fecha_valor   

   SIGUIENTE_GRUPO:
      
end

EXEC @w_error = sp_pagos_corresponsal_batch
   @i_param1 = 'B'

IF @w_error <>0
   select 'Error al ejecutar sp_pagos_corresponsal_batch ' = @w_error

select * from ca_corresponsal_trn where co_fecha_valor  = @w_fecha_valor AND co_tipo = 'P' AND co_estado <>'P'

GO
   
DROP TABLE #grupos
DROP TABLE #pagos_g

go


