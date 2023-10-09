use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_devolucion_val_recaudo')
   drop proc sp_devolucion_val_recaudo
go

create proc sp_devolucion_val_recaudo(
    @s_ssn           int = null,
    @s_term          varchar(10) = null,
    @s_user          varchar(30) = null,
    @s_ofi           smallint = null,
    @s_date          datetime = null,
    @t_trn           int,
    @s_srv           varchar(30) = null,
    @i_operacion     char(1),
    @i_cta_banco     char(16) = null,
    @i_codigo_red    smallint,
    @i_fecha_desde   datetime = null,
    @i_fecha_hasta   datetime = null,
    @i_dias_dev      smallint = 1,
    @i_sec           int = 0,
    @i_formato_fecha int = 103 
)
as
return 0


go

