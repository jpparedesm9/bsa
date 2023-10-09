
/************************************************************************/
/*  Archivo:                SP_ULTIMO_USUARIO.sp                        */
/*  Stored procedure:       SP_ULTIMO_USUARIO                           */
/*  Base de Datos:          cob_workflow                                */
/*  Producto:               Credito                                     */
/*  Fecha de Documentacion: 21/Marzo/2016                               */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*   Retorna el último usuario asignado en la solicitud y               */
/*   vuelva a asignarla al mismo usuario.                               */
/*   El distribuidor de carga asignará al último usuario en el ruteo    */
/*   del trámite independiente de su rol dentro del Workflow.           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*         FECHA            AUTOR           RAZON                       */
/*   21/Marzo/2016       Diego Castro                                   */
/* **********************************************************************/


use cob_workflow
go

if exists (select 1 from sysobjects where name = 'SP_ULTIMO_USUARIO')
   drop proc SP_ULTIMO_USUARIO
go

create proc SP_ULTIMO_USUARIO
(
  @i_id_inst_proc     int,
  @i_id_inst_act      int,
  @i_id_empresa       int,
  @i_id_proceso       smallint,
  @i_version_proc     smallint,
  @i_id_actividad     int,
  @i_oficina_asig     smallint,
  @i_id_rol_dest      int,
  @t_debug            char(1)  = 'N',
  @t_file             varchar(14) = null,
  @t_from             varchar(30) = null,
  @o_id_destinatario  int out
)
as
  declare @w_cod_resultado      smallint,
          @w_tramite            int,
          @w_oficina            smallint,
          @w_sp_name            varchar(32),
          @w_id_destinatario    int,
          @w_cargo_acr          tinyint,
          @w_instancia_padre    int,
          @w_destinatario_padre int,
          @w_contiue            int,
          @w_tipo_dest          varchar(5),
          @w_id_inst_act_parent int

--El número de trámite siempre se guarda en el io_campo_3
select @w_tramite = io_campo_3
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_tramite = 0
begin
   print 'No existe trámite a procesar'
   return 0
end

set @w_contiue = 0
set @w_tipo_dest = null
set @w_id_inst_act_parent = null
while(@w_contiue = 0)
begin
        --Obtengo la intancia padre de la actividad actual
        select @w_id_inst_act_parent = ia2.ia_id_inst_act,
               @w_tipo_dest = ia2.ia_tipo_dest
        from cob_workflow..wf_inst_actividad ia1
        inner join cob_workflow..wf_inst_actividad ia2 on ia1.id_inst_act_parent = ia2.ia_id_inst_act
        where ia1.ia_id_inst_act    = @i_id_inst_act

        if(@w_tipo_dest != 'PRO')
        begin
            select @w_destinatario_padre = aa_id_destinatario
            from cob_workflow..wf_inst_actividad
            inner join cob_workflow..wf_asig_actividad on ia_id_inst_act = aa_id_inst_act
            where ia_id_inst_proc = @i_id_inst_proc
              and ia_codigo_act   = @i_id_actividad
              and aa_estado       = 'COM'

            if @w_destinatario_padre is null
            begin
                --Obtengo el destinatario de la actividad padre
                select @w_destinatario_padre = aa_id_destinatario
                from cob_workflow..wf_inst_actividad
                inner join cob_workflow..wf_asig_actividad on ia_id_inst_act = aa_id_inst_act
                where ia_id_inst_act = @w_id_inst_act_parent
                and   aa_estado <> 'REA'
            end

            select @w_contiue = 1

        end
        else
        begin
            select @i_id_inst_act = @w_id_inst_act_parent
        end
end

if @w_destinatario_padre is not null
   select @o_id_destinatario = @w_destinatario_padre
else
begin
    --No se puede determinar siguiente estacion de trabajo
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 2101033
    return 1
end

return 0
go
