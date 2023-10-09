USE cobis
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sp_cambio_oficial_borrar')
	DROP PROC sp_cambio_oficial_borrar
GO
	
CREATE PROC sp_cambio_oficial_borrar (
	@i_caso   INT,
	@i_grupo  INT,
	@i_ente   INT,
	@i_login_asesor_ini VARCHAR(32),
	@i_login_asesor_fin VARCHAR(32)
)
AS
DECLARE
	@w_oficina_ini INT,
	@w_oficina_fin INT,
	@w_cod_oficial_fin INT

SELECT 'CASO' = @i_caso

SELECT fu_oficina,fu_login, * FROM cobis..cl_funcionario WHERE fu_login IN ( @i_login_asesor_ini,@i_login_asesor_fin)

select  'OFICIAL' = 'INICIAL', fu_funcionario, oc_oficial          
from  cobis..cc_oficial, cobis..cl_funcionario
where  fu_login         = @i_login_asesor_ini
and  fu_funcionario   = oc_funcionario

select  'OFICIAL' = 'FINAL', fu_funcionario, oc_oficial          
from  cobis..cc_oficial,cobis..cl_funcionario
where  fu_login         = @i_login_asesor_fin
and  fu_funcionario   = oc_funcionario   


SELECT @w_oficina_ini = 0
SELECT @w_oficina_fin = 0

SELECT @w_oficina_ini = fu_oficina FROM cobis..cl_funcionario WHERE fu_login IN ( @i_login_asesor_ini)
SELECT @w_oficina_fin = fu_oficina FROM cobis..cl_funcionario WHERE fu_login IN ( @i_login_asesor_fin)

SELECT @w_oficina_ini = isnull(@w_oficina_ini , 0)
SELECT @w_oficina_fin = isnull(@w_oficina_fin , 0)

-- DATO INCONSISTENTE --> NO HACE NADA
IF @w_oficina_ini <= 0  OR @w_oficina_fin <= 0 
BEGIN
	SELECT '1. NO EXISTE OFICINAS --> no hace NADA'
	SELECT ' Oficina ini : ' + convert(VARCHAR, @w_oficina_ini)
	SELECT ' Oficina fin : ' + convert(VARCHAR, @w_oficina_fin)
	RETURN 0
END

select  @w_cod_oficial_fin = 0
select  @w_cod_oficial_fin = oc_oficial          
from  cobis..cc_oficial, cobis..cl_funcionario
where  fu_login         = @i_login_asesor_fin
and  fu_funcionario   = oc_funcionario

SELECT @w_cod_oficial_fin = isnull(@w_cod_oficial_fin , 0)

-- DATO INCONSISTENTE --> NO HACE NADA
IF @w_cod_oficial_fin <= 0
BEGIN
	SELECT '1. NO EXISTE OFICIAL --> no hace NADA'
	SELECT ' Oficial fin : ' + convert(VARCHAR, @w_cod_oficial_fin)
	RETURN 0
END


IF isnull(@i_ente, 0) > 0 
BEGIN
	SELECT ' INFORMACION DE PROSPECTOS'
	SELECT 'ANTES', c_funcionario, en_oficial, en_oficina,*
	from cobis..cl_ente,
	     cobis..cl_ente_aux
	where en_ente in(@i_ente )
	and   en_ente = ea_ente

	IF EXISTS(SELECT 1 FROM cobis..cl_ente WHERE en_ente = @i_ente)
	BEGIN
		UPDATE cobis..cl_ente 
		SET en_oficial    = @w_cod_oficial_fin,
		    c_funcionario = @i_login_asesor_fin,
		    en_oficina    = @w_oficina_fin
		WHERE en_ente     = @i_ente

		SELECT 'DESPUES', c_funcionario, en_oficial, en_oficina,*
		from cobis..cl_ente,
		     cobis..cl_ente_aux
		where en_ente in(@i_ente )
		and   en_ente = ea_ente

	END
	ELSE
		SELECT ' NO EXISTE CLIENTE --> ' =  @i_ente
		
	RETURN 0
END

IF isnull(@i_grupo, 0) > 0 
BEGIN
	SELECT ' INFORMACION DE GRUPOS'

	IF NOT EXISTS(SELECT 1 FROM cobis..cl_grupo WHERE gr_grupo = @i_grupo)
	BEGIN
		SELECT ' NO EXISTE GRUPO--> ' = @i_grupo
		RETURN 0
	END


	create table #cliente_grupo
	(cod_cliente int)
	
	create table #padre(
	p_tramite    INT,
	p_operacion  INT,
	p_banco      VARCHAR(32))

	create table #hijo(
	h_tramite    INT,
	h_operacion  INT,
	h_banco      VARCHAR(32))
	
	insert into #cliente_grupo (cod_cliente)
	select cg_ente
	from cobis..cl_cliente_grupo
	where cg_grupo  = @i_grupo
	and   cg_estado = 'V'

	INSERT INTO #padre
	SELECT 
		DISTINCT op_tramite, op_operacion, op_banco
	FROM cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion 
	WHERE tg_grupo = @i_grupo
	AND tg_tramite = op_tramite
	AND tg_grupo   = op_cliente
	

	INSERT INTO #hijo
	SELECT 
		DISTINCT op_tramite, op_operacion, op_banco
	FROM cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion 
	WHERE tg_grupo = @i_grupo
	AND tg_monto  > 0
	AND tg_participa_ciclo = 'S'
	AND tg_operacion = op_operacion
	AND tg_prestamo <> tg_referencia_grupal
	

	SELECT 'ANTES', gr_oficial , *
	FROM cobis..cl_grupo
	where gr_grupo = @i_grupo

	select 'ANTES', cg_oficial, *
	from cobis..cl_cliente_grupo
	where cg_grupo  = @i_grupo
	ORDER BY cg_estado , cg_ente

	SELECT 'ANTES', c_funcionario, en_oficial, en_oficina,*
	from cobis..cl_ente,
	     cobis..cl_ente_aux
	where en_ente IN (select cod_cliente from #cliente_grupo)
	and   en_ente = ea_ente

-------------

	--1--                  
	update cobis..cl_grupo
	set gr_oficial = @w_cod_oficial_fin
	where gr_grupo = @i_grupo
	
	--2--
	update cobis..cl_cliente_grupo  
	set cg_usuario = @i_login_asesor_fin,
    	 cg_oficial = @w_cod_oficial_fin
	where cg_grupo = @i_grupo
	and   cg_estado= 'V'
	        
	--3.--
	UPDATE cobis..cl_ente 
	SET en_oficial    = @w_cod_oficial_fin,
	    c_funcionario = @i_login_asesor_fin,
	    en_oficina    = @w_oficina_fin
	from #cliente_grupo
	WHERE en_ente  = cod_cliente 


	--4-- padre
	UPDATE cob_cartera..ca_operacion 
	SET op_oficial   = @w_cod_oficial_fin,
	    op_oficina   = @w_oficina_fin 
	FROM #padre
	WHERE op_operacion = p_operacion
	                                       
	--5-- hijos
	UPDATE cob_cartera..ca_operacion 
	SET op_oficial   = @w_cod_oficial_fin,
	    op_oficina   = @w_oficina_fin 
	FROM #hijo
	WHERE op_operacion = h_operacion

	--6--
	UPDATE cob_credito..cr_tramite 
	SET tr_usuario    = @i_login_asesor_fin,
	    tr_usuario_apr= @i_login_asesor_fin,
	    tr_oficial    = @w_cod_oficial_fin,
	    tr_oficina    = @w_oficina_fin
	FROM #padre
	WHERE tr_tramite = p_tramite
	AND tr_cliente  = @i_grupo
	
	--7--
	UPDATE cob_credito..cr_tramite 
	SET tr_usuario    = @i_login_asesor_fin,
	    tr_usuario_apr= @i_login_asesor_fin,
	    tr_oficial    = @w_cod_oficial_fin,
	    tr_oficina    = @w_oficina_fin
	FROM cob_cartera..ca_operacion, #hijo
	WHERE op_banco = h_banco
	AND op_tramite = h_tramite

	SELECT * 
	FROM cob_cartera..ca_operacion, #hijo, cob_credito..cr_tramite 
	WHERE op_banco = h_banco
	AND op_tramite = h_tramite

	--8-- padre
	update cob_cartera..ca_operacion_his 
	set oph_oficial   = @w_cod_oficial_fin
	FROM #padre
	where oph_operacion = p_operacion
	
	--9-- hijo
	update cob_cartera..ca_operacion_his 
	set oph_oficial   = @w_cod_oficial_fin,
	    oph_oficina   = @w_oficina_fin
	FROM #hijo
	where oph_operacion = h_operacion

	--10--
	update cob_cartera_his..ca_operacion
	set   op_oficial = @w_cod_oficial_fin,
	      op_oficina = @w_oficina_fin
	FROM #padre
	where op_operacion = p_operacion
	                      
	--11--
	update cob_cartera_his..ca_operacion
	set   op_oficial = @w_cod_oficial_fin,
	      op_oficina = @w_oficina_fin
	FROM #hijo
	where op_operacion = h_operacion
	
	
	--12--
	update cob_cartera_his..ca_operacion_his
	set   oph_oficial = @w_cod_oficial_fin,
	      oph_oficina = @w_oficina_fin
	FROM #padre
	where oph_operacion = p_operacion
	
	--13--
	update cob_cartera_his..ca_operacion_his
	set   oph_oficial = @w_cod_oficial_fin,
	      oph_oficina = @w_oficina_fin   
	FROM #hijo
	where oph_operacion = h_operacion



	SELECT 'DESPUES', gr_oficial , *
	FROM cobis..cl_grupo
	where gr_grupo = @i_grupo


	select 'DESPUES', cg_oficial, *
	from cobis..cl_cliente_grupo
	where cg_grupo  = @i_grupo
	ORDER BY cg_estado , cg_ente
	

	SELECT 'DESPUES', c_funcionario, en_oficial, en_oficina,*
	from cobis..cl_ente,
	     cobis..cl_ente_aux
	where en_ente IN (select cod_cliente from #cliente_grupo)
	and   en_ente = ea_ente


	
	RETURN 0
	
END
go
