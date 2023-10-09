use cob_cuentas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_causa_ingegr')
  drop proc sp_causa_ingegr
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_causa_ingegr
(
  @s_ssn                int,
    @s_srv                varchar(30),
    @s_lsrv               varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_ofi                smallint,
    @s_rol                smallint     = 1,
    @s_org_err            char(1)      = null,
    @s_error              int          = null,
    @s_sev                tinyint      = null,
    @s_msg                varchar(264) = null,
    @s_org                char(1),
    @t_debug              char(1)      = 'N',
    @t_file               varchar(14)  = null,
    @t_from               varchar(32)  = null,
    @t_rty                char(1)      = 'N',
    @t_trn                smallint,
    @i_operacion          char(1)      = 'S',     -- Tipo operacion I(Insert), D(Delete), S(Select), U(Update)
    @i_tipo               char(1),                -- I(Ingreso), E(Egreso) 
    @i_causal             varchar(3),             -- Causa
    @i_cobro_iva          char(1)      = 'N',     -- (S) Cobra IVA, (N) No cobra IVA
    @i_costo              money        = null,    -- Costo para el servicio
    @i_gasto_banco        char(1)      = null,    -- (S) Es gasto banco y cobra GMF, (N) no marcado
    @i_efectivo           char(1)      = null,    -- Tipos de medio de pago permitidos
    @i_chq_propio         char(1)      = null,
    @i_chq_local          char(1)      = null,
    @i_ndnc_cte           char(1)      = null,     -- Nota debito/credito corrientes
    @i_ndnc_aho           char(1)      = null,     -- Nota debito/credito ahorros
    @i_causa_cte          char(3)      = null,     -- Causa ndnc corrientes
    @i_caurev_cte         char(3)      = null,     -- Causa reversion ndnc corrientes        
    @i_causa_aho          char(3)      = null,     -- Causa ndnc ahorros
    @i_caurev_aho         char(3)      = null,     -- Causa reversion ndnc ahorros
    @i_programa           varchar(40)  = null,
    @i_vigencia           smallint     = null
)
as 
  return 0

go

