/************************************************************************/
/*	Archivo: 	        credcon2.sp                             */
/*	Stored procedure:       sp_credcon2                             */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Consulta de Garantias de un grupo y de un grupo excluyendo      */
/*	al cliente. Programa interno que es llamado por sp_credito2.    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995      L.Castellanos  Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_credcon2')
    drop proc sp_credcon2
go
create procedure sp_credcon2(
        @s_ssn                int      = null,
        @s_date               datetime = null,
        @s_user               login    = null,
        @s_term               varchar(64) = null,
        @s_corr               char(1)  = null,
        @s_ssn_corr           int      = null,
        @s_ofi                smallint  = null,
        @t_rty                char(1)  = null,
        @t_trn                smallint = null,
        @t_debug              char(1)  = 'N',
        @t_file               varchar(14) = null,
        @t_from               varchar(30) = null,
        @i_operacion          char(1)  = null,
        @i_estado             char(1)  = null,
        @i_cliente            int      = null,
        @i_grupo              int      = null,
        @o_total              money    = null out,
        @o_total_op           money    = null out)
as
declare  
        @w_today              datetime,     /* fecha del dia */ 
        @w_return             int,          /* valor que retorna */
        @w_sp_name            varchar(32),  /* nombre stored proc*/

        /* Variables de la operacion de Consulta */
        @w_total_op money,@w_total money,@w_ayer datetime,
        @w_scu varchar(64)


select @w_today = @s_date
select @w_sp_name = 'sp_credcon2'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19425 and @i_operacion = 'S') 
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

   select @w_scu = pa_char + '%' -- TIPOS DE GARANTIA SIMPLE CUSTODIA EXCLUIR
     from cobis..cl_parametro
    where pa_producto = 'GAR'
      and pa_nemonico = 'SCU'
     set transaction isolation level read uncommitted

   select @w_ayer = convert(char(10),dateadd(dd,-1,@s_date),101)
   if @i_estado = 'P' or @i_estado = 'V' -- (P)ropuestas o (V)igentes 
   begin
      select @w_total = sum(cu_valor_inicial*isnull(cv_valor,1))
      from cu_cliente_garantia,
           cob_conta..cb_vcotizacion
        right outer join cu_custodia   
         on cv_moneda  = cu_moneda
      where ( cg_ente      = @i_grupo
              or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cu_garante  is null
        and cu_estado   <> 'C' -- (C)ancelada
        and cu_estado   <> 'A' -- (A)nulada  --pga 23may2001
        and cv_fecha     = @w_ayer
        and cu_estado    = @i_estado 
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and cu_filial    = cg_filial
        and cu_sucursal  = cg_sucursal
        and cu_tipo      = cg_tipo_cust
        and cu_custodia  = cg_custodia

      select @w_total_op = sum((1-floor(power(cos(gp_monto_exceso),2))) * gp_monto_exceso + floor(power(cos(gp_monto_exceso),2)) * tr_monto * isnull(cv_valor,1))
      from cob_credito..cr_gar_propuesta,
           cu_custodia, cu_cliente_garantia, cob_credito..cr_tramite
        left outer join cob_credito..cr_deudores  
         on tr_tramite = de_tramite
           left outer join cob_conta..cb_vcotizacion
             on tr_moneda = cv_moneda 
      where gp_garantia    =  cu_codigo_externo
        and de_rol         =  'C'          -- (C)odeudor
        and tr_tipo        in ('O','R','M')    -- (O)riginales,(R)enovaciones,(M)Normalizacion CCA 436
        and gp_tramite     =  tr_tramite
        and cv_fecha       =  @w_ayer
        and cu_estado      =  @i_estado 
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and cu_garante     is  null
        and (   cg_ente      = @i_grupo
             or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cg_filial      =  cu_filial
        and cg_sucursal    =  cu_sucursal
        and cg_tipo_cust   =  cu_tipo
        and cg_custodia    =  cu_custodia

      select @w_total,@w_total_op
   end

   if @i_estado = 'E' -- (E)xcepcionadas
   begin
      select @w_total = sum(cu_valor_inicial*isnull(cv_valor,1))
      from cu_cliente_garantia,cob_credito..cr_excepciones,cob_conta..cb_vcotizacion
       right outer join cu_custodia
         on  cv_moneda       = cu_moneda
      where (   cg_ente      = @i_grupo
             or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cu_garante       is null
        and cu_estado        <> 'C' -- (C)ancelada
        and cv_fecha          = @w_ayer
        and cu_estado         = @i_estado 
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and cu_filial         = cg_filial
        and cu_sucursal       = cg_sucursal
        and cu_tipo           = cg_tipo_cust
        and cu_custodia       = cg_custodia
        and cu_codigo_externo = ex_garantia

      select @w_total_op = sum((1-floor(power(cos(gp_monto_exceso),2))) * gp_monto_exceso + floor(power(cos(gp_monto_exceso),2)) * tr_monto * isnull(cv_valor,1))
      from cob_credito..cr_gar_propuesta,cob_credito..cr_excepciones,
           cu_custodia, cu_cliente_garantia, cob_credito..cr_tramite
        left outer join cob_credito..cr_deudores  
         on tr_tramite = de_tramite
           left outer join cob_conta..cb_vcotizacion
             on tr_moneda = cv_moneda 
      where gp_garantia       =  cu_codigo_externo
        and de_rol            =  'C'          -- (C)odeudor
        and tr_tipo           in ('O','R','M')    -- (O)riginales,(R)enovaciones,(M)Normalizacion CCA 436
        and gp_tramite        =  tr_tramite
        and cu_estado         <> 'C' -- (C)ancelada
        and cu_garante        is null
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and cu_codigo_externo =  ex_garantia 
        and (   cg_ente      = @i_grupo
             or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cg_filial      =  cu_filial
        and cg_sucursal    =  cu_sucursal
        and cg_tipo_cust   =  cu_tipo
        and cg_custodia    =  cu_custodia

      select @w_total,@w_total_op
   end

   if @i_estado is null -- TOTAL GENERAL 
   begin
      select @w_total = sum(cu_valor_inicial*isnull(cv_valor,1))
      from cu_cliente_garantia,cob_conta..cb_vcotizacion
      right outer join cu_custodia   
         on cv_moneda  = cu_moneda
      where (   cg_ente      = @i_grupo
             or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cu_garante  is null
        and cu_estado   <> 'C' -- (C)ancelada
        and cu_estado   <> 'A' -- (A)nulada --pga23may2001
        and cv_fecha     = @w_ayer
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and cu_filial    = cg_filial
        and cu_sucursal  = cg_sucursal
        and cu_tipo      = cg_tipo_cust
        and cu_custodia  = cg_custodia

      select @w_total_op = sum((1-floor(power(cos(gp_monto_exceso),2))) * gp_monto_exceso + floor(power(cos(gp_monto_exceso),2)) * tr_monto * isnull(cv_valor,1))
      from cob_credito..cr_gar_propuesta,
           cu_custodia,cu_cliente_garantia, cob_credito..cr_tramite
       left outer join cob_credito..cr_deudores  
         on tr_tramite = de_tramite
           left outer join cob_conta..cb_vcotizacion
             on tr_moneda = cv_moneda   
           
      where gp_garantia =  cu_codigo_externo
        and de_rol      =  'C'          -- (C)odeudor
        and tr_tipo     in ('O','R','M')    -- (O)riginales,(R)enovaciones,(M)Normalizacion
        and gp_tramite  =  tr_tramite
        and cv_fecha    =  @w_ayer
        and cu_estado   <> 'C' -- (C)ancelada
        and cu_estado   <> 'A' -- (A)nulada --pga23may2001
        and cu_garante is  null
        and cu_tipo not like @w_scu -- Excluir simples custodias
        and (   cg_ente      = @i_grupo
             or cg_ente in (select en_ente from cobis..cl_ente
                             where en_grupo = @i_grupo) 
             and (cg_ente <> @i_cliente or @i_cliente is null)) 
        and cg_filial      =  cu_filial
        and cg_sucursal    =  cu_sucursal
        and cg_tipo_cust   =  cu_tipo
        and cg_custodia    =  cu_custodia

      select @w_total,@w_total_op
   end
end
return 0
go