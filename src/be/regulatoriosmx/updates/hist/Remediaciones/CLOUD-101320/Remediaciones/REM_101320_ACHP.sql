
  --Buen dia favor de reasignar a los siguientes clientes con el asesor correspondiente (JESSICA CORONA MARTINEZ).
  --
  --3486 Elizabeth Hernandez Iba�ez
  --3568 Ofelia Iba�ez Martinez
  --
  --PERTENECEN:
  --ZAIRA TURINCIO PASCUAL
  --USUARIO:ZTURINCIO
  --
  --ASESOR REASIGNADO:
  --JESSICA CORONA MARTINEZ
  --USUARIO: JCORONA

USE cobis 
go
-- 1.-
-- actualizaci�n en la cl_ente de ZTURINCIO a JCORONA
UPDATE cobis..cl_ente 
SET en_oficial    = 43,
    c_funcionario = 'jcorona',
    en_oficina    = 3348
WHERE en_ente in (3486,3568)
go