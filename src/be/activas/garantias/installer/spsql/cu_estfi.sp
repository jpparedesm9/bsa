/************************************************************************/
/*	Archivo: 	        cu_estfi.sp                 	        */
/*	Stored procedure:       sp_estados_finagro                      */
/*	Base de datos:  	cob_custodia                            */
/*	Producto:               Garantias                               */
/*	Fecha de escritura:     22/Abril/2005                           */
/************************************************************************/
/*				IMPORTANTE			        */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".					        */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus	        */
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Mantenimiento de la tabla cu_concilia_cert que contiene las     */
/*  diferencias entre las garantias finagro y las de la entidad         */
/************************************************************************/
/*			        MODIFICACIONES   		        */
/*      FECHA            AUTOR	               RAZON                    */
/*    22/Abrl/2005     Elkin Latorre      Emision Inicial		*/
/*    18/Octubre/2016  Jorge Salazar      Migracion Cobis Cloud		*/
/************************************************************************/
use cob_custodia
go
if exists (SELECT 1 FROM sysobjects WHERE name = 'sp_estados_finagro')
    drop proc sp_estados_finagro
go
create proc sp_estados_finagro
as
declare
   @w_today              datetime,     
   @w_return             int,          
   @w_sp_name            varchar(32),  
   @w_existe             tinyint,
   @w_error_act          int, 
   @w_error              int,
   @w_mensaje            varchar(255),
   @w_tipo_esp           varchar(30),
   @w_certif             varchar(30),
   @w_estado_cer         char(1),
   @w_estado_gar         catalogo,
   @w_tramite            int,
   @w_codigo_externo     varchar(64),
   @w_oficina  		 smallint


SELECT @w_sp_name = 'sp_estados_finagro'



truncate table cu_tmp_finagro
truncate table cu_concilia_cert


select @w_tipo_esp = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'FAG'
set transaction isolation level READ UNCOMMITTED

if @w_tipo_esp is null
begin
  print 'No existe el parametro para las garantias FAG'
end

--CREACION DE LA TABLA TEMPORAL DE TIPOS DE GARANTIAS
create table #tipos_gar
(tipo   varchar(64)
)

CREATE NONCLUSTERED INDEX tiposgar_Key
    ON #tipos_gar(tipo)


insert into #tipos_gar
select tc_tipo  
from cob_custodia..cu_tipo_custodia
where tc_tipo = @w_tipo_esp
union
select tc_tipo 
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior 	= @w_tipo_esp
union
select tc_tipo 
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior in (select tc_tipo 
	                   from   cob_custodia..cu_tipo_custodia
                           where  tc_tipo_superior = @w_tipo_esp)


declare cur_oficina cursor for
   select  of_oficina  
   from    cobis..cl_oficina
   where   of_oficina > 0
   for     read only
    
open    cur_oficina
fetch   cur_oficina into @w_oficina

while @@fetch_status = 0
begin
   if @@fetch_status = -1
   begin
      close cur_oficina
      deallocate cur_oficina
      select @w_error = 21000
      goto ERROR
   end
   insert into cu_tmp_finagro
   select cu_num_dcto, 
          cu_estado, 
          cu_codigo_externo, 
          gp_tramite
   from   cob_credito..cr_gar_propuesta, 
         cob_custodia..cu_custodia,
	 cob_cartera..ca_operacion,
         cob_credito..cr_tramite
   where  gp_garantia = cu_codigo_externo
   and    cu_estado   in ('P','V','F','X','C')
   and    cu_tipo     in (select tipo from #tipos_gar)
   and    gp_tramite > 0
   and    op_tramite = gp_tramite
   and    tr_tramite = gp_tramite
   and    gp_garantia > ''
   and	  tr_tipo    in ('O','R','M')  -- CCA 436 Normalizacion
   and    cu_filial = 1
   and    cu_custodia > 0
   and    cu_tipo > ''
   and    cu_sucursal > 0
   and    cu_num_dcto is not null
   and op_tramite = gp_tramite
   and op_estado not in (3,6)
   and op_oficina = @w_oficina

   fetch   cur_oficina into @w_oficina
end
close cur_oficina
deallocate cur_oficina
-------------------------------------------------------------------
--   	Garantias FAG con estado diferente entre FINAGRO y Banco --
-------------------------------------------------------------------
insert into cu_concilia_cert
select  '',
        '',
        0,
        '',
        '',
        0,
        ft_certificadow, 
        cu_estado_tmp,
        (select codigo_sib
         from cob_credito..cr_corresp_sib
         where tabla = 'T35'
         and codigo = t.ft_estado) ,
	'',
        cu_codigo_externo_tmp,
        'ESTADO DIFERENTE',
        cu_tramite_tmp
from    cob_custodia..cu_finagro_tmpw_def t,
        cob_custodia..cu_tmp_finagro
where   cu_num_dcto_tmp = ft_certificadow
and     ft_certificadow > ''
and     cu_num_dcto_tmp > ''
and cu_estado_tmp <> (select codigo_sib
                      from cob_credito..cr_corresp_sib
                      where tabla = 'T35'
                      and codigo = t.ft_estado)


if @@error != 0
BEGIN
   PRINT 'ERROR al Ingresar datos en cu_tmp_finagro, Garantias FAG con estado diferente entre FINAGRO y Banco'
END

-------------------------------------------------------------------
-- Garantias que están en el Banco pero no en el archivo FINAGRO --
-------------------------------------------------------------------
insert into cu_concilia_cert
select  '',
        '',
        0,
        '',
        '',
        0,
        cu_num_dcto_tmp, 
    	cu_estado_tmp,
        '',
	'',
        cu_codigo_externo_tmp, 
	'EN BANCO', 
    	cu_tramite_tmp
from    cob_custodia..cu_tmp_finagro        
where  cu_num_dcto_tmp  not in (select ft_certificadow  from cob_custodia..cu_finagro_tmpw_def where ft_certificadow > '' )
and     cu_num_dcto_tmp > ''

if @@error != 0
BEGIN
   PRINT 'ERROR al Ingresar datos en cu_tmp_finagro, Garantias que están en el Banco pero no en el archivo FINAGRO'
END

-------------------------------------------------------------------
--  	Garantias que están en FINAGRO pero no en el Banco       --
-------------------------------------------------------------------
insert into cu_concilia_cert
select  ft_redescuento,
        convert(varchar,convert(datetime,ft_fecha_desembolsow,103),101),
        null,
        ft_identificacionw,
        ft_nom_cliente,
        convert(money,isnull(ft_valor_desembolsow,'0')),
        ft_certificadow,
        '',
    	ft_estado,
	'',
        '',
    	'EN FINAGRO',
        null                                                       
from 	cob_custodia..cu_finagro_tmpw_def
where   ft_certificadow not in (select cu_num_dcto_tmp
                                from   cob_custodia..cu_tmp_finagro)
if @@error != 0
BEGIN
   PRINT 'ERROR al Ingresar datos en cu_tmp_finagro, Garantias que están en FINAGRO pero no en el Banco'
END

update cu_concilia_cert
set    cc_llave_red   = op_codigo_externo,
       cc_fecha_red   =  convert(varchar(10),op_fecha_ini,103),
       cc_cod_cliente = op_cliente,
       cc_nom_cli     = op_nombre,
       cc_val_red     = op_monto
from   cob_cartera..ca_operacion
Where  op_tramite     = cc_tramite
and    cc_tipo        in ('ESTADO DIFERENTE','EN BANCO')

update cu_concilia_cert
set    cc_id_cliente  = en_ced_ruc 
from   cobis..cl_ente
where  cc_cod_cliente = en_ente
and    cc_tipo        in ('ESTADO DIFERENTE','EN BANCO')

update cu_concilia_cert
set    cc_desc_fin = substring(descripcion_sib,1,25)
from cob_credito..cr_corresp_sib
where tabla = 'T35'
and codigo = cc_est_fin
and    cc_tipo        in ('ESTADO DIFERENTE','EN BANCO','EN FINAGRO')


return 0

ERROR:
exec cobis..sp_cerror
     @t_debug  = 'N',
     @t_file   = null,
     @t_from   = @w_sp_name,
     @i_num    = @w_error
return @w_error

go


