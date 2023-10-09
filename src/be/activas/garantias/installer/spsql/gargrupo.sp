/************************************************************************/
/*  Archivo:            gargrupo.sp                                     */ 
/*  Stored procedure:       sp_gargrupo                                 */ 
/*  Base de datos:      cob_custodia                                    */
/*  Producto:               garantias                                   */
/*  Disenado por:           Rodrigo Garces                              */
/*                  Luis Alfredo Castellanos                            */
/*  Fecha de escritura:     Junio-1995                                  */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de:                         */
/*  Dado el grupo   entrega los totales de garantias por tipo           */
/*  de garantia  en moneda nacional                                     */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  Jun/1995             Emision Inicial                                */
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_gargrupo')
    drop proc sp_gargrupo
go
create proc sp_gargrupo  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,

   @i_modo               smallint = null,
   @i_grupo              int = null, 
   @i_tipo_cust          descripcion = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_fecha          datetime

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_gargrupo'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19264 and @i_operacion = 'S') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
   -- set rowcount 20
   if @i_modo = 1  -- TOTALES POR TIPO DE GARANTIA
      select top 20 cu_tipo,sum(cu_valor_inicial * isnull(cv_valor,1))
      /******************************************************************
      from cu_custodia,cob_conta..cb_vcotizacion,cu_cliente_garantia
      where cg_ente    in (select en_ente from cobis..cl_ente
                           where en_ente  = @i_grupo 
                           or en_grupo = @i_grupo) 
      and cg_filial    = cu_filial
      and cg_sucursal  = cu_sucursal
      and cg_tipo_cust = cu_tipo
      and cg_custodia  = cu_custodia
      and cu_moneda   *= cv_moneda
      and cu_estado in ('V','E') -- (V)igente, (E)xcepcionada
      and cv_fecha     = convert(char(10),dateadd (dd,-1,@s_date),101)
      and (cu_tipo > @i_tipo_cust or @i_tipo_cust is null)
      ************************************************************************/
      from cu_custodia 
        INNER JOIN cu_cliente_garantia
              on cg_filial     = cu_filial
              and cg_sucursal  = cu_sucursal
              and cg_tipo_cust = cu_tipo
              and cg_custodia  = cu_custodia
              LEFT OUTER JOIN cob_conta..cb_vcotizacion
                   on cu_moneda = cv_moneda
                   and cv_fecha = convert(char(10),dateadd (dd,-1,@s_date),101)
     where cg_ente    in (select en_ente from cobis..cl_ente
                           where en_ente  = @i_grupo 
                           or en_grupo = @i_grupo) 
     and cu_estado in ('V','E') -- (V)igente, (E)xcepcionada
     and (cu_tipo > @i_tipo_cust or @i_tipo_cust is null)
     group by cu_tipo 
     
   else            -- CODIGO,DESCRIPCION Y MONTO DE UN TIPO DADO
      select top 20 tc_tipo,tc_descripcion,sum(cu_valor_inicial * isnull(cv_valor,1))
      /**********************************************************************
      from cu_custodia,cu_tipo_custodia,cob_conta..cb_vcotizacion,
           cu_cliente_garantia
      where cg_ente     in (select en_ente from cobis..cl_ente
                            where en_ente  = @i_grupo
                            or en_grupo = @i_grupo)
      and cg_filial    = cu_filial
      and cg_sucursal  = cu_sucursal
      and cg_tipo_cust = cu_tipo
      and cg_custodia  = cu_custodia 
      and cu_moneda   *= cv_moneda
      and cv_fecha     = convert(char(10),dateadd (dd,-1,@s_date),101)  
      and tc_tipo      = @i_tipo_cust
      and cu_tipo      = tc_tipo 
      and cu_estado in ('V','E') -- (V)igente, (E)xcepcionada
      ************************************************************************/
     from cu_custodia 
        INNER JOIN cu_tipo_custodia 
              ON cu_tipo      = tc_tipo 
                  INNER JOIN cu_cliente_garantia
                        ON  cg_tipo_cust = cu_tipo
                        and cg_filial    = cu_filial
                        and cg_sucursal  = cu_sucursal
                        and cg_custodia  = cu_custodia 
                        LEFT OUTER JOIN cob_conta..cb_vcotizacion
                             ON  cu_moneda   = cv_moneda
                             and cv_fecha     = convert(char(10),dateadd (dd,-1,@s_date),101)  
     where cg_ente     in (select en_ente from cobis..cl_ente
                           where en_ente  = @i_grupo
                           or en_grupo = @i_grupo)
     and tc_tipo      = @i_tipo_cust
     and cu_estado in ('V','E') -- (V)igente, (E)xcepcionada
      group by tc_tipo,
            cg_filial,    
            cg_sucursal,  
            cg_tipo_cust, 
            cg_custodia,  
            cu_moneda,   
            cv_fecha,    
            tc_tipo,     
            cu_tipo,     
            cu_estado,
            cu_custodia,
            cv_valor,
            tc_descripcion
     if @@rowcount = 0
     begin
        if (@i_modo = 1  and @i_tipo_cust is null) or (@i_modo <> 1)
           select @w_error = 1901003
        else
           select @w_error = 1901004
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = @w_error
           return 1 
     end
end
go