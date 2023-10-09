--ASESOR ASIGNADO: Carlos Velarde Bernal Usuario CVELARDE -- cvelarde       166 
--ASESOR A REASIGNAR: Iris Rubi Ortega Ayala Usuario IRORTEGA -- irortega       196 
--
--PROSPECTOS:
--39048 — ADRIANA FRANCISCO NUÑEZ


USE cobis 
go

   update cobis..cl_ente set
   en_oficial     = '',
   c_funcionario  = 'agutierrezoc',
   en_oficina     = 9001
   where  en_ente in (39048)

go
