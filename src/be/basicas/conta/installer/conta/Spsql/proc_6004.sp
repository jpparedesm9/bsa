/************************************************************************/
/*  Archivo:                          proc_6004                         */
/*  Stored procedure:                 sp_proc_6004                      */
/*  Base de datos:                    cob_conta                         */
/*  Producto:                         contabilidad                      */
/*  Disenado por:                                                       */
/*  Fecha de escritura:               28-Marzo-2008                     */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                              PROPOSITO                               */
/*  Este programa procesa trae la descripciòn de los conceptos          */
/*  asociados al proceso 6004                                           */
/*                            MODIFICACIONES                            */
/*  FECHA        AUTOR          RAZON                                   */
/*  Marzo/2008                  Emision Inicial                         */
/************************************************************************/

use cob_conta
go
if exists (select 1 from cob_conta..sysobjects
           where name = 'sp_proc_6004' and xtype = 'P')
     drop proc sp_proc_6004
go

create proc sp_proc_6004
(
     @i_empresa   int
)
as
declare @w_codigo   char(4),
        @w_count    int

truncate table cob_conta..cb_cuenta6004

select codigo 
into #cb_catalogo
from cobis..cl_catalogo
where tabla = (select codigo 
               from cobis..cl_tabla
               where tabla like 'cb_tipo_impuesto')

select @w_count = 0

while 1 = 1
begin
        set rowcount 1
        select @w_codigo = codigo
        from #cb_catalogo

        if @@rowcount = 0
             break

        select @w_count = @w_count + 1

        set rowcount 0

        select condicion = cp_condicion,
               cuenta    = cp_cuenta
        into #cb_cptmp
        from cob_conta..cb_cuenta_proceso
        where cp_proceso = 6095
        and   cp_condicion = @w_codigo

        insert into cb_cuenta6004
        select 6004,
               cp_cuenta,
               isnull(convert(char(4),cp_oficina),0),
               isnull(convert(char(4),cp_area),0),
               cp_condicion, 
               cp_imprima,
               dbo.cp_descripcion (@w_codigo,cp_condicion),
               cp_texto
        from cob_conta..cb_cuenta_proceso
        where  cp_cuenta in (select cuenta from #cb_cptmp)
        and    cp_proceso = 6004

        delete from #cb_catalogo
        where codigo = @w_codigo 

        drop table #cb_cptmp
end


return 0

go
