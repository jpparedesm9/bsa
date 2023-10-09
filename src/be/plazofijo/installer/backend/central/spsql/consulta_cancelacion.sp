/************************************************************************/
/*     Archivo:                  conscanc.sp                            */
/*     Stored procedure:         sp_consulta_cancelacion                */
/*     Base de datos:            cob_pfijo                              */
/*     Producto:                 Plazo_fijo                             */
/*     Disenado por:             Luis Im                                */
/*     Fecha de documentacion:   Oct/2005                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     'MACOSA', representantes exclusivos para el Ecuador de la        */
/*     'NCR CORPORATION'.                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/*                             PROPOSITO                                */
/*     Este procedimiento almacenado realiza las actualizaciones        */
/*     necesarias para dar por terminada una operacion de Plazo Fijo    */
/*     cuando se ha cumplido  o no su plazo.                            */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*     FECHA       AUTOR               RAZON                            */
/*     6/Oct/05    Luis Im             Emision Inicial                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_consulta_cancelacion')
   drop proc sp_consulta_cancelacion
go
   
create proc sp_consulta_cancelacion (
   @s_ssn                   int         = NULL,
   @s_user                  login       = NULL,
   @s_sesn                  int         = NULL,
   @s_term                  varchar(30) = NULL,
   @s_date                  datetime    = NULL,
   @s_srv                   varchar(30) = NULL,
   @s_lsrv                  varchar(30) = NULL,
   @s_ofi                   smallint    = NULL,
   @s_rol                   smallint    = NULL,
   @t_debug                 char(1)     = 'N',
   @t_file                  varchar(10) = NULL,
   @t_from                  varchar(32) = NULL,
   @t_trn                   smallint,
   @i_num_banco             cuenta,
   @i_operacion             char(1),
   @i_tipodp                catalogo,
   @i_formato_fecha         int)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_secuencial           int,
        @w_oficina              int,
        @w_operacionpf          int,
        @w_return               int,
        @w_estado               catalogo,
        @w_fpago                catalogo,
        @w_accion_sgte          catalogo,
        @w_tautorizacion        catalogo,
        @w_nombre               varchar(255)
        

select @w_sp_name = 'sp_consulta_cancelacion'


-------------------------------
-- Validacion de la Transaccion
------------------------------- 
if @t_trn <> 14464
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141018
        -- 'Error en codigo de transaccion'
   return 141018
end
select @w_operacionpf =  op_operacion
 from pf_operacion
where op_num_banco = @i_num_banco


select @w_nombre =  isnull(en_nomlar,en_nombre) 
 from cobis..cl_ente, pf_beneficiario
where be_operacion 	= @w_operacionpf
  and be_ente 	= en_ente

/*Detalle de Cancelacion*/
set rowcount 1
select 
       @w_nombre,	
       ca_funcionario,
       of_nombre,
       ca_comentario,
       ca_estado,
       convert(varchar(10),ca_fecha_crea,@i_formato_fecha)
from pf_cancelacion, cobis..cl_oficina
where ca_operacion = @w_operacionpf
  and ca_estado    = 'I'  --'R'
  and ca_oficina   = of_oficina


set rowcount 0

/*Detalle de Pago*/
select  fp_descripcion,
case mm_tipo_cliente   
when 'M' then (select case when isnull(en_nomlar,'')= '' 
              then p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre
              else en_nomlar
              end
              from cobis..cl_ente
   		      where A.mm_beneficiario = en_ente)
else
              (select ce_nombre from pf_cliente_externo 
               where ce_secuencial = A.mm_beneficiario)	
end,
mm_valor,
mm_cuenta,
'',
case mm_tipo_cliente	--SOLO DEBE DESPLEGAR SI ES CLIENTE MIS
when 'M' then mm_beneficiario end,
mm_producto,
'moneda pago' = (select mo_descripcion from cobis..cl_moneda where mo_moneda = A.mm_moneda),  
fp_producto, 
(select of_nombre from cobis..cl_oficina 
 where of_oficina = A.mm_oficina_pago), 
1,
mm_valor,
isnull(mm_tipo_cliente, 'M'),
case mm_tipo_cliente 
	when 'E' then (select isnull(ce_direccion, '') from pf_cliente_externo where A.mm_beneficiario = ce_secuencial  )
	else '' 
	end,
	case mm_tipo_cliente 
		when 'E' then (select isnull(ce_cedula, '') from pf_cliente_externo where A.mm_beneficiario = ce_secuencial  )
		else '' 
		end,
mm_tipo_cuenta_ach,
mm_banco_ach
from pf_mov_monet A
inner join pf_fpago on
   mm_producto = fp_mnemonico
   left outer join cobis..cl_oficina on
      mm_oficina = of_oficina
where mm_operacion = @w_operacionpf 
and fp_estado = 'A'
and mm_tran   = 14903
and mm_estado is null


return 0
go
