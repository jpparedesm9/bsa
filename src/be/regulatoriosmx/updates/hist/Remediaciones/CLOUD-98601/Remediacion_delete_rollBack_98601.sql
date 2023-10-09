USE cob_credito
GO

declare @w_tramite int, @w_grupo int, @w_cliente int
select @w_tramite = 2010, @w_grupo = 7, @w_cliente = 103
		       
if not exists (SELECT 1 FROM cob_credito..cr_tramite_grupal 
               WHERE tg_tramite = @w_tramite 
               AND tg_grupo     = @w_grupo 
		       AND tg_cliente   = @w_cliente)
    BEGIN
        print 'Inserta el registro en tabla' 
        INSERT INTO cr_tramite_grupal
        SELECT * FROM cob_credito..cr_tramite_grupal_tmp_98601 
        WHERE tg_tramite = @w_tramite 
        AND tg_grupo     = @w_grupo 
        AND tg_cliente   = @w_cliente
    END
    ELSE
    BEGIN
        print 'ya existe registro en tabla' 
    end

SELECT * FROM cr_tramite_grupal WHERE tg_tramite = @w_tramite 
                                AND tg_grupo     = @w_grupo 
                                AND tg_cliente   = @w_cliente            
SELECT * FROM cr_tramite_grupal_tmp_98601 WHERE tg_tramite = @w_tramite 
                                AND tg_grupo     = @w_grupo 
                                AND tg_cliente   = @w_cliente	