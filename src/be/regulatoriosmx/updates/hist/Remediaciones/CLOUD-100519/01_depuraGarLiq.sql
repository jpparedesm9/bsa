USE cob_cartera
GO
CREATE TABLE #tmp1(
	operacion    INT, 
	fecha_pag    DATETIME NULL,
	banco        VARCHAR(32)  NULL,
	fult_proceso DATETIME NULL,
	estado       INT  NULL,
	error        char(1) null,
	procesada    char(1) NULL)
go

insert INTO #tmp1 VALUES  (1307	, '05/24/2018', '233540000152' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1310	, '05/24/2018', '233540000160' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1313	, '05/24/2018', '233540000178' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1316	, '05/24/2018', '233540000186' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1319	, '05/24/2018', '233540000193' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1322	, '05/24/2018', '233540000202' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1325	, '05/24/2018', '233540000210' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1328	, '05/24/2018', '233540000228' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1331	, '05/24/2018', '233540000236' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1334	, '05/24/2018', '233540000244' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1337	, '05/24/2018', '233540000251' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1340	, '05/24/2018', '233540000269' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1652	, '05/28/2018', '233450000977' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1655	, '05/28/2018', '233450000985' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1658	, '05/28/2018', '233450000992' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1661	, '05/28/2018', '233450001000' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1664	, '05/28/2018', '233450001018' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1667	, '05/28/2018', '233450001026' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1670	, '05/28/2018', '233450001034' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1673	, '05/28/2018', '233450001042' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1951	, '05/28/2018', '233480001616' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1954	, '05/28/2018', '233480001624' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1957	, '05/28/2018', '233480001632' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1960	, '05/28/2018', '233480001640' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1963	, '05/28/2018', '233480001657' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1966	, '05/28/2018', '233480001665' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1969	, '05/28/2018', '233480001673' , '05/31/2018', 	1,	'S', 'N')
insert INTO #tmp1 VALUES  (1972	, '05/28/2018', '233480001681' , '05/31/2018', 	1,	'S', 'N')

SELECT 'TOTAL OP' = count(1) FROM #tmp1
DECLARE
@w_operacionca  INT,
@s_date         DATETIME,
@w_fecha_valor  DATETIME,
@w_fult_proceso DATETIME,
@w_banco        VARCHAR(32)

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso

SET @w_operacionca = 0

WHILE 1= 1
BEGIN
	SELECT TOP 1
		@w_operacionca = operacion,
		@w_fecha_valor = fecha_pag,
		@w_fult_proceso= fult_proceso,
		@w_banco       = banco
	FROM #tmp1
	WHERE operacion > @w_operacionca
	AND error = 'S'
	AND estado <> 3
	ORDER BY operacion ASC
	IF @@ROWCOUNT = 0 BREAK
	SELECT 
		'@w_operacionca ' = @w_operacionca ,
		'@w_fecha_valor ' = @w_fecha_valor ,
		'@w_fult_proceso' = @w_fult_proceso,
		'@w_banco       ' = @w_banco       

	BEGIN try
   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @w_fecha_valor,
   @i_banco       = @w_banco,
   @i_secuencial  = 1,
   @i_en_linea    = 'N',
   @i_operacion   = 'F'
	END TRY
	BEGIN CATCH
		PRINT 'fecha valor 1'
	END CATCH
	
 
 	BEGIN TRY
 	exec sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @w_fult_proceso,
   @i_banco       = @w_banco,
   @i_secuencial  = 1,
   @i_operacion   = 'F'
	END try
	BEGIN CATCH
		PRINT 'fecha valor 2'
	END CATCH

END

GO
