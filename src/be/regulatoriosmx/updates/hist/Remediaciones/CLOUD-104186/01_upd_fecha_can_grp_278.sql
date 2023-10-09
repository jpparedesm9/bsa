USE cob_cartera
go
--/////////////////////////////////////////////////////////////

SELECT * INTO borrar_ca_dividendo_gr_278 FROM ca_dividendo
WHERE di_operacion IN ( 
11471,
11474,
11477,
11480,
11483,
11486,
11489,
11492
)
ORDER BY di_dividendo


SELECT * FROM ca_dividendo
WHERE di_operacion IN ( 
11471,
11474,
11477,
11480,
11483,
11486,
11489,
11492
)
ORDER BY di_dividendo

UPDATE ca_dividendo SET	
	di_fecha_can = di_fecha_ven
WHERE di_operacion IN ( 
11471,
11474,
11477,
11480,
11483,
11486,
11489,
11492
)


SELECT * FROM ca_dividendo
WHERE di_operacion IN ( 
11471,
11474,
11477,
11480,
11483,
11486,
11489,
11492
)
ORDER BY di_dividendo

GO

