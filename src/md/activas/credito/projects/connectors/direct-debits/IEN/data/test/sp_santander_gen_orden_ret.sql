use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_santander_gen_orden_ret')
   drop proc sp_santander_gen_orden_ret
go

create proc sp_santander_gen_orden_ret
(
 @s_ssn        int         = null,
 @s_user       login       = null,
 @s_sesn       int         = null,
 @s_term       varchar(30) = null,
 @s_date       datetime    = null,
 @s_srv        varchar(30) = null,
 @s_lsrv       varchar(30) = null,
 @s_ofi        smallint    = null,
 @s_servicio   int         = null,
 @s_cliente    int         = null,
 @s_rol        smallint    = null,
 @s_culture    varchar(10) = null,
 @s_org        char(1)     = null,
 @i_param1     char(3)     = 'IEN'
)

as 

SELECT linea_dato FROM PCL_COBRO

GO