/************************************************************************/
/*   Archivo:                sp_tr_datos_adicionales_busin.sp           */
/*   Stored procedure:       sp_tr_datos_adicionales_busin              */
/*   Base de datos:          cob_pac                                    */
/*   Producto:               Credito                                    */
/*   Disenado por:           Adriana Chiluisa                           */
/*   Fecha de escritura:     08/Jun./2017                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Consulta de los datos de adicionales de un tramite                 */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA               AUTOR               CAMBIO                     */
/*   JUN-08-2017        Adriana Chiluisa   Version tomada del ambiente  */
/*                                         de pruebas Santander         */
/************************************************************************/

use cob_pac
go

if exists (select 1 from sysobjects where name = 'sp_tr_datos_adicionales_busin')
   drop proc sp_tr_datos_adicionales_busin
go

create proc sp_tr_datos_adicionales_busin (

     @s_ssn             int         = null,
     @s_user            login       = null,
     @s_sesn            int         = null,
     @s_term            varchar(30) = null,
     @s_date            datetime    = null,
     @s_srv             varchar(30) = null,
     @s_lsrv            varchar(30) = null,
     @s_rol             smallint    = NULL,
     @s_ofi             smallint    = NULL,
     @s_org_err         char(1)     = NULL,
     @s_error           int         = NULL,
     @s_sev             tinyint     = NULL,
     @s_msg             descripcion = NULL,
     @s_org             char(1)     = NULL,
     @t_rty             char(1)     = null,
     @t_trn             smallint    = null,
     @t_debug           char(1)     = 'N',
     @t_file            varchar(14) = null,
     @t_from            varchar(30) = null,
     @t_show_version    bit         = 0, -- Mostrar la version del programa
     @i_operacion       char(1),
     @i_tramite         int,
     @i_tipo_cartera    catalogo    = null,
     @i_destino_descripcion descripcion   =null,  --JMA, 02-Marzo-2015
     @i_patrimonio         money=null,            --JMA, 02-Marzo-2015
     @i_ventas               money=null,            --JMA, 02-Marzo-2015
     @i_num_personal_ocupado    int=null,         --JMA, 02-Marzo-2015
     @i_tipo_credito catalogo =  null,
     @i_indice_tamano_actividad float=null,       --JMA, 02-Marzo-2015
     @i_objeto catalogo = null,                   --JMA, 02-Marzo-2015
     @i_actividad catalogo = null,                    --JMA, 02-Marzo-2015
     @i_descripcion_oficial descripcion= null,           --JMA, 02-Marzo-2015
     @i_ventas_anuales         money         = null,    --NMA, 10-Abril-2015
     @i_activos_productivos money         = null,     --NMA, 10-Abril-2015

     @i_level_indebtedness   char(1)      = null,   --DCA
     @i_asigna_fecha_cic     char(1)      =null,

     @i_convenio             char(1)      = null,
     @i_codigo_cliente_empresa  varchar(10)          = null,
     @i_reprogramingObserv  varchar(255)          = null,
     @i_motivo_uno  varchar(255)          = null,
     @i_motivo_dos  varchar(255)          = null,
     @i_motivo_rechazo       catalogo     = null,
     @i_tamanio_empresa      varchar(5)   = null,
     @i_producto_fie         catalogo     = null,
     @i_num_viviendas        tinyint      = null,
     @i_calificacion         catalogo     = null,
     @i_es_garantia_destino  char(1)      = null,

     @o_tipo_cartera    catalogo    = null out,
     @o_destino_descripcion descripcion = null   out,  --JMA, 02-Marzo-2015
     @o_mes_cic            int = null out,               --JMA, 02-Marzo-2015
     @o_anio_cic            int = null out,               --JMA, 02-Marzo-2015
     @o_patrimonio         money = null out,            --JMA, 02-Marzo-2015
     @o_ventas               money = null out,            --JMA, 02-Marzo-2015
     @o_num_personal_ocupado    int = null out,         --JMA, 02-Marzo-2015
     @o_tipo_credito catalogo = null  out,
     @o_indice_tamano_actividad float = null out,       --JMA, 02-Marzo-2015
     @o_objeto catalogo = null  out,                   --JMA, 02-Marzo-2015
     @o_actividad catalogo = null out,                    --JMA, 02-Marzo-2015
     @o_descripcion_oficial descripcion = null  out,          --JMA, 02-Marzo-2015
     @o_ventas_anuales         money         = null  out,    --NMA, 10-Abril-2015
     @o_activos_productivos money         = null  out,     --NMA, 10-Abril-2015
     @o_level_indebtedness  char(1)  =null  out,
     @o_convenio                    char(1)      = null  out,
     @o_codigo_cliente_empresa     varchar(10)  = null  out,
     @o_reprogramingObserv     varchar(255)  = null  out,
     @o_motivo_uno             varchar(255)  = null  out,  -- ADCH, 05/10/2015 motivo para tipo de solicitud
     @o_motivo_dos             varchar(255)  = null  out,   -- ADCH, 05/10/2015 motivo para tipo de solicitud
     @o_motivo_rechazo         catalogo      = null  out,
     @o_producto_fie           catalogo      = null  out,
     @o_num_viviendas          tinyint       = null  out,
     @o_tipo_calificacion      catalogo      = null  out,
     @o_calificacion           catalogo      = null  out,
     @o_es_garantia_destino    char(1)       = null  out,
     @o_es_deudor_propietario  char(1)       = null  out,
	 @o_tamanio_empresa        varchar(10)   = null  out
)
as

declare @w_return       int,
        @w_numero       int,
        @w_sp_name      varchar(30),
        @w_existe       tinyint,
        @w_tabla        varchar(50),
        @w_operacion    int,
        @w_tipo_campo   varchar(30),
        @w_mes_cic      int,
        @w_anio_cic     int

-------VERSIONAMIENTO DEL PROGRAMA---------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_tr_datos_adicionales_busin, Version 4.0.0.0'
    return 0
end
--------------------------------------------------------------

select @w_return = 0
select @w_sp_name= 'sp_tr_datos_adicionales_busin'

print 'i_operacion %1!;t_trn %2!' + @i_operacion + @t_trn
-- Codigos de Transacciones
if @t_trn <> 21118
begin --Tipo de transaccion no corresponde
   select @w_return = 2101006
   goto ERROR
end
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if   @i_tramite = NULL
    begin
        --Campos NOT NULL con valores nulos
        select @w_return = 2101001
        goto ERROR
    end
end


/*select     @w_codigo_cliente_empresa    =    en_ente
from cobis..cl_ente,cobis..cl_ente_aux
where en_ente=ea_ente
and ea_cliente_planilla = 'S'
and en_subtipo = 'C'
and en_ente=@i_codigo_cliente_empresa*/


-- Chequeo de Existencias
if @i_operacion <> 'S'
begin
    if exists(select  1 from cob_credito..cr_tr_datos_adicionales
              where tr_tramite = @i_tramite)
            select @w_existe = 1
    else
            select @w_existe = 0
end


if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_asigna_fecha_cic = 'S'
    begin
        select @w_anio_cic = convert(int,pa_char) from cobis..cl_parametro where pa_nemonico = 'ACIC' and pa_producto = 'CRE'
        select @w_mes_cic = convert(int,pa_char) from cobis..cl_parametro where pa_nemonico = 'MCIC' and pa_producto = 'CRE'
    end
end

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
       --Registro ya existe */
       select @w_return = 2101002
       goto ERROR
    end
    begin tran
        insert into cob_credito..cr_tr_datos_adicionales (tr_tramite, tr_tipo_cartera,tr_mes_cic, tr_anio_cic,
            tr_patrimonio, tr_ventas, tr_num_personal_ocupado, tr_indice_tamano_actividad,
            tr_objeto, tr_actividad, tr_destino_descripcion,  tr_descripcion_oficial ,tr_tipo_credito,tr_nivel_endeuda,tr_convenio,tr_codigo_convenio,tr_observacion_reprog,
            tr_motivo_uno, tr_motivo_dos, tr_motivo_rechazo, tr_tamano_empresa,  tr_producto_fie, tr_num_viviendas )
        values(@i_tramite,@i_tipo_cartera,@w_mes_cic,@w_anio_cic,
            @i_patrimonio, @i_ventas,  @i_num_personal_ocupado, @i_indice_tamano_actividad,
            @i_objeto, @i_actividad ,     @i_destino_descripcion ,  @i_descripcion_oficial ,@i_tipo_credito, @i_level_indebtedness,@i_convenio,@i_codigo_cliente_empresa,@i_reprogramingObserv,
            @i_motivo_uno, @i_motivo_dos, @i_motivo_rechazo, @i_tamanio_empresa, @i_producto_fie, @i_num_viviendas )

        if @@error !=  0
        begin
            --error en insercion
            select @w_return = 2103001
            goto ERROR
        end


        --si aplica insertar datos en CCA
        --if exists(select 1 from cr_tramite where tr_producto = 'CCA' and tr_tramite = @i_tramite)
        --begin
        --        select @w_operacion = op_operacion from cob_cartera..ca_operacion where op_tramite = @i_tramite

        --        if not exists (select 1 from cob_cartera..ca_op_datos_adicionales where  op_operacion = @w_operacion)
        --        begin
        --            insert into cob_cartera..ca_op_datos_adicionales(op_operacion, op_tipo_cartera)
        --            values(@w_operacion, @i_tipo_cartera)

        --            if @@error !=  0
        --            begin
                        --error en insercion
        --                select @w_return = 2103001
        --                goto ERROR
        --            end
        --       end
        --       else
        --       begin
        --            update cob_cartera..ca_op_datos_adicionales
        --            set   op_tipo_cartera = @i_tipo_cartera
        --            where op_operacion = @w_operacion

        --            if @@error !=  0
        --            begin
                        --Error en Actualizacion
        --                select @w_return = 2105001
        --                goto ERROR
        --            end
        --       end
        -- end
    commit tran
end

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
       -- Registro a actualizar no existe
       select @w_return = 2105002
       goto ERROR
       return 1
    end
    begin tran
    update cob_credito..cr_tr_datos_adicionales
    set   tr_tipo_cartera = isnull(@i_tipo_cartera,tr_tipo_cartera),
      tr_mes_cic= isnull(@w_mes_cic,tr_mes_cic),
      tr_anio_cic= isnull(@w_anio_cic,tr_anio_cic),
      tr_patrimonio= isnull(@i_patrimonio,tr_patrimonio),
      tr_ventas = isnull(@i_ventas,tr_ventas),
      tr_num_personal_ocupado = isnull(@i_num_personal_ocupado,tr_num_personal_ocupado),
      tr_indice_tamano_actividad=isnull(@i_indice_tamano_actividad,tr_indice_tamano_actividad),
      tr_objeto = isnull(@i_objeto,tr_objeto),
      tr_actividad =isnull(@i_actividad,tr_actividad),
      tr_destino_descripcion =isnull(@i_destino_descripcion,tr_destino_descripcion),
      tr_descripcion_oficial=isnull(@i_descripcion_oficial,tr_descripcion_oficial)    ,
      tr_tipo_credito =isnull(@i_tipo_credito,tr_tipo_credito),
      tr_ventas_anuales = isnull(@i_ventas_anuales,tr_ventas_anuales),    --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales
      tr_activos_productivos = isnull(@i_activos_productivos,tr_activos_productivos),    --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales
      tr_nivel_endeuda=isnull(@i_level_indebtedness,tr_nivel_endeuda),   --DCA
      tr_convenio=isnull(@i_convenio,tr_convenio),
      tr_codigo_convenio=isnull(@i_codigo_cliente_empresa,tr_codigo_convenio),
      tr_observacion_reprog=isnull(@i_reprogramingObserv,tr_observacion_reprog),
      tr_motivo_uno = isnull(@i_motivo_uno,tr_motivo_uno),       -- ADCH, 05/10/2015 motivo para tipo de solicitud
      tr_motivo_dos = isnull(@i_motivo_dos, tr_motivo_dos),       -- ADCH, 05/10/2015 motivo para tipo de solicitud
      tr_motivo_rechazo = isnull(@i_motivo_rechazo,tr_motivo_rechazo),
      tr_tamano_empresa = isnull(@i_tamanio_empresa,tr_tamano_empresa),
      tr_producto_fie   = case when @i_producto_fie='NULL' then null else isnull(@i_producto_fie,tr_producto_fie) end,
      tr_num_viviendas  = case when @i_num_viviendas=0 then 0 else isnull(@i_num_viviendas,tr_num_viviendas) end,
      tr_calificacion   = case when @i_calificacion='NULL' then null else isnull(@i_calificacion,tr_calificacion) end,
      tr_es_garantia_destino = case when @i_es_garantia_destino='X' then null else isnull(@i_es_garantia_destino,tr_es_garantia_destino) end
    where tr_tramite = @i_tramite

    if @@error !=  0
    begin
        --Error en Actualizacion
        select @w_return = 2105001
        goto ERROR
    end

     --si aplica actualizar datos en CCA
     --   if exists(select 1 from cr_tramite where tr_producto = 'CCA' and tr_tramite = @i_tramite)
     --   begin
     --       select @w_operacion = op_operacion from cob_cartera..ca_operacion where op_tramite = @i_tramite

     --       update cob_cartera..ca_op_datos_adicionales
     --       set   op_tipo_cartera = @i_tipo_cartera
     --       where op_operacion = @w_operacion

     -- if @@error !=  0
     --       begin
                --Error en Actualizacion
     --           select @w_return = 2105001
     --           goto ERROR
     --       end
    --end

    commit tran
end

if @i_operacion = 'D'
begin
    delete cob_credito..cr_tr_datos_adicionales
   where tr_tramite = @i_tramite

    if @@error !=  0
    begin
        --Error en eliminacion
        select @w_return = 2107001
        goto ERROR
    end

    --si aplica eliminar datos en CCA
  --  if exists(select * from cr_tramite where tr_producto = 'CCA' and tr_tramite = @i_tramite)
  --  begin
  --      select @w_operacion = op_operacion from cob_cartera..ca_operacion where op_tramite = @i_tramite

  --      delete cob_cartera..ca_op_datos_adicionales
  --      where op_operacion = @w_operacion

  --      if @@error !=  0
  --      begin
            --Error en Actualizacion
  --          select @w_return = 2105001
  --          goto ERROR
  --      end
  --  end

end

if @i_operacion = 'S'
begin

    select  @o_tipo_cartera=tr_tipo_cartera,
            @o_mes_cic=tr_mes_cic,
            @o_anio_cic = tr_anio_cic,
            @o_patrimonio=tr_patrimonio,
            @o_ventas=tr_ventas,
            @o_num_personal_ocupado=tr_num_personal_ocupado,
            @o_indice_tamano_actividad=tr_indice_tamano_actividad,
            @o_tipo_credito=tr_tipo_credito,
            @o_objeto=tr_objeto,
            @o_actividad= tr_actividad,
            @o_destino_descripcion = tr_destino_descripcion,
            @o_descripcion_oficial =tr_descripcion_oficial,
            @o_ventas_anuales = tr_ventas_anuales,        --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales
            @o_activos_productivos = tr_activos_productivos,        --NMA 10-Abr-2015 datos nuevos en tabla cr_tr_datos adicionales,
            @o_level_indebtedness=tr_nivel_endeuda,        --DCA
            @o_convenio    =tr_convenio,
            @o_codigo_cliente_empresa = tr_codigo_convenio,
            @o_reprogramingObserv     = tr_observacion_reprog,
            @o_motivo_uno             = tr_motivo_uno,       -- ADCH 05/10/2015 motivo para tipo de solicitud
            @o_motivo_dos             = tr_motivo_dos,        -- ADCH  05/10/2015 motivo para tipo de solicitud
            @o_motivo_rechazo         = tr_motivo_rechazo,
            @o_producto_fie           = tr_producto_fie,
            @o_num_viviendas          = tr_num_viviendas,
            @o_tipo_calificacion      = tr_tipo_calificacion,
            @o_calificacion           = tr_calificacion,
            @o_es_garantia_destino    = ltrim(tr_es_garantia_destino),
            @o_es_deudor_propietario  = ltrim(tr_es_deudor_propietario),
			@o_tamanio_empresa        = ltrim(rtrim(tr_tamano_empresa))
    from  cob_credito..cr_tr_datos_adicionales
    where tr_tramite = @i_tramite

    if @@rowcount =  0
    begin
        --Registro No existe
        select @w_return = 2101005
        goto ERROR
    end

end

return 0
ERROR:
   --Devolver mensaje de Error
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_return
   return @w_return                                                                                                                                                                                         
                                             



GO
