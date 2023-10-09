use cob_interfase
go

if exists (select 1 from sysobjects
where  name = 'sp_tr_calcula_impuesto')
  drop proc sp_tr_calcula_impuesto
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_tr_calcula_impuesto
(
    @s_ssn              int,
    @s_date             datetime,
    @s_user             varchar(30),
    @t_trn              smallint    = 6531,
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_show_version     bit         = 0,
    @t_from             varchar(32) = null,
    @t_corr             char(1)     = 'N',      --indica si hay reverso parámetro del kernel, cts
    @t_ssn_corr         int         = null,     --secuencial para reversar parámetro del kernel, cts
    @i_oficina          int         = null,     --Oficina de la cuenta
    @i_fecha            datetime    = null,     --Fecha Proceso
    @i_operacion        varchar(1),             --Insercion tablas tributarias
    @i_empresa          tinyint,                --Empresa
    @i_producto         tinyint,                --Producto
    @i_moneda           tinyint,                --Moneda
    @i_transaccion      int,                    --@i_trn,           --Transacción a generar el impuesto
    @i_num_operacion    char(30),                --Numero de cuenta
    @i_tipo_trn         char(1),                        --'S',              --Servicio
    @i_tipo_ente        char(1),                --Tipo ente Persona natural / Juridica
    @i_nac_extr         char(1),                        --Determina si es persona Nacional / Extranjera
    @i_nit              char(1),                        --Veirifica si tiene nit o no
    @i_exento           char(1),                        --para identificar que no se cobra ningún impuesto.
    @i_ente             int,                        --Código del Cliente
    @i_nombre_razon     char(60),                        --Nombre del cliente
    @i_ci_nit           char(60),                      --Numero NIT del cliente
    @i_base_imp         money,                        --valor total de la transaccion
    @i_masivo           char(1),                         -- Masivo (M), Linea (L)
    @i_valor_cond       money,                        --saldo de la cuenta         
    @i_batch            char(1)     = 'N',                        
    @i_lev_embargo      char(1)     = 'N',                        
    @i_servicio         char(10),                       --Servicio a generar el impuesto
    @i_opcion           char(1)     = 'G',                        --Opcion G --> genera la trx de impuesto		
    @i_alt              int         = 0,                        
    @i_itf_cex          char(1),
    @o_genero_factura   char(1)     = 'N'  out--Indica si genera o no factura
)
as 
  return 0

go

