use cob_credito
go
/************************************************************/
/*   ARCHIVO:         sp_rev_buro_list_negras.sp            */
/*   NOMBRE LOGICO:   sp_rev_buro_list_negras.sp            */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Evaluacion de reglas para actividad automatica          */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 31/AGO/2017     ACHP               Emision Inicial       */
/* 05/Jun/2019   P. Ortiz             Quitar ejecucion Buro */
/************************************************************/
    
if object_id('dbo.sp_rev_buro_list_negras') is not null
    drop procedure dbo.sp_rev_buro_list_negras
go

create proc dbo.sp_rev_buro_list_negras
   @s_ssn            int         = null,
   @s_ofi            smallint    = null,
   @s_user           login       = null,
   @s_date           datetime    = null,
   @s_srv            varchar(30) = null,
   @s_term           descripcion = null,
   @s_rol            smallint    = null,
   @s_lsrv           varchar(30) = null,
   @s_sesn           int 	       = null,
   @s_org            char(1)     = null,
   @s_org_err        int 	       = null,
   @s_error          int 	       = null,
   @s_sev            tinyint     = null,
   @s_msg            descripcion = null,
   @t_rty            char(1)     = null,
   @t_trn            int         = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
      --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int        = null,    
   @i_id_empresa     int        = null, 
   @o_id_resultado   smallint  = null out		 
		 		 
AS

declare @w_tramite          int,
      @w_cliente          int,
      @w_toperacion       catalogo,
      @w_resultado_ln     smallint,
      @w_resultado        varchar(100),
      @w_grupo            int       
        

---Número de operacion
select @w_tramite = io_campo_3
from   cob_workflow..wf_inst_proceso
where  io_id_inst_proc= @i_id_inst_proc

select @w_toperacion = op_toperacion
from cob_cartera..ca_operacion OP 
where op_tramite = @w_tramite

-- Busqueda del cliente

select @w_resultado    = 'NOK'
select @w_resultado_ln = 3

create table #cliente_tmp(
   cliente_tmp int
)
     
print '---->>OPERACION:'+@w_toperacion

if(@w_toperacion = 'GRUPAL')
begin
   select @w_grupo = tg_grupo
   from   cr_tramite_grupal
   where  tg_tramite       =   @w_tramite
   
   insert into #cliente_tmp
   select tg_cliente
   from   cr_tramite_grupal
   where  tg_tramite       =   @w_tramite
   and    tg_participa_ciclo <> 'N'
   and    tg_monto > 0
   order by tg_cliente	
end 
else
begin
   insert into #cliente_tmp
   select op_cliente
   from   cr_tramite , cob_cartera..ca_operacion
   where  tr_tramite = @w_tramite
   and    op_tramite = tr_tramite
   
   insert into #cliente_tmp	
   select tr_alianza from cr_tramite 
   where tr_tramite = @w_tramite
   and   tr_alianza is not null	
end	

declare cliente_tmp cursor for 
select  cliente_tmp
from   #cliente_tmp
for read only

open cliente_tmp    
fetch cliente_tmp into @w_cliente

while @@fetch_status = 0
begin   
   
   exec sp_li_negra_cliente
   @i_ente         = @w_cliente,
   @o_resultado    = @w_resultado_ln output
   
   print '---->>>ID CLIENTE:'+convert(varchar(30),@w_cliente) + '---->>>RESULTADO LISTA NEGRA:'+convert(varchar(30),@w_resultado_ln)
   
   if @w_resultado_ln != 1
      break;
   
   fetch cliente_tmp into @w_cliente

end -- while

drop table #cliente_tmp
   
if  @w_resultado_ln = 1
   select @w_resultado = 'OK'    	
-- Select para ver si existe la regla    
-- 1 no esta y 3 si esta
print '---->>sp_revis_buro_list_negras - @w_resultado:'+convert(varchar(30),@w_resultado)

if @w_resultado = 'OK'
begin
   select @o_id_resultado = 1 -- OK
   print 'Estamos en el OK'
end
else
begin
   select @o_id_resultado = 2 -- DEVOLVER
   print 'Estamos en el DEVOLVER'
end

return 0

go
