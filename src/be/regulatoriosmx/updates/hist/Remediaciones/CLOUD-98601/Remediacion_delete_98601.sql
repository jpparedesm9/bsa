USE cob_credito
GO
	  
IF OBJECT_ID ('dbo.cr_tramite_grupal_tmp_98601') IS NULL
begin	  
    print 'Crea tabla' 
    CREATE TABLE cr_tramite_grupal_tmp_98601
    	(
    	tg_tramite           INT NOT NULL,
    	tg_grupo             INT NOT NULL,
    	tg_cliente           INT NOT NULL,
    	tg_monto             MONEY NOT NULL,
    	tg_grupal            CHAR (1) NOT NULL,
    	tg_operacion         INT NOT NULL,
    	tg_prestamo          VARCHAR (15) NOT NULL,
    	tg_referencia_grupal VARCHAR (15) NOT NULL,
    	tg_cuenta            VARCHAR (45),
    	tg_cheque            INT,
    	tg_participa_ciclo   CHAR (1),
    	tg_monto_aprobado    MONEY,
    	tg_ahorro            MONEY,
    	tg_monto_max         MONEY,
    	tg_bc_ln             CHAR (10),
    	tg_incremento        NUMERIC (8, 4),
    	tg_monto_ult_op      MONEY,
    	tg_monto_max_calc    MONEY,
    	tg_nueva_op          INT,
    	tg_monto_min_calc    MONEY
    	)
END 
ELSE
begin
    print 'ya existe tabla'
end

declare @w_tramite int, @w_grupo int, @w_cliente int
select @w_tramite = 2010, @w_grupo = 7, @w_cliente = 103
		       
print 'Antes de insertar'
if not exists (SELECT 1 FROM cob_credito..cr_tramite_grupal_tmp_98601 
           WHERE tg_tramite = @w_tramite 
           AND tg_grupo     = @w_grupo 
           AND tg_cliente   = @w_cliente)
BEGIN
    print 'Inserta el registro en tabla _tmp' 
    INSERT INTO cr_tramite_grupal_tmp_98601
    SELECT * FROM cob_credito..cr_tramite_grupal 
    WHERE tg_tramite = @w_tramite 
    AND tg_grupo     = @w_grupo 
    AND tg_cliente   = @w_cliente
END
ELSE
BEGIN
    print 'Ya existe registro en tabla _tmp' 
END

delete cob_credito..cr_tramite_grupal
WHERE tg_tramite = @w_tramite 
AND tg_grupo     = @w_grupo
AND tg_cliente   = @w_cliente

SELECT * FROM cr_tramite_grupal WHERE tg_tramite = @w_tramite 
                                AND tg_grupo     = @w_grupo 
                                AND tg_cliente   = @w_cliente            
SELECT * FROM cr_tramite_grupal_tmp_98601 WHERE tg_tramite = @w_tramite 
                                AND tg_grupo     = @w_grupo 
                                AND tg_cliente   = @w_cliente 