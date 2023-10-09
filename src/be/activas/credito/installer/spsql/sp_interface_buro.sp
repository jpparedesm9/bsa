/**********************************************************************/
/*   ARCHIVO:         sp_interface_buro.sp  			              */
/*   NOMBRE LOGICO:   sp_interface_buro		                          */
/*   PRODUCTO:        COBIS CREDITO                                   */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de MACOSA S.A.                                         */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de MACOSA.                                           */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a MACOSA para obtener ordenes  de secuestro              */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                     PROPOSITO                                      */
/*    Consulta datos de interface buro de credito			          */
/**********************************************************************/
/*                     MODIFICACIONES                                 */
/*   FECHA          AUTOR                       RAZON                 */
/* 30/June/2017    NTR        Emision Inicial                         */
/* 05-07-2019      srojas     Reestructuración Buro histórico         */
/* 29-28-2021      ACH        ERR#162199, contralar varias consultas  */
/* 02/Jun/2021     ACH        Caso#159312-usuario consulta            */
/* 17/May/2022     KVI        Err#180929-etapa en que se consulta     */
/* 20/Jun/2023     DCU        Err#209581-quitar validacion diaria     */
/**********************************************************************/
use cob_credito
GO


IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid = u.uid AND o.name = 'sp_interface_buro' AND u.name = 'dbo' AND o.type = 'P')
    DROP PROCEDURE sp_interface_buro
GO


GO
create procedure sp_interface_buro(
   @s_ssn            int               = null,
   @s_user           login             = null,
   @s_term           varchar(32)       = null,
   @s_date           datetime          = null,
   @s_sesn           int               = null,
   @s_culture        varchar(10)       = null,
   @s_srv            varchar(30)       = null,
   @s_lsrv           varchar(30)       = null,
   @s_ofi            smallint          = null,
   @s_rol            smallint          = NULL,
   @s_org_err        char(1)           = NULL,
   @s_error          int               = NULL,
   @s_sev            tinyint           = NULL,
   @s_msg            descripcion       = NULL,
   @s_org            char(1)           = NULL,
   @t_debug          char(1)           = 'N',
   @t_file           varchar(10)       = null,
   @t_from           varchar(32)       = null,
   @t_trn            smallint          = null,   
   @t_show_version bit  = 0,   --* Mostrar la version del programa
   @i_operacion      char(1),             -- Opcion con la que se ejecuta el programa
   @i_tipo           char(1)           = null,  -- Tipo de busqueda
   @i_modo           int               = null,  -- Modo de consulta
   @i_ente			 int,
   @i_fecha          datetime          = null,
   @i_xml            VARBINARY(8000)   = null,
   @i_riesgo         int               = null,
   @i_folio          varchar(64)       = null,
   @i_tramite        int               = null,
   @i_id_inst_proc   int               = null,
   @i_dias_caducidad int               = null
)
as
declare 
@w_today            datetime,
@w_sp_name          varchar(32),
@w_return           INT,
@w_error_number     int,
@w_toperacion       varchar(30),
@w_tramite          int,
@w_dias_caducidad   int,
@w_fecha_proceso    datetime,
@w_id_inst_act      int,
@w_codigo_act       smallint,
@w_nombre_act       varchar(30),
@w_proc_consulta    varchar(1)

set @w_sp_name = 'sp_interface_buro'

--* VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1 begin
  print 'Stored Procedure=sp_interface_buro Version=1.0.0'
  return 0
end

if (@i_dias_caducidad is null) begin
    select @w_dias_caducidad = isnull(pa_int ,90)
	from cobis..cl_parametro
	where pa_nemonico = 'BCPC'
end else 
    select @w_dias_caducidad = @i_dias_caducidad

if @i_operacion = 'Q'
begin
    if @i_id_inst_proc != '' or @i_id_inst_proc != null -- Inicio Error #180929
	begin 		
		select @w_id_inst_act = ia_id_inst_act, 
		       @w_codigo_act = ia_codigo_act, 
			   @w_nombre_act = ia_nombre_act 
	    from cob_workflow..wf_inst_actividad 
        where ia_id_inst_proc = @i_id_inst_proc
		
		if not exists (select 1 from cobis..cl_catalogo 
                   where tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_etapa_si_cons_buro')
				   and @w_codigo_act = codigo
				   and @w_nombre_act = valor)
	    begin
		    select  @w_proc_consulta = 'N'
		end
		else
		begin 
		    select  @w_proc_consulta = 'S'
		end 
		
		print '---->>>ID CLIENTE:' + convert(varchar(30), @i_ente) + '---->>>INSTANCIA PROCESO:' + convert(varchar(30), @i_id_inst_proc) 
		print '---->>>RESULTADO ETAPA:'
		print '@w_id_inst_act: ' + convert(varchar(30), @w_id_inst_act)
		print '@w_codigo_act: ' + convert(varchar(30), @w_codigo_act)
		print '@w_nombre_act: ' + @w_nombre_act
		print '@w_proc_consulta: ' + @w_proc_consulta
	end -- Fin Error #180929
	
	if --exists (select 1 from cr_interface_buro_tmp_consulta where tc_cliente = @i_ente and tc_estado = 'P') -- Inicio caso#162199
	    @w_proc_consulta = 'N' -- Error #180929
	begin
        select  proc_consulta = 'N'
	end
	else begin
	    insert into cr_interface_buro_tmp_consulta (tc_cliente, tc_estado, tc_fecha) values (@i_ente, 'P', getdate())
        select       proc_consulta = 'S',
					 ib_cliente,
                     ib_fecha,
                     --ib_xml,
                     ib_riesgo,
                     ib_folio
              from cr_interface_buro
              where ib_cliente = @i_ente
                and ib_estado = 'V'
	end
    return 0 ------ Fin caso#162199
end --@i_operacion 'Q'

If @i_operacion = 'I' begin
   if exists(select 1 from cr_interface_buro
             where ib_cliente = @i_ente
   		     and   ib_estado  = 'V'
   		     and   datediff(dd,ib_fecha,getdate()) > @w_dias_caducidad) begin--Vigente 
      select @w_error_number = 351047        
      goto ERROR
   end   
      
   
   insert into cr_interface_buro (ib_cliente, ib_fecha, ib_riesgo, ib_folio, ib_estado, ib_usuario)
   values (@i_ente, @i_fecha, @i_riesgo, @i_folio,  'V', @s_user)	
   
   if @@error <> 0 begin
      select @w_error_number = 357043        
      goto ERROR
   end
   
   
   if @i_tramite is not null begin 
      select @w_toperacion = tr_toperacion 
      from cr_tramite
      where tr_tramite = @i_tramite
      
      if @w_toperacion = 'GRUPAL' begin
         select @w_tramite  = op_tramite
	     from cr_tramite_grupal, cob_cartera..ca_operacion
	     where tg_operacion = op_operacion 
	     and   tg_tramite   = @i_tramite
	     and   tg_cliente   = @i_ente
	     
      end 
      else begin
         select @w_tramite = @i_tramite
      end
      
      update cr_tramite  set
      tr_folio_buro   = @i_folio
      where tr_tramite = @w_tramite
   end 
end  --@i_operacion


if @i_operacion = 'U' begin

	  
   if exists(select 1 from cr_interface_buro where ib_cliente = @i_ente and ib_estado = 'V' and datediff(dd,ib_fecha,getdate()) > @w_dias_caducidad )begin
      update cr_interface_buro set 
      ib_estado  = 'N'
      where ib_cliente = @i_ente
      and   ib_estado  = 'V'
      
      if @@error <> 0 begin
         set @w_error_number = 708152        
         goto ERROR
      end
	  
	  insert into cr_interface_buro (ib_cliente, ib_fecha, ib_riesgo, ib_folio, ib_estado, ib_usuario)
      values (@i_ente, @i_fecha, @i_riesgo, @i_folio, 'V', @s_user)	
	  
	  if @@error <> 0 begin
         select @w_error_number = 357043        
         goto ERROR
      end
   end
   else begin     
      insert into cr_interface_buro (ib_cliente, ib_fecha, ib_riesgo, ib_folio, ib_estado, ib_usuario)
      values (@i_ente, @i_fecha, @i_riesgo, @i_folio, 'V', @s_user)	
      
      if @@error <> 0 begin
         select @w_error_number = 357043        
         goto ERROR
      end
   end
   
   if @i_tramite is not null begin 
      select @w_toperacion = tr_toperacion 
      from cr_tramite
      where tr_tramite = @i_tramite
      
      if @w_toperacion = 'GRUPAL' begin
         select @w_tramite  = op_tramite
	     from cr_tramite_grupal, cob_cartera..ca_operacion
	     where tg_operacion = op_operacion 
	     and   tg_tramite   = @i_tramite
	     and   tg_cliente   = @i_ente
	     
      end 
      else begin
         select @w_tramite = @i_tramite
      end
      
      update cr_tramite  set
      tr_folio_buro   = @i_folio
      where tr_tramite = @w_tramite
   end
  
end  --@i_operacion

return 0

ERROR:
EXEC cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error_number

RETURN @w_error_number

GO

