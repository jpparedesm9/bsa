USE cob_credito
go
if exists (select 1 from sysobjects where name = 'cr_monto_cliente_grupo' and type = 'U')
   drop table cr_monto_cliente_grupo
go
CREATE TABLE dbo.cr_monto_cliente_grupo
(
    mc_tramite int          NOT NULL,
    mc_cliente int          NOT NULL,
    mc_monto   varchar(254)  NULL
)
go
CREATE nonclustered INDEX cr_monto_cliente_grupo_key
	ON dbo.cr_monto_cliente_grupo (mc_tramite,mc_cliente)
GO