/***********************************************************************/
/*	Archivo:			cu_estce.sp                    */
/*	Stored procedure:		sp_estce                       */
/*	Base de Datos:			cob_custodia                   */
/*	Producto:			Custodia                       */
/*	Disenado por:			Silvia Portilla                */
/*	Fecha de Documentacion: 	01/Mar/2005                    */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Permite consultas de solicitudes de FAG pagados, devueltos o    */  
/*  negados                                                            */ 
/*								       */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	14/04/2005	Angela Tovar	Emision Inicial	               */
/***********************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_estce')
    drop proc sp_estce
go


create proc sp_estce 
(
@i_fecha        datetime   = null
)

as
declare
   @w_today		       datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_error            int,
   @w_codigo_externo   varchar(64),
   @w_tipo_gar         varchar(64),
   @w_desc_tipo        varchar(64),
   @w_oficina          smallint,
   @w_id_cliente       varchar(30),
   @w_estado           varchar(10),
   @w_certif           varchar(13),
   @w_valor            money,
   @w_canpago          catalogo,
   @w_desc_cp          catalogo,
   @w_canexp           catalogo,
   @w_desc_ex          catalogo,
   @w_ruta_fag         int,
   @w_etapa_fag        tinyint,
   @w_tipo_esp         varchar(30),
   @w_recfag           varchar(30),
   @w_tram_ori         int,
   @w_cliente          int,
   @w_tramite          int,
   @w_garantia         varchar(64),
   @w_tipo             descripcion,
   @w_oficina_ca       smallint,
   @w_causal_np        catalogo,
   @w_desc_est         catalogo,
   @w_tipo_est         varchar(64),
   @w_operacion        int


 
select @w_today = getdate()
select @w_sp_name = 'sp_estce'

--truncate de la tabla cu_estce
truncate table cob_custodia..cu_estce
   
--obtencion de los párametros generales

select @w_ruta_fag  = pa_int
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'CODPAG'

select @w_etapa_fag = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ETRFAG'

select @w_tipo_esp = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'FAG'

select @w_recfag = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico = 'FPRFAG'

--creacion de una tabla temporal con todos los tipos y subtipos de garantias FAG

create table #tipo (tipo varchar(64))

insert into #tipo

select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo       = @w_tipo_esp
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior  = @w_tipo_esp
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior in (select tc_tipo
                           from cob_custodia..cu_tipo_custodia
                           where tc_tipo_superior = @w_tipo_esp)

declare cur_oficina cursor for
select  of_oficina  
from    cobis..cl_oficina
where   of_oficina > 0
and	of_subtipo <> 'O'
for     read only

open cur_oficina
fetch cur_oficina into @w_oficina


while (@@fetch_status = 0)
  begin   

     print 'Ofi ' + cast(@w_oficina as varchar)
     insert into cu_estce(re_tram_proc, re_estado, re_cliente,re_tram_orig, 
     re_codigo_externo, re_tipo_gar, re_oficina, re_certif, re_valor,re_desc_tipo, re_id_cliente,
     re_canpago, re_desc_est,re_desc_cp, re_desc_ex
     )
     select rt_tramite, 'SP',0,0,'','',0,'',0,'','','','','',''
     from cob_credito..cr_ruta_tramite, cob_credito..cr_tramite
     where rt_tramite = tr_tramite
     and tr_estado in ('N','A','D')
     and tr_subtipo = 'F'
     and rt_truta = @w_ruta_fag
     and rt_etapa = @w_etapa_fag
     and convert(varchar(10),rt_llegada,101) = @i_fecha
     and rt_salida is null
     and tr_oficina = @w_oficina
     union
     select ho_num_tra, 'NP',0,0,'','',0,'',0,'','','','','',''
     from cob_credito..cr_hist_credito,cob_credito..cr_tramite
     where tr_tramite = ho_num_tra
     and tr_tipo = 'P'
     and tr_subtipo = 'F'
     and ho_estado = 'R'
     and ho_fecha_aprob = @i_fecha
     and tr_oficina = @w_oficina

     declare cur_operacion cursor for
     select  op_operacion, op_tramite, op_cliente 
     from    cob_cartera..ca_operacion
     where   op_oficina = @w_oficina
     for read only

     open cur_operacion
     fetch cur_operacion into @w_operacion, @w_tramite, @w_cliente

     while (@@fetch_status = 0)
     begin   
        --aqui va insercion
        insert into cu_estce(re_tram_orig, re_estado, re_cliente,
	re_codigo_externo, re_tipo_gar, re_oficina, re_certif, re_valor, re_desc_tipo, re_id_cliente,
	re_canpago, re_desc_est,re_desc_cp, re_desc_ex
	)
        select @w_tramite, 'PG', @w_cliente,'','',0,'',0,'','','','','',''
        from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
        where dtr_operacion = tr_operacion
        and dtr_secuencial = tr_secuencial
        and tr_tran       = 'RPA'
        and tr_estado      in ('CON','ING')
        and dtr_concepto   = @w_recfag
        and tr_operacion   > 0
        and tr_secuencial  > 0
        and dtr_operacion  > 0
        and dtr_secuencial > 0
        and dtr_codvalor   > 0
        and tr_fecha_mov   = @i_fecha
        and dtr_operacion = @w_operacion

        fetch cur_operacion into @w_operacion, @w_tramite, @w_cliente
     end
     close cur_operacion
     deallocate cur_operacion

     fetch cur_oficina into @w_oficina
end


--DATOS DEL TRAMITE DE PROCESOS
update cu_estce
set re_cliente   = op_cliente,
    re_tram_orig = op_tramite
from cob_credito..cr_op_renovar, cob_cartera..ca_operacion
where or_num_operacion = op_banco
and or_tramite = re_tram_proc
and re_estado in ('SP','NP')


--DATOS DE LA GARANTIA
update cu_estce
set re_codigo_externo = cu_codigo_externo,
re_tipo_gar       = cu_tipo,
re_oficina        = cu_oficina,
re_certif         = cu_num_dcto,
re_valor          = cu_valor_actual
from cob_credito..cr_gar_propuesta,cob_custodia..cu_custodia
where gp_garantia = cu_codigo_externo
and gp_tramite = re_tram_orig
and cu_estado in ('P','V','F','X')
and cu_tipo in (select tipo from #tipo)
and re_tram_orig > 0

declare cur_ofic cursor for
select  of_oficina  
from    cobis..cl_oficina
where   of_oficina > 0
and	of_subtipo <> 'O'
for     read only

open cur_ofic
fetch cur_ofic into @w_oficina
while (@@fetch_status = 0)
  begin   
     print 'Ofi ' + cast(@w_oficina as varchar)
      insert into cu_estce
     (re_codigo_externo, re_tipo_gar, re_desc_tipo, re_oficina, re_cliente,
     re_estado, re_certif, re_valor, re_canexp,re_id_cliente, re_canpago, re_desc_est,re_desc_cp, re_desc_ex)
     select 
     cu_codigo_externo, 
     cu_tipo, 
     '', 
     cu_oficina, 
     cg_ente,
     case cu_expedido
       when 'S' then 'EX'
       when 'N' then 'NE'
     end,
     cu_num_dcto, cu_valor_actual, cu_causa_nexp,
     '','','','',''
     from cob_custodia..cu_custodia ,cob_custodia..cu_cliente_garantia
     where cu_fecha_sol_exp = @i_fecha
     and cu_tipo  in (select tipo from #tipo)
     and cg_codigo_externo = cu_codigo_externo
     and cg_tipo_garante = 'J'
     and cu_oficina = @w_oficina
     and cu_codigo_externo not in (select re_codigo_externo from cob_custodia..cu_estce where re_cliente > 0)
     and cg_ente > 0

 fetch cur_ofic into @w_oficina
end

--DESCRIPCION DEL TIPO DE GARANTIA

update cu_estce
set re_desc_tipo = tc_descripcion
from cob_custodia..cu_tipo_custodia
where tc_tipo = re_tipo_gar

--IDENTIFICACION DEL CLIENTE

update cu_estce
set re_id_cliente = en_ced_ruc
from cobis..cl_ente
where en_ente = re_cliente
and re_cliente > 0


-- CAUSAL DE NO PAGO  CUANDO ESTADO = 'SP'

update cu_estce
set re_canpago = cr_requisito
from cob_credito..cr_cau_tramite
where cr_tramite = re_tram_proc
and cr_tipo = 'NEG'
and re_estado = 'NP'


--DESCRIPCION DEL ESTADO

update cu_estce
set re_desc_est = descripcion_sib
from cob_credito..cr_corresp_sib
where tabla = 'T41'
and codigo = re_estado
and re_estado > ''


--DESCRIPCION DE CAUSALES DE NO EXPEDICION Y NO PAGO
update cu_estce
set re_desc_cp  = c.valor
from cobis..cl_tabla t, cobis..cl_catalogo c
where t.codigo = c.tabla
and t.tabla = 'cr_causales_devolucion'
and c.codigo = re_canpago

update cu_estce
set re_desc_ex   = c.valor
from cobis..cl_tabla t, cobis..cl_catalogo c
where t.codigo = c.tabla
and t.tabla = 'cu_causal_nexp'
and c.codigo = re_canexp


return 0
go

