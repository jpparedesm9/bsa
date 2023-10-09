/************************************************************************/
/*  Archivo:                   docgar.sp                                */
/*  Stored procedure:          sp_documen_gar                           */
/*  Base de datos:             cob_custodia                             */    
/*  Producto:                  Custodia                                 */
/*  Disenado por:              Milena Gonzalez                          */
/*  Fecha de escritura:        28-Nov-2002                              */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de              */
/*  AT&T GIS  .                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                                                                      */
/************************************************************************/
/*              PROPOSITO                                               */
/*    Este programa Consulta las Garantias a las cuales se requiere     */
/*    generar el formato Solicitud de consultas y/o documentos a la     */
/*    central de custodia                                               */
/*                                                                      */
/************************************************************************/
/*                                                                      */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/************************************************************************/


use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_documen_gar')
   drop proc sp_documen_gar
go

create proc sp_documen_gar(
   @s_date            		datetime = null,
   @s_user            		login = null,
   @t_debug           		char(1) = 'N',
   @t_trn                       smallint = null,
   @t_file            		varchar(14) = null,
   @t_from            		varchar(32) = null,
   @i_operacion       		char(1) = null,
   @i_custodia  		int = null,
   @i_num_obligacion 	        cuenta = null,
   @i_documento                 money = null,
   @i_ubicacion_garantia 	catalogo = null,
   @i_usuario_solicita 		login = null,
   @i_motivo_solicitud 		catalogo = null,
   @i_numero_folios 		varchar(64) = null,
   @i_observacion 		varchar(255) = null,
   @i_fecha_solicitud 		datetime = null,
   @i_fecha_modif 		datetime = null,
   @i_fecha_recibo 		datetime = null,
   @i_fecha_envio 		datetime = null,
   @i_estado_doc		catalogo  = null,
   @i_modo                      smallint = null,
   @i_tipo_cust                 varchar(64) = null,
   @i_oficina                   smallint = null,
   @i_cliente                   int = null,
   @i_motivo                    catalogo = null
)
as
Declare 
   @w_sp_name          varchar(25),
   @w_codigo_externo   varchar(64),
   @w_tipo             varchar(64),
   @w_num_operacion    cuenta,
   @w_ultimo           int,
   @w_custodia         int,
   @w_documento        money,
   @w_ubicacion_garantia catalogo,
   @w_usuario_solicita catalogo,
   @w_motivo_solicitud catalogo,
   @w_numero_folios    varchar(64),
   @w_observaciones    varchar(255),
   @w_fecha_solicitud  datetime,
   @w_fecha_recibo     datetime,
   @w_fecha_envio      datetime,
   @w_estado_doc       catalogo,
   @w_fecha_modif      datetime,
   @w_existe           smallint,
   @w_desc_ubicacion   varchar(255),
   @w_desc_motivo      varchar(255),
   @w_desc_tipo        varchar(255),
   @w_desc_estado      varchar(255),
   @w_oficina          smallint,
   @w_desc_ofi         varchar(255),
   @w_ub_doc	       smallint,
   @w_mo_sol	       smallint,
   @w_es_doc	       smallint


    
select @w_sp_name = 'sp_documen_gar'




select	@w_ub_doc = codigo
from	cobis..cl_tabla 
where	tabla = 'cu_ubicacion_doc'
set transaction isolation level read uncommitted

select	@w_mo_sol = codigo
from	cobis..cl_tabla 
where	tabla = 'cu_motivo_sol'
set transaction isolation level read uncommitted

select	@w_es_doc = codigo
from	cobis..cl_tabla 
where	tabla = 'cu_estado_doc'
set transaction isolation level read uncommitted


if @i_operacion <> 'S'
begin
    if @i_oficina is not null 
    begin --1
      if @i_num_obligacion is not null
      begin --2
        if @i_tipo_cust  is not null
        begin --3
          if @i_documento  is not null --paso1
          begin --4
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_num_operacion = @i_num_obligacion)
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0
          end --4
          else --paso 2
          begin --5
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_num_operacion = @i_num_obligacion)
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0          end --5
       end --3
       else 
       begin --6
         if @i_documento is not null --paso 3
         begin --7
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   (dg_num_operacion = @i_num_obligacion)
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0        
            end --7
         else --paso 4
         begin --8
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   (dg_num_operacion = @i_num_obligacion)
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0         
         end --8
       end --6
     end --2
     else 
     begin --9
       if @i_tipo_cust  is not null 
       begin --10
         if @i_documento is not null --paso 5
         begin --11
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0
         end  --11
         else --paso 6
         begin --12
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0
         end --12
       end --10
       else
       begin --13
         if @i_documento is not null --paso 7
         begin --14
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0
         end --14
         else --paso 8
         begin --15
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where (dg_oficina  = @i_oficina)
	    and   dg_custodia = @i_custodia 
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0
         end --15
    end --13
   end --9
end --1
    else
    begin --16
      if @i_num_obligacion is not null
      begin --17
        if @i_tipo_cust is not null
        begin  --18
          if @i_documento is not null -- paso 9
          begin --19
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_num_operacion = @i_num_obligacion)
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

          end --19
          else --paso 10
          begin --20
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_num_operacion = @i_num_obligacion)
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

          end --20
        end --18
        else
        begin --21
          if @i_documento is not null  --paso 11
          begin --22
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where  dg_custodia = @i_custodia 
	    and   (dg_num_operacion = @i_num_obligacion)
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

          end --22
         else --paso 12
         begin --23
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where dg_custodia = @i_custodia 
	    and   (dg_num_operacion = @i_num_obligacion)
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

         end --23
      end --21
    end ----17
      else
      begin --24
        if @i_tipo_cust is not null
        begin --25
          if @i_documento is not null --paso 13
          begin --26
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where   dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

          end --26
          else --paso 14
          begin --27
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where dg_custodia = @i_custodia 
	    and   dg_tipo     = @i_tipo_cust
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

          end --27
       end --25
       else --paso 15
       begin --28
         if @i_documento is not null
         begin --29
	   select  @w_oficina = dg_oficina,
		@w_custodia = dg_custodia,
  	        @w_tipo = dg_tipo,
	        @w_documento = dg_documento,
	        @w_num_operacion = dg_num_operacion,
   	        @w_ubicacion_garantia = dg_ubicacion_garantia,
	        @w_usuario_solicita = dg_usuario_solicita,
	        @w_motivo_solicitud = dg_motivo_solicitud,
	        @w_numero_folios = dg_numero_folios,
	        @w_observaciones = dg_observaciones,
	        @w_fecha_solicitud = dg_fecha_solicitud,
	        @w_fecha_recibo = dg_fecha_recibo,
	        @w_fecha_envio = dg_fecha_envio,
	        @w_estado_doc = dg_estado_doc,
	        @w_fecha_modif = dg_fecha_modif
	    from cob_custodia..cu_doc_garantia
	    where  dg_custodia = @i_custodia 
	    and   (dg_documento = @i_documento )
	    if @@rowcount > 0           
	        select @w_existe = 1
	    else
	       select @w_existe = 0

        end --29
    end --28
end --24
end --16
--end

end



/*****************[VALIDACION DE CAMPO NULOS]********************/

if @i_operacion = 'I'
begin
   if (@i_custodia is NULL and @i_tipo_cust is null)
   begin
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 2101001
      return 1 
      /*'ERROR CAMPOS NOT NULL CON VALORES NULOS'*/
   end
end


if @i_operacion = "I"
begin
   begin tran

       select @w_ultimo = isnull(max(dg_documento),0)+1
       from cob_custodia..cu_doc_garantia
       where dg_custodia  = @i_custodia
       and   dg_tipo      = @i_tipo_cust
       and   dg_num_operacion = @i_num_obligacion
       and   dg_oficina = @i_oficina


       insert into cu_doc_garantia (
       dg_oficina,dg_custodia,dg_tipo,dg_documento,dg_num_operacion, dg_ubicacion_garantia,
       dg_usuario_solicita, dg_motivo_solicitud,dg_numero_folios,
       dg_observaciones, dg_fecha_solicitud,dg_fecha_recibo,dg_fecha_envio,dg_estado_doc,
       dg_fecha_modif)
       values (
       @i_oficina,@i_custodia,@i_tipo_cust,@w_ultimo,@i_num_obligacion,@i_ubicacion_garantia,@i_usuario_solicita, 
       @i_motivo_solicitud,@i_numero_folios,@i_observacion,
       @i_fecha_solicitud, @i_fecha_recibo, @i_fecha_envio,@i_estado_doc,@i_fecha_modif)

       if @@error <> 0 
       begin
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 2103001
          return 1 
       end

   select @w_ultimo

   commit tran

end


/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    begin tran
         update cob_custodia..cu_doc_garantia
         set 
	     dg_num_operacion = @i_num_obligacion,
             dg_ubicacion_garantia= @i_ubicacion_garantia,
             dg_usuario_solicita  = @i_usuario_solicita,
             dg_motivo_solicitud  = @i_motivo_solicitud,
	     dg_numero_folios =    @i_numero_folios,
             dg_estado_doc        = @i_estado_doc, 
             dg_observaciones     = @i_observacion,
	     dg_fecha_solicitud   = isnull(@i_fecha_solicitud,dg_fecha_solicitud),
	     dg_fecha_recibo      = isnull(@i_fecha_recibo,dg_fecha_recibo),
	     dg_fecha_envio       = isnull(@i_fecha_envio,dg_fecha_envio),
	     dg_fecha_modif       = isnull(@i_fecha_modif,dg_fecha_modif)
         where 
             dg_oficina   = @i_oficina   and
             dg_custodia  = @w_custodia  and
             dg_tipo      = @w_tipo and
             dg_documento = @w_documento 

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end
    commit tran

    return 0
end

if @i_operacion = "S"
begin  
 if @i_modo = 0
 begin  
   set rowcount 10   
    if @i_oficina is not null
    begin --1
      if @i_custodia is not null
      begin --2
        if @i_cliente is not null
        begin --3
          if @i_documento is not null --paso1
          begin --4
	    select
	    "Cliente" =			C.cg_ente,
	    "Garantia" =		B.dg_custodia,
	    "Tipo Garantia" =		B.dg_tipo,
	    "Oficina"       =		B.dg_oficina,
	    "No. Obligacion"=		B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
					and	B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=		B.dg_usuario_solicita,
	    "Motivo" =		   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
					and	B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" =		B.dg_numero_folios,
	    "Observaciones" =		B.dg_observaciones,
	    "Fecha Solicitud"=		convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" =		convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =		convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." =		convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =		B.dg_documento
	   from	 cu_doc_garantia B, 
	 	 cu_cliente_garantia C
	   where (B.dg_oficina		= @i_oficina ) 
           and   (B.dg_tipo		= @i_tipo_cust ) 
	   and   (B.dg_custodia		= @i_custodia )
	   and   (B.dg_documento	= @i_documento )
	   and   (B.dg_tipo		= C.cg_tipo_cust)
	   and   (B.dg_oficina		= C.cg_sucursal)
	   and   (C.cg_ente		= @i_cliente )
	   and   (C.cg_tipo_garante	in ("C","J"))
	   and   (B.dg_custodia		= C.cg_custodia)
	   and   C.cg_sucursal		= B.dg_oficina
	   and   C.cg_tipo_cust		= B.dg_tipo
	   and   C.cg_custodia		= B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --4
          else --paso 2
          begin --5
	     select
	    "Cliente" =			C.cg_ente,
	    "Garantia" =		B.dg_custodia,
	    "Tipo Garantia" =		B.dg_tipo,
	    "Oficina"       =		B.dg_oficina,
	    "No. Obligacion"=		B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla			= @w_ub_doc
					and	B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=		B.dg_usuario_solicita,
	    "Motivo" =		   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla			= @w_mo_sol
					and	B.dg_motivo_solicitud	= X.codigo),  
	    "No. Folio" =		B.dg_numero_folios,
	    "Observaciones" =		B.dg_observaciones,
	    "Fecha Solicitud"=		convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" =		convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =		convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." =		convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =		B.dg_documento
	     from  cu_doc_garantia B, 
		   cu_cliente_garantia C
	     where (B.dg_oficina = @i_oficina ) 
	     and   (B.dg_custodia = @i_custodia )
             and   (B.dg_tipo = @i_tipo_cust ) 
	     and   (B.dg_tipo = C.cg_tipo_cust)
	     and   (B.dg_oficina = C.cg_sucursal)
   	     and   (C.cg_ente = @i_cliente )
	     and   (C.cg_tipo_garante in ("C","J"))
	     and   (B.dg_custodia = C.cg_custodia)
	     and   C.cg_sucursal = B.dg_oficina
	     and   C.cg_tipo_cust = B.dg_tipo
	     and   C.cg_custodia = B.dg_custodia
	     order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --5
       end --3
       else 
       begin --6
         if @i_documento is not null --paso 3
         begin --7
	    select
	    "Cliente" =			C.cg_ente,
	    "Garantia" =		B.dg_custodia,
	    "Tipo Garantia" =		B.dg_tipo,
	    "Oficina"       =		B.dg_oficina,
	    "No. Obligacion"=		B.dg_num_operacion,
	    "Ubicacion Garantia" =(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
					and	B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=		B.dg_usuario_solicita,
	    "Motivo" =		  (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
					and	B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" =		B.dg_numero_folios,
	    "Observaciones" =		B.dg_observaciones,
	    "Fecha Solicitud"=		convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" =		convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =		convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	  (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." =		convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =		B.dg_documento
  	     from  cu_doc_garantia B, 
		   cu_cliente_garantia C
	     where (B.dg_oficina = @i_oficina) 
	     and   (B.dg_custodia = @i_custodia )
	     and   (B.dg_documento = @i_documento )
             and   (B.dg_tipo = @i_tipo_cust ) 
	     and   (B.dg_tipo = C.cg_tipo_cust)
	     and   (B.dg_oficina = C.cg_sucursal)
	     and   (C.cg_tipo_garante in ("C","J"))
	     and   (B.dg_custodia = C.cg_custodia)
	     and   C.cg_sucursal = B.dg_oficina
	     and   C.cg_tipo_cust = B.dg_tipo
	     and   C.cg_custodia = B.dg_custodia
   	     and   C.cg_filial= 1
	     order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --7
         else --paso 4
         begin --8
             select
	    "Cliente" =			C.cg_ente,
	    "Garantia" =		B.dg_custodia,
	    "Tipo Garantia" =		B.dg_tipo,
	    "Oficina"       =		B.dg_oficina,
	    "No. Obligacion"=		B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
					and	B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=		B.dg_usuario_solicita,
	    "Motivo" =		   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
					and	B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" =		B.dg_numero_folios,
	    "Observaciones" =		B.dg_observaciones,
	    "Fecha Solicitud"=		convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" =		convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =		convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." =		convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =		B.dg_documento
	   from  cu_doc_garantia B, 
		 cu_cliente_garantia C
	   where (B.dg_oficina = @i_oficina) 
	   and   (B.dg_custodia = @i_custodia )
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and	 C.cg_sucursal = B.dg_oficina
	   and   C.cg_tipo_cust = B.dg_tipo
	   and   C.cg_custodia = B.dg_custodia
	   and   C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --8
       end --6
     end --2
     else 
     begin --9
       if @i_cliente is not null 
       begin --10
         if @i_documento is not null --paso 5
         begin --11
            select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =             (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_documento = @i_documento )
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end  --11
         else --paso 6
         begin --12
           	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =             (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =        (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --12
       end --10
       else
       begin --13
         if @i_documento is not null --paso 7
         begin --14
             select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		   (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_documento = @i_documento )
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --14
         else --paso 8
         begin --15
   	   select
	   "Cliente" = C.cg_ente,
	   "Garantia" = B.dg_custodia,
	   "Tipo Garantia" = B.dg_tipo,
	   "Oficina"       =  B.dg_oficina,
	   "No. Obligacion"= B.dg_num_operacion,
	   "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
                	           and B.dg_ubicacion_garantia = X.codigo),
	   "Usuario Solicita"=  B.dg_usuario_solicita,
	   "Motivo" =		  (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
                        	   and B.dg_motivo_solicitud = X.codigo),  
	   "No. Folio" = B.dg_numero_folios,
	   "Observaciones" = B.dg_observaciones,
	   "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	   "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	   "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	   "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
                        	   and B.dg_estado_doc = X.codigo),
	   "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	   "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   and C.cg_filial= 1 
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --15
    end --13
   end --9
end --1
    else
    begin --16
      if @i_custodia is not null
      begin --17
        if @i_cliente is not null
        begin  --18
          if @i_documento is not null -- paso 9
          begin --19
             select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where        
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_documento = @i_documento)
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --19
          else --paso 10
          begin --20
            	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_tipo = C.cg_tipo_cust)
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --20
        end --18
        else
        begin --21
          if @i_documento is not null  --paso 11
          begin --22
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_documento = @i_documento )
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --22
         else --paso 12
         begin --23
	   select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia)
	   and   (B.dg_tipo = C.cg_tipo_cust)
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --23
      end --21
    end ----17
      else
      begin --24
        if @i_cliente is not null
        begin --25
          if @i_documento is not null --paso 13
          begin --26
            select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_documento = @i_documento )
	   and   (B.dg_tipo = C.cg_tipo_cust)
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --26
          else --paso 14
          begin --27
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_tipo = C.cg_tipo_cust)
           and   (B.dg_tipo = @i_tipo_cust ) 
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_ente = @i_cliente )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --27
       end --25
       else --paso 15
       begin --28
         if @i_documento is not null
         begin --29
            select
    	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
                        	 and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
                        	 and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
                        		and B.dg_estado_doc = X.codigo),
   	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
   	    from	cu_doc_garantia B, 
			cu_cliente_garantia C
	    where 
  	          (B.dg_documento = @i_documento )
            and   (B.dg_tipo = @i_tipo_cust ) 
 	    and   (B.dg_tipo = C.cg_tipo_cust)
	    and   (B.dg_oficina = C.cg_sucursal)
	    and   (C.cg_tipo_garante in ("C","J"))
	    and   (B.dg_custodia = C.cg_custodia)
	    and C.cg_sucursal = B.dg_oficina
	    and C.cg_tipo_cust = B.dg_tipo
	    and C.cg_custodia = B.dg_custodia
            and C.cg_filial= 1
	    order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
        end --29
    end --28
end --24
end --16
set rowcount 0
end

if @i_modo = 1
   begin
   set rowcount 10
    if @i_oficina is not null
    begin --1
      if @i_custodia is not null
      begin --2
        if @i_tipo_cust  is not null
        begin --3
          if @i_motivo  is not null --paso1
          begin --4
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
     	   and   (B.dg_custodia = @i_custodia )
	   and   (B.dg_motivo_solicitud = @i_motivo )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --4
          else --paso 2
          begin --5
	     select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	     from	cu_doc_garantia B, 
			cu_cliente_garantia C
	     where 
	           (B.dg_oficina = @i_oficina ) 
	     and   (B.dg_custodia = @i_custodia )
	     and   (B.dg_tipo = C.cg_tipo_cust)
	     and   (B.dg_oficina = C.cg_sucursal)
   	     and   (B.dg_tipo = @i_tipo_cust )
	     and   (C.cg_tipo_garante in ("C","J"))
	     and   (B.dg_custodia = C.cg_custodia)
	     and C.cg_sucursal = B.dg_oficina
	     and C.cg_tipo_cust = B.dg_tipo
	     and C.cg_custodia = B.dg_custodia
             and C.cg_filial=1 
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --5
       end --3
       else 
       begin --6
         if @i_motivo is not null --paso 3
         begin --7
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
  	     from	cu_doc_garantia B, 
			cu_cliente_garantia C
	     where 
	           (B.dg_oficina = @i_oficina) 
	     and   (B.dg_custodia = @i_custodia )
	     and   (B.dg_motivo_solicitud = @i_motivo )
	     and   (B.dg_tipo = C.cg_tipo_cust)
	     and   (B.dg_oficina = C.cg_sucursal)
	     and   (C.cg_tipo_garante in ("C","J"))
	     and   (B.dg_custodia = C.cg_custodia)
	     and C.cg_sucursal = B.dg_oficina
	     and C.cg_tipo_cust = B.dg_tipo
	     and C.cg_custodia = B.dg_custodia
             and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --7
         else --paso 4
         begin --8
             select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina) 
	   and   (B.dg_custodia = @i_custodia )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --8
       end --6
     end --2
     else 
     begin --9
       if @i_tipo_cust  is not null 
       begin --10
         if @i_motivo is not null --paso 5
         begin --11
            select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		  (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
					and	B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_motivo_solicitud = @i_motivo )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1 
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end  --11
         else --paso 6
         begin --12
           	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --12
       end --10
       else
       begin --13
         if @i_motivo is not null --paso 7
         begin --14
             select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_motivo_solicitud = @i_motivo )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
	   and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --14
         else --paso 8
         begin --15
   	   select
	   "Cliente" = C.cg_ente,
	   "Garantia" = B.dg_custodia,
	   "Tipo Garantia" = B.dg_tipo,
	   "Oficina"       =  B.dg_oficina,
	   "No. Obligacion"= B.dg_num_operacion,
	   "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
                	           and B.dg_ubicacion_garantia = X.codigo),
	   "Usuario Solicita"=  B.dg_usuario_solicita,
	   "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
                        	   and B.dg_motivo_solicitud = X.codigo),  
	   "No. Folio" = B.dg_numero_folios,
	   "Observaciones" = B.dg_observaciones,
	   "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	   "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	   "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	   "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
                        	   and B.dg_estado_doc = X.codigo),
	   "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	   "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_oficina = @i_oficina ) 
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --15
    end --13
   end --9
end --1
    else
    begin --16
      if @i_custodia is not null
      begin --17
        if @i_tipo_cust is not null
        begin  --18
          if @i_motivo is not null -- paso 9
          begin --19
             select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where        
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_motivo_solicitud = @i_motivo)
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --19
          else --paso 10
          begin --20
            	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --20
        end --18
        else
        begin --21
          if @i_motivo is not null  --paso 11
          begin --22
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
					and	B.dg_estado_doc	= X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B,	
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia )
	   and   (B.dg_motivo_solicitud = @i_motivo )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --22
         else --paso 12
         begin --23
	   select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." =	(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_custodia = @i_custodia)
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
         end --23
      end --21
    end ----17
      else
      begin --24
        if @i_tipo_cust is not null
        begin --25
          if @i_motivo is not null --paso 13
          begin --26
            select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_motivo_solicitud = @i_motivo )
	   and   (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --26
          else --paso 14
          begin --27
	    select
	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
	                            and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
	                            and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
	                            and B.dg_estado_doc = X.codigo),
	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
	   from		cu_doc_garantia B, 
			cu_cliente_garantia C
	   where 
	         (B.dg_tipo = C.cg_tipo_cust)
	   and   (B.dg_oficina = C.cg_sucursal)
	   and   (B.dg_tipo = @i_tipo_cust )
	   and   (C.cg_tipo_garante in ("C","J"))
	   and   (B.dg_custodia = C.cg_custodia)
	   and C.cg_sucursal = B.dg_oficina
	   and C.cg_tipo_cust = B.dg_tipo
	   and C.cg_custodia = B.dg_custodia
           and C.cg_filial= 1
	   order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
          end --27
       end --25
       else --paso 15
       begin --28
         if @i_motivo is not null
         begin --29
            select
    	    "Cliente" = C.cg_ente,
	    "Garantia" = B.dg_custodia,
	    "Tipo Garantia" = B.dg_tipo,
	    "Oficina"       =  B.dg_oficina,
	    "No. Obligacion"= B.dg_num_operacion,
	    "Ubicacion Garantia" = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_ub_doc
                        	 and B.dg_ubicacion_garantia = X.codigo),
	    "Usuario Solicita"=  B.dg_usuario_solicita,
	    "Motivo" =		(	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_mo_sol
                        	 and B.dg_motivo_solicitud = X.codigo),  
	    "No. Folio" = B.dg_numero_folios,
	    "Observaciones" = B.dg_observaciones,
	    "Fecha Solicitud"= convert(varchar(10),B.dg_fecha_solicitud,101),
	    "Fecha Recibo" = convert(varchar(10),B.dg_fecha_recibo,101),
	    "Fecha Envio" =convert(varchar(10),B.dg_fecha_envio,101),
	    "Estado Doc." = (	select	valor 
					from	cobis..cl_catalogo X
					where	X.tabla		= @w_es_doc
                        	 and B.dg_estado_doc = X.codigo),
   	    "Fecha Modif." = convert(varchar(10),B.dg_fecha_modif,101),
	    "Documento" =B.dg_documento
   	    from	cu_doc_garantia B, 
			cu_cliente_garantia C
	    where 
  	          (B.dg_motivo_solicitud = @i_motivo )
 	    and   (B.dg_tipo = C.cg_tipo_cust)
	    and   (B.dg_oficina = C.cg_sucursal)
	    and   (C.cg_tipo_garante in ("C","J"))
	    and   (B.dg_custodia = C.cg_custodia)
	    and C.cg_sucursal = B.dg_oficina
	    and C.cg_tipo_cust = B.dg_tipo
	    and C.cg_custodia = B.dg_custodia
            and C.cg_filial= 1
	    order by  B.dg_oficina,B.dg_custodia,B.dg_tipo,B.dg_num_operacion,dg_documento,dg_fecha_modif
        end --29
    end --28
end --24
end --16
   set rowcount 0
   end
end


if @i_operacion = "Q"
begin
    if @w_existe = 1
    begin 
            
          --Catalogos
           select @w_desc_ubicacion = valor
           from   cobis..cl_tabla a, cobis..cl_catalogo b
           where  a.tabla = 'cu_ubicacion_doc'
           and    b.codigo = @w_ubicacion_garantia
           and    a.codigo = b.tabla
	   set transaction isolation level read uncommitted

           select @w_desc_motivo = valor
           from   cobis..cl_tabla a, cobis..cl_catalogo b
           where  a.tabla = 'cu_motivo_sol'
           and    b.codigo = @w_motivo_solicitud
           and    a.codigo = b.tabla
	   set transaction isolation level read uncommitted

           select @w_desc_estado = valor
           from   cobis..cl_tabla a, cobis..cl_catalogo b
           where  a.tabla = 'cu_estado_doc'
           and    b.codigo = @w_estado_doc
           and    a.codigo = b.tabla
           set transaction isolation level read uncommitted

           
           --jvc junio 2002
           select @w_desc_ofi = of_nombre 
           from   cobis..cl_oficina
           where  of_oficina = @w_oficina
           set transaction isolation level read uncommitted
             
	 
           select   
	   @w_custodia,
	   @w_tipo,
	   @w_documento,
	   @w_num_operacion,
	   @w_ubicacion_garantia,
	   @w_desc_ubicacion,
	   @w_usuario_solicita,
	   @w_motivo_solicitud,
           @w_desc_motivo,
	   @w_numero_folios,
	   @w_observaciones,
           convert(varchar(10),@w_fecha_solicitud,101),
           convert(varchar(10),@w_fecha_recibo,101),
           convert(varchar(10),@w_fecha_envio,101),
	   @w_estado_doc,
           @w_desc_estado,
           convert(varchar(10),@w_fecha_modif,101),
           @w_oficina,
           @w_desc_ofi

    end else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901005
        return 1 
    end
    return 0
end



return 0
go
