/***********************************************************************/
/*      Archivo:                        TrasladaInstancia.sql         */
/*      Stored procedure:               sp_traslada_cl_instancia     */
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
/* Realiza el paso de la tabla cl_instancia de cob_externos a cobis    */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*    FECHA             AUTOR                   RAZON                  */
/*    06/Sept/2016      Walther Toledo          Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_cl_instancia')
   drop proc sp_traslada_cl_instancia
go

create proc sp_traslada_cl_instancia
as
declare
  @w_conteo             int,
  @w_contador           int,
  @w_sp_name            varchar(60),
  @w_tabla              varchar(60),
  @w_comited            int,
  @w_ente_i             int,
  @w_ente_d             int,
  @w_nomcolumna         varchar(30),
  @w_relacion           smallint

select @w_sp_name    = 'sp_traslada_cl_instancia',
       @w_tabla      = 'cl_instancia',
       @w_nomcolumna = 'in_relacio,in_ente_i,in_ente_d'

select @w_conteo = count(1)
from   cl_instancia_mig
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

    select @w_ente_i   = in_ente_i, 
           @w_ente_d   = in_ente_d,
           @w_relacion = in_relacion
    from cob_externos..cl_instancia_mig
    where in_estado_mig = 'VE'

    if @w_ente_i <> 0 and @w_ente_d <> 0
    begin
        if exists (select 1 from cobis..cl_instancia 
                    where in_ente_i   = @w_ente_i 
                      and in_ente_d   = @w_ente_d
                      and in_relacion = @w_relacion)
        begin
            update cl_instancia_mig set in_estado_mig = 'ER'
             where in_ente_i   = @w_ente_i 
               and in_ente_d   = @w_ente_d 
               and in_relacion = @w_relacion

            insert into cl_log_mig
            select convert (varchar, in_relacion),
                    @w_tabla,
                    @w_sp_name,
                    @w_nomcolumna,
                    'in_relacion='+CONVERT(varchar(30),in_relacion)+
                    'in_ente_d='+CONVERT(varchar(30),in_ente_d)+
                    'in_ente_i='+CONVERT(varchar(30),in_ente_i),
                    167,
                    in_relacion
            from cl_instancia_mig
            where in_ente_i   = @w_ente_i 
              and in_ente_d   = @w_ente_d 
              and in_relacion = @w_relacion
        end
        else
        begin
            -- ------------------------------------------------------------------
            -- - Cargo tabla definitiva
            -- ------------------------------------------------------------------
            insert into cobis..cl_instancia(in_relacion,  in_ente_i,    in_ente_d,    in_lado,    in_fecha )
            select in_relacion,  in_ente_i,    in_ente_d,    in_lado,    in_fecha 
              from cl_instancia_mig x
             where in_ente_i   = @w_ente_i 
               and in_ente_d   = @w_ente_d 
               and in_relacion = @w_relacion
            if @@error <> 0
            begin
                insert into cl_log_mig
                select convert (varchar, in_relacion),
                        @w_tabla,
                        @w_sp_name,
                        @w_nomcolumna,
                        'in_relacion='+CONVERT(varchar(30),in_relacion)+
                        'in_ente_d='+CONVERT(varchar(30),in_ente_d)+
                        'in_ente_i='+CONVERT(varchar(30),in_ente_i),
                        168,
                        in_relacion
                 from cl_instancia_mig
                where in_ente_i   = @w_ente_i 
                  and in_ente_d   = @w_ente_d 
                  and in_relacion = @w_relacion

                update cl_instancia_mig 
                   set in_estado_mig = 'ER'
                 where in_ente_i   = @w_ente_i 
                   and in_ente_d   = @w_ente_d 
                   and in_relacion = @w_relacion
            end
            else
            begin
                update cl_instancia_mig 
                   set in_estado_mig = 'TR'
                 where in_ente_i   = @w_ente_i 
                   and in_ente_d   = @w_ente_d 
                   and in_relacion = @w_relacion
            end        
        end
    end
    else
    begin
        update cl_instancia_mig set in_estado_mig = 'ER'
         where in_ente_i   = @w_ente_i 
           and in_ente_d   = @w_ente_d 
           and in_relacion = @w_relacion
        
        insert into cl_log_mig
        select convert (varchar, in_relacion),
                @w_tabla,
                @w_sp_name,
                @w_nomcolumna,
                'in_relacion='+CONVERT(varchar(30),isnull(in_relacion,0))+
                'in_ente_d='+CONVERT(varchar(30),isnull(in_ente_d,0))+
                'in_ente_i='+CONVERT(varchar(30),isnull(in_ente_i,0)),
                169,
                in_relacion
         from cl_instancia_mig
        where in_ente_i   = @w_ente_i 
          and in_ente_d   = @w_ente_d 
          and in_relacion = @w_relacion
    end
    
select @w_contador = @w_contador + 1
select @w_comited = @w_comited + 1 

end
commit tran

return  0
go
