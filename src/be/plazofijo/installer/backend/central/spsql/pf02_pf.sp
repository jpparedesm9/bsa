/************************************************************************/
/*    Archivo:                pf02_pf.sp                                */
/*    Stored procedure:       sp_pf02_pf                                */
/*    Base de datos:          cob_pfijo                                 */
/*    Producto:               Depositos a Plazo Fijo                    */
/************************************************************************/
/*                             IMPORTANTE                               */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "COBISCORP".                                                      */
/*    Su uso no autorizado  queda  expresamente  prohibido asi como     */
/*    cualquier  alteracion  o  agregado  hecho  por  alguno de sus     */
/*    usuarios  sin  el  debido  consentimiento  por  escrito de la     */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Despliega para las pantallas de perfiles contables en el modulo   */
/*    de Contabilidad COBIS los valores que pueden tomar los criterios  */
/*    contables de MONEDA, FORMA DE PAGO                                */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/************************************************************************/

use cob_pfijo  
go

if exists (select * from sysobjects where name = 'sp_pf02_pf')
   drop proc sp_pf02_pf
go
 

create proc sp_pf02_pf(
@i_criterio tinyint     = null,
@i_codigo   varchar(30) = null)

as

declare
@w_return         int,
@w_sp_name        varchar(32),
@w_tabla          smallint,
@w_codigo         varchar(30),
@w_criterio       tinyint

select @w_sp_name = 'sp_pf02_pf'

/* LA 1A VEZ ENVIA LAS ETIQUETAS QUE APARECERAN EN LOS CAMPOS DE LA FORMA */
if @i_criterio is null begin
   select
   'Forma de Pago',
   'Moneda',
   'Cuenta'
end

select @w_codigo   = isnull(@i_codigo, '')
select @w_criterio = isnull(@i_criterio, 0)

/* TABLA TEMPORAL PARA LLENAR LOS DATOS DE TODOS LOS DATOS DEL F5 AL CARGAR LA PANTALLA */
create table #pf_catalogo(
ca_tabla       tinyint,
ca_codigo      varchar(10),
ca_descripcion varchar(50))

/* FORMA DE PAGO */
if @w_criterio <= 1 begin
   insert into #pf_catalogo
   select 1, fp_mnemonico, fp_descripcion
   from  pf_fpago
   where fp_estado = 'A'

   if @@error <> 0 return 710001
end

/* MONEDA */
if @w_criterio <= 2 begin
   insert into #pf_catalogo
   select 2, cat.codigo, cat.valor
   from   cobis..cl_tabla tab, cobis..cl_catalogo cat
   where  tab.tabla  = 'cl_moneda'
   and    tab.codigo = cat.tabla

   if @@error <> 0 return 710001   
end

/* CUENTA PARA CHEQUE */
if @w_criterio <= 3 begin

     select distinct 3, ec_cuenta, cat.valor
     from cob_pfijo..pf_emision_cheque,
          cobis..cl_tabla tab,
          cobis..cl_catalogo cat
     where ec_banco   = cat.codigo
       and tab.tabla  = 'pf_institucion_financiera'
       and tab.codigo = cat.tabla
   
   if @@error <> 0 return 710001   

end


/* RETORNA LOS DATOS AL FRONT-END */
select ca_tabla, ca_codigo, ca_descripcion
from   #pf_catalogo
where  ca_tabla   > @w_criterio
or    (ca_tabla  = @w_criterio and ca_codigo > @w_codigo)
order by ca_tabla, ca_codigo

return 0

go

