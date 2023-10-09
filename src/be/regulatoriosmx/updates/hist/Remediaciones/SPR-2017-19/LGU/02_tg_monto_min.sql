USE cob_credito
GO
IF NOT EXISTS(SELECT 1 FROM syscolumns c, sysobjects o WHERE c.name = 'tg_monto_min_calc' AND c.id = o.id AND o.name = 'cr_tramite_grupal'
)
BEGIN
	print' creando nueva columna'
	ALTER TABLE cr_tramite_grupal ADD tg_monto_min_calc MONEY NULL
END
else
	print' ya existe la columna'
GO



