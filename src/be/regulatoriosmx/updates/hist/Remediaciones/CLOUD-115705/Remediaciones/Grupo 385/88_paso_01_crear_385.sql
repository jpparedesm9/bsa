use cob_cartera
GO

if exists(select 1 from sysobjects where name = '#grupo')
    drop table #grupo
ELSE
    drop table #grupo
go
    
create table #grupo(
gr_grupo  int,
gr_tramite INT,
gr_procesado varchar(10)
)

go


if exists(select 1 from sysobjects where name = '#grupo_det')
    drop table #grupo_det
ELSE
    drop table #grupo_det
go
    
create table #grupo_det(
 gd_grupo INT,
 gd_tramite INT,
 gd_operacion INT,
 gd_banco     VARCHAR(32),
 gd_cliente   INT,
 gd_estado    SMALLINT,
 gd_oficina   SMALLINT,
 gd_referencia_grupal VARCHAR(32),
 gd_operacion_p INT,
 gd_procesado  VARCHAR(10),
 gd_mensaje    VARCHAR(64),
 gd_fult_proc  DATETIME
 )
 
CREATE INDEX idx_1 ON #grupo_det (gd_operacion)
CREATE INDEX idx_2 ON #grupo_det (gd_tramite, gd_grupo)
go

if exists(select 1 from sysobjects where name = '#abono')
    drop table #abono
ELSE
    drop table #abono
go
    
create table #abono(
ab_id          INT IDENTITY,
ab_grupo  		int,
ab_tramite	 	int,
ab_banco       VARCHAR(32),
ab_operacion  	int,
ab_secuencial_ing	int,
ab_secuencial_rpa	int,
ab_secuencial_pag int,
ab_fecha_pag DATETIME,
ab_referencia VARCHAR(64),
ab_operacion_p INT,
ab_secuencial  INT,
ab_procesado varchar(10)
)

CREATE INDEX idx_1 ON #abono (ab_operacion, ab_secuencial_ing)

go

