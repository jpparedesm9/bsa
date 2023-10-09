/***********************************************************************/
/*      Archivo:                        TrasladaTrabajo.sql            */
/*      Stored procedure:               sp_traslada_cl_refinh          */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza el paso de la tabla cl_refinh de cob_externos a cobis       */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_cl_refinh')
   drop proc sp_traslada_cl_refinh
go

create proc sp_traslada_cl_refinh
as
declare
  @w_conteo             int,
  @w_contador           int,
  @w_sp_name            varchar(60),
  @w_ente               int,
  @w_tabla              varchar(60),
  @w_comited            int,
  @w_ced_ruc            CHAR (13),
  @w_subtipo            CHAR (1),
  @w_nomcolumna         varchar(30)

  
select @w_sp_name = 'sp_traslada_cl_refinh'  

select @w_conteo = count(*)
from   cl_refinh_mig
where  in_estado_mig = 'VE'

if @w_conteo = 0
   return 0

select @w_contador = 0,
       @w_comited  = 0

begin tran
while not @w_contador = @w_conteo
begin   

    if @w_comited = 1000
    begin
        select @w_comited = 0
        commit tran
        select @@TRANCOUNT
        begin tran
    end
    
    select  @w_ced_ruc = in_ced_ruc,
            @w_subtipo = in_subtipo,
            @w_ente    = in_codigo
    from   cl_refinh_mig
    where  in_estado_mig = 'VE'

        if exists (select 1 from cobis..cl_refinh 
                   where in_ced_ruc = @w_ced_ruc
                   and in_subtipo = @w_subtipo)
        begin
            update cl_refinh_mig 
            set in_estado_mig = 'ER'
            where in_codigo = @w_ente
        end
        else
        begin
        -- ------------------------------------------------------------------
        -- - Cargo tabla definitiva
        -- ------------------------------------------------------------------
            select @w_tabla = 'cl_refinh'
            insert into cobis..cl_refinh (
                              in_codigo,        in_ced_ruc,     
                              in_nombre,        in_fecha_ref,           in_origen,      
                              in_observacion,   in_fecha_mod,           in_subtipo,     
                              in_p_p_apellido,  in_p_s_apellido,        in_tipo_ced,    
                              in_nomlar,        in_estado,              in_sexo,        
                              in_entid )
            select  in_codigo,        in_ced_ruc,     
                    in_nombre,        in_fecha_ref,           in_origen,      
                    in_observacion,   in_fecha_mod,           in_subtipo,     
                    in_p_p_apellido,  in_p_s_apellido,        in_tipo_ced, 
                    in_nomlar,        in_estado,              in_sexo,                      
                    in_entid 
            from cl_refinh_mig x
            where in_codigo = @w_ente
            if @@error <> 0
            begin
                insert into cl_log_mig
                select convert (varchar, in_entid),
                       @w_tabla,
                       @w_sp_name,
                       NULL,
                       'Error al momento de transferir dato a la cl_refinh_mig',
                       160,
                       in_entid
                from cl_refinh_mig
                where in_codigo = @w_ente

                update cl_refinh_mig 
                set in_estado_mig = 'ER'
                where in_codigo = @w_ente
            end
            else
            begin
                update cl_refinh_mig 
                set in_estado_mig = 'TR'
                where in_codigo = @w_ente
                
                select @w_nomcolumna = 'in_tipo_ced,in_ced_ruc'
                update cobis..cl_ente 
                   set en_mala_referencia = 'S'
                  from cobis..cl_ente 
                 inner join cobis..cl_refinh
                    on en_ced_ruc=in_ced_ruc 
                  and en_tipo_ced = in_tipo_ced
                 where in_codigo = @w_ente
                if @@error <> 0
                begin
                    insert into cl_log_mig
                    select convert (varchar, in_entid),
                           @w_tabla,
                           @w_sp_name,
                           @w_nomcolumna,
                           in_tipo_ced+', '+in_ced_ruc,
                           175,
                           in_entid
                    from cl_refinh_mig
                    where in_codigo = @w_ente

                    update cl_refinh_mig 
                    set in_estado_mig = 'ER'
                    where in_codigo = @w_ente
                end
            end
        end
    
select @w_contador = @w_contador + 1
select @w_comited = @w_comited + 1 

end
commit tran

return  0
go

