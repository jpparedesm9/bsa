use cob_sbancarios
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_actualizar_lotes')
  drop proc sp_actualizar_lotes
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_actualizar_lotes
(
  @s_ssn          int         = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1)     = null,
    @t_ssn_corr     int         = null,
    @p_rssn_corr    int         = null,
    @p_lssn         int         = null,
    @s_sev          tinyint     = null,
    @s_date         datetime    = null,
    @s_term         varchar(30) = null,
    @s_sesn         int         = null,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         varchar(14),
    @s_ofi          smallint    = null,
    @s_rol          smallint    = null,
    @s_org          char(1)     = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_trn          smallint    = null,
    @i_alterno      int         = null,
    @i_idlote       int         = null,
    @i_enlace_cc    char(1)     = null,
    @i_producto     tinyint,        /* Codigo del producto */
    @i_instrumento  smallint,       /* Codigo del instrumento */
    @i_causa_anul   varchar(64) = null,
    @i_subtipo      int,            /* Codigo del subtipo */
    @i_grupo1       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo2       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo3       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo4       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo5       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo6       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo7       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo8       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo9       varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo10      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo11      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo12      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo13      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo14      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_grupo15      varchar(30) = null, /* Contiene un registro (item) completo de la impresion en lotes */
    @i_llamada_ext  char(1)     = 'N'   /* Para no hacer commit si es llamada desde otro modulo */

)
as 
  return 0

go

