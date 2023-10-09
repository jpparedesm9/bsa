use cob_sincroniza
go

IF EXISTS (select * from sys.objects where name = 'si_sincroniza_batch' and [type] = 'u')
	DROP TABLE si_sincroniza_batch
go

CREATE TABLE si_sincroniza_batch (
	sb_secuencial		int NOT NULL,
	sb_estado			varchar(10) NOT NULL,
	sb_usuario_registro	varchar(20) NOT NULL,
	sb_fecha_registro	datetime NOT NULL,
	sb_oficial			int NOT NULL,
	sb_fecha_ultima_sincronizacion	datetime NULL,
	CONSTRAINT pk_si_sincroniza_batch PRIMARY KEY (sb_secuencial)
) GO