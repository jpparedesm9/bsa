/***********************************************************************/
/*      Archivo:                        TrasladaDireccion.sql          */
/*      Stored procedure:               sp_traslada_cl_direccion       */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/********************************************************************** */
/*                      PROPOSITO                                       */
/* Realiza el paso de la tabla cl_direccion de cob_externos a cobis     */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/********************************************************************** */
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_cl_direccion')
   drop proc sp_traslada_cl_direccion
go

create proc sp_traslada_cl_direccion
as
declare
  @w_conteo             int,
  @w_contador           int,
  @w_sp_name            varchar(60),
  @w_ente               int,
  @w_tabla              varchar(60),
  @w_comited            int,
  @w_ente_nuevo         int

select @w_sp_name = 'sp_traslada_cl_direccion'    

select @w_conteo = count(*)
from   cl_direccion_mig
where di_estado_mig = 'VE'

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
    
    select @w_ente = di_ente, 
           @w_ente_nuevo = isnull(di_ente_mig,0)
    from   cl_direccion_mig
    where di_estado_mig = 'VE'

    if @w_ente_nuevo <> 0
    begin
        if exists (select 1 from cobis..cl_direccion 
                    where di_ente = @w_ente_nuevo)
        begin
            update cl_direccion_mig set di_estado_mig = 'ER'
            where di_ente = @w_ente
        end
        else
        begin       
            --------------------------------------------------------------------
            --- Cargo tabla definitiva
            --------------------------------------------------------------------
            insert into cobis..cl_direccion(di_ente,      di_direccion,      di_descripcion,    di_parroquia, 
                                di_ciudad,    di_tipo,           di_telefono,       di_sector, 
								di_zona,      di_oficina,        di_fecha_registro, di_fecha_modificacion, 
								di_vigencia,  di_verificado,     di_funcionario,    di_fecha_ver, 
								di_principal, di_barrio,         di_provincia)
                         select di_ente_mig,      di_direccion,      di_descripcion,    di_parroquia, 
						        di_ciudad,    di_tipo,           di_telefono,       di_sector, 
								di_zona,      di_oficina,        di_fecha_registro, di_fecha_modificacion, 
								di_vigencia,  di_verificado,     di_funcionario,    di_fecha_ver, 
								di_principal, di_barrio,         di_provincia
								 
            from cl_direccion_mig
            where di_ente = @w_ente
            if @@error <> 0
            begin
                select @w_tabla = 'cl_direccion'
                insert into cl_log_mig
                    select convert (varchar, di_ente),
                    @w_tabla,
                    @w_sp_name,
                    NULL,
                    'Error al momento de transferir dato a la cl_direccion_mig',
                    160,
                    di_ente
                    from cl_direccion_mig
                    where di_ente = @w_ente

                update cl_direccion_mig 
                set di_estado_mig = 'ER'
                where di_ente = @w_ente
            end
            else
            begin
                update cl_direccion_mig 
                set di_estado_mig = 'TR'
                where di_ente = @w_ente
            end           
        end
    end
    else
    begin
        update cl_direccion_mig 
        set di_estado_mig = 'ER'
        where di_ente = @w_ente
        
        select @w_tabla = 'cl_direccion_mig'
        
        insert into cl_log_mig
            select convert (varchar, di_ente),
            @w_tabla,
            @w_sp_name,
            'di_ente_mig',
            'NO TIENE NUEVO ENTE ASIGNADO',
            160,
            di_ente_mig
        from cl_direccion_mig
        where di_ente = @w_ente
    end
    
    select @w_contador = @w_contador + 1
    select @w_comited = @w_comited + 1 
end--while
commit tran

return  0

go
