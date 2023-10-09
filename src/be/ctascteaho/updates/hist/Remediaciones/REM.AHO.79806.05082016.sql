/* ************************************************************************* */
--                  Historia: 79806
--            Título del Bug: AHO-H79806-Provisión de Intereses Paramétrica
--                     Fecha: 05/Agosto/2016
--  Descripción del Problema: No existe Pago Interes Saldo Promedio para producto menor de edad
--Descripción de la Solución: Se inserta los datos en la tabla pe_var_servicio, pe_costo y pe_servicio_per
--                     Autor: Ignacio Yupa
/* ************************************************************************* */

use cob_remesas
go

DELETE  pe_var_servicio WHERE vs_descripcion = 'PAGO INT SALDO PROMEDIO DISP'
INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
VALUES (4, '23', 'PAGO INT SALDO PROMEDIO DISP', 'V', '+', 'M')
GO

Declare @w_return INt,
        @w_tipo_rango_pro int,
        @w_pro_final      int,
        @w_grupo_rango    int,
        @w_ser_per        int,
        @w_rubro          varchar(5),
        @w_servicio_disponible int,
        @w_costo   int,
        @w_fecha_proceso         datetime,
        @w_tipo_rango       INt        

SELECT @w_fecha_proceso = fp_fecha 
FROM cobis..ba_fecha_proceso          
        
IF not exists(SELECT 1 FROM cob_remesas..pe_tipo_rango 
              WHERE tr_descripcion = 'RUBRO SOBRE PROMEDIO DISPONIBLE')    
BEGIN
    exec @w_return = cobis..sp_cseqnos
         @i_tabla     = 'pe_tipo_rango',
         @o_siguiente = @w_tipo_rango_pro out
    IF @w_return <> 0
    BEGIN
     PRINT 'Error en la obtencion de secuencial pe_tipo_rango'
    END
   
INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (@w_tipo_rango_pro, 'RUBRO SOBRE PROMEDIO DISPONIBLE', 'E', 0, 'V')    
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_tipo_rango'
END
END
ELSE
BEGIN
SELECT @w_tipo_rango_pro = tr_tipo_rango FROM cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE PROMEDIO DISPONIBLE'
END

SELECT @w_tipo_rango = tr_tipo_rango 
FROM cob_remesas..pe_tipo_rango
WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'

select @w_pro_final = pf_pro_final 
from cob_remesas..pe_pro_final 
where pf_descripcion = 'PRODUCTO CUENTA AHORROS MENOR EDAD'

SELECT @w_grupo_rango = ra_grupo_rango 
FROM cob_remesas..pe_rango 
WHERE ra_tipo_rango = 1 
AND ra_desde = 0 
AND ra_hasta = 99999999999999

DELETE FROM cob_remesas..pe_costo 
WHERE co_servicio_per IN ( SELECT sp_servicio_per
                           FROM  cob_remesas..pe_servicio_per 
                           WHERE sp_pro_final = @w_pro_final)
IF @@error != 0
    BEGIN
      PRINT 'Error en la eliminacion de registro en pe_costo'
    END      

DELETE FROM cob_remesas..pe_servicio_per WHERE sp_pro_final = @w_pro_final
IF @@error != 0
    BEGIN
      PRINT 'Error en la eliminacion de registro en pe_servicio_per'
    END

exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_servicio_per'
END
    
SELECT @w_rubro = vs_rubro 
FROM cob_remesas..pe_var_servicio 
WHERE vs_descripcion = 'MONTO MINIMO APERTURA CUENTA DE AHORROS'

SELECT @w_servicio_disponible = sd_servicio_dis 
FROM cob_remesas..pe_servicio_dis 
WHERE sd_nemonico = 'MMAP'

INSERT INTO cob_remesas..pe_servicio_per 
        (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES  (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_servicio_per'
END


exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_costo'
END

INSERT INTO cob_remesas..pe_costo 
        (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES  (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_costo'
END
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_servicio_per'
END   

SELECT @w_rubro = vs_rubro 
FROM cob_remesas..pe_var_servicio 
WHERE vs_descripcion = 'SERVICIO SALDO MINIMO DE LA CUENTA'

SELECT @w_servicio_disponible = sd_servicio_dis 
FROM cob_remesas..pe_servicio_dis 
WHERE sd_nemonico = 'SMC'

INSERT INTO cob_remesas..pe_servicio_per 
        (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES  (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_servicio_per'
END

exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_costo'
END

INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_costo'
END
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_servicio_per'
END
    
SELECT @w_rubro = vs_rubro 
FROM cob_remesas..pe_var_servicio 
WHERE vs_descripcion = 'SERVICIO SALDO MAXIMO DE LA CUENTA'

INSERT INTO cob_remesas..pe_servicio_per 
        (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES  (@w_pro_final, @w_servicio_disponible,@w_rubro , @w_ser_per, @w_tipo_rango, @w_grupo_rango)
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_servicio_per'
END
        
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_costo'
END

INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser')  
  IF @@error != 0
        BEGIN
        PRINT 'Error en la inserccion de registro en pe_costo'
        END     

--
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_servicio_per',
      @o_siguiente = @w_ser_per out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_servicio_per'
END

SELECT @w_rubro = vs_rubro 
FROM cob_remesas..pe_var_servicio 
WHERE vs_descripcion = 'PAGO INT SALDO PROMEDIO DISP'

SELECT @w_servicio_disponible = sd_servicio_dis 
FROM cob_remesas..pe_servicio_dis 
WHERE sd_nemonico = 'PINT'

INSERT INTO cob_remesas..pe_servicio_per 
        (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES  (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_pro, @w_grupo_rango)
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_servicio_per'
END
  
exec @w_return = cobis..sp_cseqnos
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_costo out
IF @w_return <> 0
BEGIN
  PRINT 'Error en la obtencion de secuencial pe_costo'
END

INSERT INTO cob_remesas..pe_costo 
        (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES  (@w_costo, @w_ser_per, 'D', @w_tipo_rango_pro, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
IF @@error != 0
BEGIN
  PRINT 'Error en la inserccion de registro en pe_costo'
END