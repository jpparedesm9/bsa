/***********************************************************************/
/*      Archivo:                        TrasladaTrabajo.sql            */
/*      Stored procedure:               sp_traslada_cl_trabajo         */
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
/* Realiza el paso de la tabla cl_trabajo de cob_externos a cobis      */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/*      FECHA           AUTOR                   RAZON                  */
/*      25/08/2016      Ignacio Yupa            Emision Inicial        */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_cl_trabajo')
   drop proc sp_traslada_cl_trabajo
go

create proc sp_traslada_cl_trabajo
as
declare
  @w_conteo             int,
  @w_contador           int,
  @w_sp_name            varchar(60),
  @w_ente               int,
  @w_tabla              varchar(60),
  @w_comited            int,
  @w_ente_nuevo         int
  
select @w_sp_name = 'sp_traslada_cl_trabajo'  
select @w_conteo = count(*)
from   cl_trabajo_mig
where  tr_estado_mig = 'VE'

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
    
    select @w_ente = tr_persona, 
           @w_ente_nuevo = isnull(tr_ente_mig,0)
    from   cl_trabajo_mig
    where  tr_estado_mig = 'VE'

    if @w_ente_nuevo <> 0
    begin
        if exists (select 1 from cobis..cl_trabajo where tr_persona = @w_ente_nuevo)
        begin
            update cl_trabajo_mig 
            set tr_estado_mig = 'ER'
            where tr_persona = @w_ente
        end
        else
        begin
            -- ------------------------------------------------------------------
            -- - Cargo tabla definitiva
            -- ------------------------------------------------------------------
            insert into cobis..cl_trabajo (tr_persona,       tr_trabajo,      tr_empresa,        tr_cargo,              tr_sueldo, 
                               tr_moneda,        tr_tipo,         tr_fecha_registro, tr_fecha_modificacion, tr_vigencia, 
							   tr_fecha_ingreso, tr_fecha_salida, tr_verificado,     tr_funcionario,        tr_fecha_verificacion)
                        select tr_ente_mig,       tr_trabajo,      tr_empresa,        tr_cargo,              tr_sueldo, 
						       tr_moneda,        tr_tipo,         tr_fecha_registro, tr_fecha_modificacion, tr_vigencia, 
							   tr_fecha_ingreso, tr_fecha_salida, tr_verificado,     tr_funcionario,        tr_fecha_verificacion							   
                        from cl_trabajo_mig x
                        where tr_persona = @w_ente
            if @@error <> 0
            begin
                select @w_tabla = 'cl_trabajo'
                
                insert into cl_log_mig
                select convert (varchar, tr_persona),
                        @w_tabla,
                        @w_sp_name,
                        NULL,
                        'Error al momento de transferir dato a la cl_trabajo_mig',
                        160,
                        tr_persona
                from cl_trabajo_mig
                where tr_persona = @w_ente

                update cl_trabajo_mig set tr_estado_mig = 'ER'
                where tr_persona = @w_ente
            end
            else
            begin            
                update cl_trabajo_mig 
                set tr_estado_mig = 'TR'
                where tr_persona = @w_ente
            end
        end
    end
    else
    begin
        update cl_trabajo_mig 
        set tr_estado_mig = 'ER'
        where tr_persona = @w_ente

        select @w_tabla = 'cl_trabajo_mig'
        
        insert into cl_log_mig
        select convert (varchar, tr_persona),
                @w_tabla,
                @w_sp_name,
                'tr_ente_mig',
                'NO TIENE NUEVO ENTE ASIGNADO',
                160,
                tr_ente_mig
        from cl_trabajo_mig
        where tr_persona = @w_ente
    end
    
select @w_contador = @w_contador + 1
select @w_comited = @w_comited + 1 
end
commit tran

return  0

go
