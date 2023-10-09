USE cob_credito
GO

IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'cr_tramite_grupal'
          and   obj.id = idx.id
          and   idx.name = 'idx3')
BEGIN
	DROP INDEX cr_tramite_grupal.idx3
END

GO

sp_help cr_tramite_grupal
GO
