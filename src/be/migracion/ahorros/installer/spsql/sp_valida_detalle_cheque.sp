
/************************************************************************/
/*  Archivo:                sp_valida_detalle_cheque.sp                 */
/*  Stored procedure:       sp_valida_detalle_cheque                    */
/*  Base de datos:          cob_pasivas_mig                             */
/*  Producto:               Pasivas                                     */
/*  Disenado por:           Giovanny Cueva.                             */
/*  Fecha de escritura:     19-01-2016                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*  Este programa realiza la migracion de la tabla re_detalle_cheque    */
/************************************************************************/
/*                    MODIFICACIONES                                    */
/*  FECHA             AUTOR                   RAZON                     */
/*  17-Mar-2016       Giovanny Cueva          Banco FIE                 */
/************************************************************************/
use cob_externos
go 

/***********  Validación de la existencia del sp      **********/ 
if exists (select * from sysobjects where name = 'sp_valida_detalle_cheque')
   drop proc sp_valida_detalle_cheque          
go

create proc sp_valida_detalle_cheque(
   @i_clave_i           int          = null,  
   @i_clave_f           int          = null
)
as

declare
   @w_sp_name            varchar(30),
   @w_tabla              varchar(30),
   @w_nomcolumna         varchar(30),
   @w_conteo             int,
   @w_fecha_proceso      datetime   
  

-- ------------------------------------------------------------------
-- - Cargo el nombre del programa
-- ------------------------------------------------------------------
set nocount on

select @w_sp_name         = 'sp_valida_detalle_cheque_mig',
       @w_tabla           = 're_detalle_cheque_mig'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
       
select @w_conteo = count(*)
from    re_detalle_cheque_mig
where dc_codigo between @i_clave_i and @i_clave_f
if @w_conteo = 0
   return 0   


-- --------------------------------------------------------------
-- - Valida si la cuenta ya fue migrada
-- --------------------------------------------------------------   
select @w_nomcolumna = 'dc_cta_banco'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_cta_banco),
       289,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and exists (select 1 from cob_ahorros..ah_cuenta_aux where a.dc_cta_banco = ca_cta_banco_mig) 
   
--- ---------------------------------------------------------------------------
-- - Validar que filial
-- ----------------------------------------------------------------------------
select @w_nomcolumna = 'dc_filial'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_filial),
       236,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig
where dc_codigo between @i_clave_i and @i_clave_f 
and   dc_filial <> 1
    
-------------------------------------
--VALIDAR OFICINA
-------------------------------------
select @w_nomcolumna = 'dc_oficina'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_oficina),
       237,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_oficina not in (select of_oficina from cobis..cl_oficina ofi  where ofi.of_oficina = a.dc_oficina )

-------------------------------------
--VALIDAR PRODUCTO
-------------------------------------
select @w_nomcolumna = 'dc_producto'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_producto),
       238,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig 
where dc_codigo between @i_clave_i and @i_clave_f
and   dc_producto not in (4)  

-------------------------------------
--VALIDAR MONEDA
-------------------------------------
select @w_nomcolumna = 'dc_moneda'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_moneda),
       239,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_moneda not in (0)
    
-------------------------------------
--VALIDAR TIPO DE CHEQUE
-------------------------------------
select @w_nomcolumna = 'dc_tipo'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_tipo),
       240,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_tipo not in (select c.codigo from cobis..cl_tabla t, cobis..cl_catalogo c                    
                                    where t.tabla = 'cc_tipos_cheque' and t.codigo = c.tabla and c.codigo = a.dc_tipo ) 
                                  
-------------------------------------
--VALIDAR dc_co_banco
-------------------------------------
select @w_nomcolumna = 'dc_co_banco'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_co_banco),
       243,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_co_banco not in (select ba_banco from cob_remesas..re_banco where ba_banco = a.dc_co_banco)


-------------------------------------
--VALIDAR CUENTA DEL CHEQUE 
-------------------------------------
select @w_nomcolumna = 'dc_cta_cheque'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_cta_cheque),
       241,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_cta_cheque =''

-------------------------------------
--VALIDAR EL NUMERO DEL CHEQUE 
-------------------------------------
select @w_nomcolumna = 'dc_num_cheque'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_num_cheque),
       242,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_num_cheque =''
  
-------------------------------------
--VALIDAR MONEDA DES
-------------------------------------
select @w_nomcolumna = 'dc_mon_destino'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_mon_destino),
       244,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_mon_destino not in (0)

  
-------------------------------------
--VALIDAR dc_user
-------------------------------------
select @w_nomcolumna = 'dc_user'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_user),
       245,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a
where dc_codigo between @i_clave_i and @i_clave_f
and a.dc_user not in (select fu_login from cobis..cl_funcionario where fu_login = a.dc_user)


-------------------------------------
--VALIDAR LA CUENTA
-------------------------------------
select @w_nomcolumna = 'dc_cta_banco'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_cta_banco),
       246,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig a left outer join cob_externos..ah_cuenta_mig b
on (convert(varchar(24),a.dc_cta_banco)= convert(varchar(24), b.ah_cta_banco))
where a.dc_codigo between @i_clave_i and @i_clave_f
and b.ah_cta_banco is null

-------------------------------------
--VALIDAR LA ORIGEN Y DESTINO
-------------------------------------
select @w_nomcolumna = 'dc_moneda'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_moneda),
       247,
       dc_codigo,
       dc_cta_banco
from re_detalle_cheque_mig 
where dc_codigo between @i_clave_i and @i_clave_f
and   dc_moneda <> dc_mon_destino  
   
-------------------------------------
--VALIDAR EL VALOR DEL CHEQUE 
-------------------------------------
select @w_nomcolumna = 'dc_valor'

insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_valor),
       207,
       dc_codigo,
       dc_cta_banco
from cob_externos..ah_ciudad_deposito_mig, cob_externos..re_detalle_cheque_mig, cob_externos..ah_cuenta_mig a
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_cuenta =ah_cuenta
and dc_cta_banco=ah_cta_banco
and cd_valor not in  (select sum(dc_valor) from cob_externos..re_detalle_cheque_mig where dc_cta_banco=a.ah_cta_banco ) 
 
---------------------------------------------------
--VALIDAR DE LA FECHA DE EFECTIVIZACIÓN DEL CHEQUE 
--------------------------------------------------- 
insert into ah_log_mig
select convert(varchar, dc_codigo),
       @w_tabla,
       @w_sp_name,
       @w_nomcolumna,
       convert(varchar, dc_fecha_efe),
       154,
       dc_codigo,
       dc_cta_banco
from cob_externos..ah_ciudad_deposito_mig, cob_externos..re_detalle_cheque_mig, cob_externos..ah_cuenta_mig
where cd_cuenta between @i_clave_i and @i_clave_f
and cd_cuenta =ah_cuenta
and dc_cta_banco=ah_cta_banco
and dc_fecha_efe <> cd_fecha_efe    
   
-- ------------------------------------------------------------------
-- - Actualizo si el registro es valido
-- ------------------------------------------------------------------
update re_detalle_cheque_mig set dc_estado_mig = 'VE'
where dc_codigo between @i_clave_i and @i_clave_f
and dc_codigo not in (select convert(int, lm_id_reg) 
                      from ah_log_mig                                                      
					  where convert(int, lm_id_reg) between @i_clave_i and @i_clave_f and lm_tabla = 're_detalle_cheque_mig'
                      group by lm_id_reg)
and dc_estado_mig is null

update re_detalle_cheque_mig set dc_estado_mig = 'ER'
where dc_codigo between @i_clave_i and @i_clave_f
and dc_estado_mig is null
return  0
go 

